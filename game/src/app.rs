//! The windowed application: SDL2 window + wgpu surface, fixed-timestep logic with
//! interpolated rendering, keyboard / mouse / gamepad input.
use crate::audio::Audio;
use crate::gfx::{Renderer, Target};
use crate::level;
use crate::render::{self, Scene};
use crate::save::Save;
use crate::texts::Lang;
use crate::ui::{Ui, STAGE_H, STAGE_W, TICK_HZ};
use anyhow::{anyhow, Result};
use std::path::PathBuf;
use std::time::{Duration, Instant};

pub struct Options {
    pub assets: PathBuf,
    pub repo: PathBuf,
    pub level: Option<u32>,
    pub fullscreen: bool,
    pub mute: bool,
    pub max_seconds: Option<f32>,
    pub lang: Lang,
    pub debug: bool,
    pub unlock_all: bool,
    /// lock presentation to the display's refresh rate
    pub vsync: bool,
    /// frame-rate cap (0 = none)
    pub max_fps: u32,
    /// show the frame rate in the window title
    pub show_fps: bool,
}

/// Default frame-rate cap.
pub const DEFAULT_FPS: u32 = 240;

/// Without vsync: Mailbox (no tearing, never waits for the display) where the driver has it,
/// otherwise Immediate. With vsync, or if neither exists: Fifo, which every driver supports.
fn pick_present_mode(modes: &[wgpu::PresentMode], vsync: bool) -> wgpu::PresentMode {
    use wgpu::PresentMode as P;
    if !vsync {
        for m in [P::Mailbox, P::Immediate] {
            if modes.contains(&m) {
                return m;
            }
        }
    }
    if modes.contains(&P::FifoRelaxed) && vsync {
        return P::FifoRelaxed;
    }
    P::Fifo
}

/// Sleeps until `t`: the OS sleep for most of the wait, then a short spin, because a plain sleep
/// can overshoot by more than the whole frame budget at 240 fps.
fn sleep_until(t: Instant) {
    let margin = if cfg!(windows) { Duration::from_micros(1500) } else { Duration::from_micros(400) };
    loop {
        let now = Instant::now();
        if now >= t {
            return;
        }
        let left = t - now;
        if left > margin {
            std::thread::sleep(left - margin);
        } else {
            std::thread::yield_now();
        }
    }
}

/// Owned, thread-safe copy of the window system's display connection (needed by wgpu 30).
#[derive(Debug)]
struct DisplayHandle(raw_window_handle::RawDisplayHandle);
unsafe impl Send for DisplayHandle {}
unsafe impl Sync for DisplayHandle {}
impl raw_window_handle::HasDisplayHandle for DisplayHandle {
    fn display_handle(&self) -> Result<raw_window_handle::DisplayHandle<'_>, raw_window_handle::HandleError> {
        Ok(unsafe { raw_window_handle::DisplayHandle::borrow_raw(self.0) })
    }
}

pub fn run(opt: Options) -> Result<()> {
    let sdl = sdl2::init().map_err(|e| anyhow!(e))?;
    let video = sdl.video().map_err(|e| anyhow!(e))?;
    let mut window = video
        .window("Mission in Snowdriftland", 1080, (1080.0 * STAGE_H / STAGE_W) as u32)
        .position_centered()
        .resizable()
        .allow_highdpi()
        .build()?;
    window.set_minimum_size(450, 289).ok();
    if opt.fullscreen {
        let _ = window.set_fullscreen(sdl2::video::FullscreenType::Desktop);
    }
    let raw_display = {
        use raw_window_handle::HasDisplayHandle;
        window.display_handle()?.as_raw()
    };
    let instance = wgpu::Instance::new(wgpu::InstanceDescriptor::new_with_display_handle_from_env(Box::new(DisplayHandle(raw_display))));
    let surface: wgpu::Surface<'static> = unsafe { instance.create_surface_unsafe(wgpu::SurfaceTargetUnsafe::from_window(&window)?)? };
    let adapter = pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions {
        power_preference: wgpu::PowerPreference::HighPerformance,
        compatible_surface: Some(&surface),
        ..Default::default()
    }))
    .map_err(|e| anyhow!("no suitable GPU: {e}"))?;
    log::info!("GPU: {}", adapter.get_info().name);
    let (device, queue) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor::default()))?;
    let caps = surface.get_capabilities(&adapter);
    let format = caps.formats.iter().copied().find(|f| !f.is_srgb()).unwrap_or(caps.formats[0]);
    let present_mode = pick_present_mode(&caps.present_modes, opt.vsync);
    let frame_period = (opt.max_fps > 0).then(|| Duration::from_secs_f64(1.0 / opt.max_fps as f64));
    log::info!("present mode {present_mode:?} (available {:?}), frame cap {}", caps.present_modes, if opt.max_fps > 0 { opt.max_fps.to_string() } else { "none".into() });
    let (pw, ph) = window.drawable_size();
    let mut config = wgpu::SurfaceConfiguration {
        usage: wgpu::TextureUsages::RENDER_ATTACHMENT,
        format,
        width: pw.max(1),
        height: ph.max(1),
        present_mode,
        desired_maximum_frame_latency: 2,
        alpha_mode: caps.alpha_modes[0],
        view_formats: vec![],
        color_space: wgpu::SurfaceColorSpace::Auto,
    };
    surface.configure(&device, &config);
    let mut target = Target::new(&device, config.width, config.height, format);
    let rd = Renderer::new(device, queue);

    let audio = if opt.mute { Audio::new(None) } else { Audio::new(Some(&sdl)) };
    let gc_sys = sdl.game_controller().ok();
    let mut pads = Vec::new();
    if let Some(g) = &gc_sys {
        for i in 0..g.num_joysticks().unwrap_or(0) {
            if g.is_game_controller(i) {
                if let Ok(c) = g.open(i) {
                    pads.push(c);
                }
            }
        }
    }
    if opt.unlock_all {
        let mut s = Save::load();
        s.intro = true;
        s.test_unlock(24, true);
    }
    let mut ui = Ui::new(rd, audio, opt.assets.clone(), opt.repo.clone(), opt.lang, opt.debug)?;
    if let Some(n) = opt.level {
        ui.start_worldmap();
        ui.show_topic(Some("game"), n);
    }
    let cursors = (
        sdl2::mouse::Cursor::from_system(sdl2::mouse::SystemCursor::Arrow).ok(),
        sdl2::mouse::Cursor::from_system(sdl2::mouse::SystemCursor::Hand).ok(),
    );
    let mut hand = false;
    let mut events = sdl.event_pump().map_err(|e| anyhow!(e))?;
    let (mut left, mut right, mut up, mut down) = (false, false, false, false);
    let tick = 1.0 / TICK_HZ as f64;
    let mut acc = 0.0f64;
    let mut last = Instant::now();
    let started = Instant::now();
    let resize_test = std::env::var("SNOWDRIFT_RESIZE_TEST").is_ok();
    let mut frame_no = 0u64;
    let mut next_frame = Instant::now();
    let (mut fps_frames, mut fps_since) = (0u32, Instant::now());
    // time spent waiting for a swapchain image vs. building and submitting the frame
    let (mut t_wait, mut t_cpu) = (Duration::ZERO, Duration::ZERO);
    'main: loop {
        for e in events.poll_iter() {
            // window -> stage coordinates with the swapchain size as it is right now
            let to_stage = |x: i32, y: i32| {
                let vp = render::fit_viewport(config.width, config.height, STAGE_W, STAGE_H);
                let (ww, wh) = window.size();
                let (sx, sy) = (config.width as f32 / ww.max(1) as f32, config.height as f32 / wh.max(1) as f32);
                ((x as f32 * sx - vp[0]) / vp[2].max(1.0) * STAGE_W, (y as f32 * sy - vp[1]) / vp[3].max(1.0) * STAGE_H)
            };
            use sdl2::event::{Event, WindowEvent};
            use sdl2::keyboard::Keycode as K;
            match e {
                Event::Quit { .. } => break 'main,
                Event::KeyDown { keycode: Some(k), repeat: false, .. } => match k {
                    K::Escape => {
                        if ui.topic == "worldmap" && ui.game.is_none() {
                            break 'main;
                        }
                        if ui.topic == "lab" {
                            ui.close_lab(true);
                        } else {
                            ui.show_topic(Some("worldmap"), 0);
                        }
                    }
                    K::F11 | K::Return if k == K::F11 || sdl2::keyboard::Mod::LALTMOD.intersects(sdl.keyboard().mod_state()) => {
                        let fs = window.fullscreen_state();
                        let _ = window.set_fullscreen(if fs == sdl2::video::FullscreenType::Off { sdl2::video::FullscreenType::Desktop } else { sdl2::video::FullscreenType::Off });
                    }
                    K::Left | K::A => left = true,
                    K::Right | K::D => right = true,
                    K::Up | K::W | K::Space => up = true,
                    K::Down | K::S => down = true,
                    _ => {}
                },
                Event::KeyUp { keycode: Some(k), .. } => match k {
                    K::Left | K::A => left = false,
                    K::Right | K::D => right = false,
                    K::Up | K::W | K::Space => up = false,
                    K::Down | K::S => down = false,
                    _ => {}
                },
                Event::MouseMotion { x, y, .. } => {
                    let (mx, my) = to_stage(x, y);
                    ui.mouse_moved(mx, my);
                }
                Event::MouseButtonDown { mouse_btn: sdl2::mouse::MouseButton::Left, x, y, .. } => {
                    let (mx, my) = to_stage(x, y);
                    ui.mouse_moved(mx, my);
                    ui.mouse_pressed();
                }
                Event::MouseButtonUp { mouse_btn: sdl2::mouse::MouseButton::Left, .. } => ui.mouse_released(),
                Event::MouseWheel { y, .. } => ui.wheel(y),
                Event::Window { win_event: WindowEvent::SizeChanged(..) | WindowEvent::Resized(..), .. } => {
                    // handled below, right before drawing (also catches size changes without an event)
                }
                _ => {}
            }
        }
        if hand != ui.cursor_hand {
            hand = ui.cursor_hand;
            if let Some(c) = if hand { &cursors.1 } else { &cursors.0 } {
                c.set();
            }
        }
        use sdl2::controller::{Axis, Button};
        let (mut pl, mut pr, mut pu, mut pd) = (false, false, false, false);
        for p in &pads {
            let ax = p.axis(Axis::LeftX) as i32;
            let ay = p.axis(Axis::LeftY) as i32;
            pl |= p.button(Button::DPadLeft) || ax < -12000;
            pr |= p.button(Button::DPadRight) || ax > 12000;
            pu |= p.button(Button::A) || p.button(Button::B) || p.button(Button::DPadUp) || ay < -16000;
            pd |= p.button(Button::DPadDown) || ay > 16000;
        }
        let input = level::Input { left: left || pl, right: right || pr, up: up || pu, down: down || pd };

        let now = Instant::now();
        acc += (now - last).as_secs_f64().min(0.25);
        last = now;
        while acc >= tick {
            acc -= tick;
            ui.tick(&input);
        }
        if ui.quit {
            break;
        }
        if let Some(max) = opt.max_seconds {
            if started.elapsed().as_secs_f32() > max {
                break;
            }
        }
        // dev: stress window resizing (SNOWDRIFT_RESIZE_TEST)
        if resize_test {
            frame_no += 1;
            if frame_no % 3 == 0 {
                let sizes = [(1170u32, 715u32), (1143, 717), (640, 411), (1281, 777), (451, 290), (900, 578), (1919, 1003), (333, 999)];
                let (w, h) = sizes[(frame_no / 3) as usize % sizes.len()];
                let _ = window.set_size(w, h);
                if frame_no % 40 == 0 {
                    let fs = window.fullscreen_state();
                    let _ = window.set_fullscreen(if fs == sdl2::video::FullscreenType::Off { sdl2::video::FullscreenType::Desktop } else { sdl2::video::FullscreenType::Off });
                }
            }
        }
        // keep the swapchain and the render target at the window's drawable size
        let (dw, dh) = window.drawable_size();
        if dw == 0 || dh == 0 {
            // minimised: nothing to draw into
            std::thread::sleep(std::time::Duration::from_millis(16));
            continue;
        }
        if dw != config.width || dh != config.height {
            config.width = dw;
            config.height = dh;
            surface.configure(&ui.rd.device, &config);
            target = Target::new(&ui.rd.device, config.width, config.height, format);
        }
        let vp = render::fit_viewport(config.width, config.height, STAGE_W, STAGE_H);
        let t0 = Instant::now();
        let frame = match surface.get_current_texture() {
            wgpu::CurrentSurfaceTexture::Success(f) | wgpu::CurrentSurfaceTexture::Suboptimal(f) => f,
            _ => {
                surface.configure(&ui.rd.device, &config);
                continue;
            }
        };
        let t1 = Instant::now();
        let view = frame.texture.create_view(&Default::default());
        // video frames follow the audio clock, not the logic ticks
        ui.lab_frame();
        let alpha = (acc / tick) as f32;
        ui.rd.begin_frame();
        Scene { world: &ui.world, alpha }.render(&mut ui.rd, ui.world.root);
        let mut enc = ui.rd.device.create_command_encoder(&Default::default());
        ui.rd.flush(&mut enc, &target, Some(&view), Some(wgpu::Color::WHITE), render::stage_view(STAGE_W, STAGE_H), vp);
        ui.rd.queue.submit([enc.finish()]);
        ui.rd.queue.present(frame);
        t_wait += t1 - t0;
        t_cpu += t1.elapsed();

        if opt.show_fps {
            fps_frames += 1;
            let el = fps_since.elapsed();
            if el >= Duration::from_millis(500) {
                let fps = fps_frames as f64 / el.as_secs_f64();
                window.set_title(&format!("Mission in Snowdriftland ({fps:.0} fps)")).ok();
                log::info!("{fps:.1} fps, per frame: {:.2} ms drawing, {:.2} ms waiting for the swapchain", t_cpu.as_secs_f64() * 1e3 / fps_frames as f64, t_wait.as_secs_f64() * 1e3 / fps_frames as f64);
                (t_wait, t_cpu) = (Duration::ZERO, Duration::ZERO);
                fps_frames = 0;
                fps_since = Instant::now();
            }
        }
        if let Some(period) = frame_period {
            next_frame += period;
            let now = Instant::now();
            if next_frame > now {
                sleep_until(next_frame);
            } else if now - next_frame > period {
                // fell behind by more than a frame: start counting from here
                next_frame = now;
            }
        }
    }
    Ok(())
}
