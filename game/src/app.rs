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
use std::time::Instant;

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
    let (pw, ph) = window.drawable_size();
    let mut config = wgpu::SurfaceConfiguration {
        usage: wgpu::TextureUsages::RENDER_ATTACHMENT,
        format,
        width: pw.max(1),
        height: ph.max(1),
        present_mode: wgpu::PresentMode::AutoVsync,
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
    'main: loop {
        let vp = render::fit_viewport(config.width, config.height, STAGE_W, STAGE_H);
        let (ww, wh) = window.size();
        let (sx, sy) = (config.width as f32 / ww.max(1) as f32, config.height as f32 / wh.max(1) as f32);
        let to_stage = |x: i32, y: i32| ((x as f32 * sx - vp[0]) / vp[2] * STAGE_W, (y as f32 * sy - vp[1]) / vp[3] * STAGE_H);
        for e in events.poll_iter() {
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
                    let (w, h) = window.drawable_size();
                    config.width = w.max(1);
                    config.height = h.max(1);
                    surface.configure(&ui.rd.device, &config);
                    target = Target::new(&ui.rd.device, config.width, config.height, format);
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
        let frame = match surface.get_current_texture() {
            wgpu::CurrentSurfaceTexture::Success(f) | wgpu::CurrentSurfaceTexture::Suboptimal(f) => f,
            _ => {
                surface.configure(&ui.rd.device, &config);
                continue;
            }
        };
        let view = frame.texture.create_view(&Default::default());
        let alpha = (acc / tick) as f32;
        ui.rd.begin_frame();
        Scene { world: &ui.world, alpha }.render(&mut ui.rd, ui.world.root);
        let mut enc = ui.rd.device.create_command_encoder(&Default::default());
        ui.rd.flush(&mut enc, &target, Some(&view), Some(wgpu::Color::WHITE), render::stage_view(STAGE_W, STAGE_H), vp);
        ui.rd.queue.submit([enc.finish()]);
        ui.rd.queue.present(frame);
    }
    Ok(())
}
