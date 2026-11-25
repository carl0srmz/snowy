mod app;
mod assets;
mod audio;
mod gfx;
mod lab;
mod intro;
mod level;
mod scripts;
mod ui;
mod video;
mod save;
mod texts;
mod movie;
mod render;
mod text;

use anyhow::{anyhow, Result};
use std::path::PathBuf;

fn headless_renderer() -> Result<(gfx::Renderer, wgpu::Adapter)> {
    let instance = wgpu::Instance::new(wgpu::InstanceDescriptor::new_without_display_handle_from_env());
    let adapter = pollster::block_on(instance.request_adapter(&wgpu::RequestAdapterOptions {
        power_preference: wgpu::PowerPreference::HighPerformance,
        compatible_surface: None,
        force_fallback_adapter: false,
        ..Default::default()
    }))
    .map_err(|e| anyhow!("no GPU adapter: {e}"))?;
    log::info!("adapter: {:?}", adapter.get_info());
    let (device, queue) = pollster::block_on(adapter.request_device(&wgpu::DeviceDescriptor::default()))?;
    Ok((gfx::Renderer::new(device, queue), adapter))
}

/// `snowdrift shot <assets-dir> <library> <out.png> [--link name] [--frames n] [--scale s] [--frame f]`
fn cmd_shot(args: &[String]) -> Result<()> {
    let assets = PathBuf::from(&args[0]);
    let libname = args[1].clone();
    let out = PathBuf::from(&args[2]);
    let mut link: Option<String> = None;
    let mut ticks = 0u32;
    let mut scale = 1.0f32;
    let mut i = 3;
    while i < args.len() {
        match args[i].as_str() {
            "--link" => {
                link = Some(args[i + 1].clone());
                i += 1;
            }
            "--frames" => {
                ticks = args[i + 1].parse()?;
                i += 1;
            }
            "--scale" => {
                scale = args[i + 1].parse()?;
                i += 1;
            }
            _ => {}
        }
        i += 1;
    }
    let (mut rd, _adapter) = headless_renderer()?;
    let mut libs = assets::load_libraries(&mut rd, &assets, &[libname.as_str()], 0)?;
    let mut world = movie::World::new();
    let lib = world.add_lib(libs.remove(0));
    let mut host = movie::NullHost;
    let (sw, sh, bg);
    let target_clip;
    if let Some(l) = &link {
        let root = world.root;
        let id = world.attach_from(root, lib, l, "sym", 1, &mut host).ok_or_else(|| anyhow!("no export {}", l))?;
        let b = world.bounds_in(id, id).unwrap_or(snow_fmt::Rect { x0: 0.0, y0: 0.0, x1: 100.0, y1: 100.0 });
        world.clip_mut(id).unwrap().m = snow_fmt::Matrix::translate(-b.x0 + 10.0, -b.y0 + 10.0);
        sw = b.width() + 20.0;
        sh = b.height() + 20.0;
        bg = [0.5, 0.6, 0.7, 1.0];
        target_clip = world.root;
    } else {
        let root = world.root;
        world.load_into(root, lib);
        world.start_movie(root, &mut host);
        let st = world.libs[lib as usize].lib.stage;
        sw = st.width();
        sh = st.height();
        let b = world.libs[lib as usize].lib.background;
        bg = [b[0] as f32 / 255.0, b[1] as f32 / 255.0, b[2] as f32 / 255.0, 1.0];
        target_clip = root;
        let _ = st;
    }
    for _ in 0..ticks {
        world.advance(&mut host);
    }
    let (w, h) = ((sw * scale).ceil() as u32, (sh * scale).ceil() as u32);
    let target = gfx::Target::new(&rd.device, w, h, wgpu::TextureFormat::Rgba8Unorm);
    rd.begin_frame();
    render::Scene { world: &world, alpha: 1.0 }.render(&mut rd, target_clip);
    let mut enc = rd.device.create_command_encoder(&Default::default());
    rd.flush(
        &mut enc,
        &target,
        None,
        Some(wgpu::Color { r: bg[0] as f64, g: bg[1] as f64, b: bg[2] as f64, a: 1.0 }),
        render::stage_view(sw, sh),
        [0.0, 0.0, w as f32, h as f32],
    );
    rd.queue.submit([enc.finish()]);
    let img = gfx::read_target(&rd.device, &rd.queue, &target);
    img.save(&out)?;
    println!("rendered {}x{} -> {} ({} draws, {} tris)", w, h, out.display(), rd.stats.draws, rd.stats.tris);
    Ok(())
}

/// `snowdrift tree <assets-dir> <library> [--frames n] [--depth d]` prints the clip hierarchy.
fn cmd_tree(args: &[String]) -> Result<()> {
    let assets = PathBuf::from(&args[0]);
    let mut ticks = 0u32;
    let mut maxd = 4usize;
    let mut i = 2;
    while i < args.len() {
        match args[i].as_str() {
            "--frames" => { ticks = args[i + 1].parse()?; i += 1; }
            "--depth" => { maxd = args[i + 1].parse()?; i += 1; }
            _ => {}
        }
        i += 1;
    }
    let (mut rd, _a) = headless_renderer()?;
    let mut libs = assets::load_libraries(&mut rd, &assets, &[args[1].as_str()], 0)?;
    let mut world = movie::World::new();
    let lib = world.add_lib(libs.remove(0));
    let mut host = movie::NullHost;
    let root = world.root;
    world.load_into(root, lib);
    world.start_movie(root, &mut host);
    for _ in 0..ticks {
        world.advance(&mut host);
    }
    walk_tree(&world, root, 0, maxd);
    Ok(())
}

fn walk_tree(w: &movie::World, id: movie::ClipId, d: usize, maxd: usize) {
    fn walk(w: &movie::World, id: movie::ClipId, d: usize, maxd: usize) {
        let Some(c) = w.clip(id) else { return };
        let kind = match &c.kind {
            movie::Kind::Sprite => "sprite",
            movie::Kind::Shape => "shape",
            movie::Kind::Morph => "morph",
            movie::Kind::Text(_) => "text",
            movie::Kind::Button { .. } => "button",
            movie::Kind::Video => "video",
            movie::Kind::Image { .. } => "image",
        };
        if d > 0 {
            println!("{}{:>4} '{}' cid={} {} f={}/{} {}{} pos=({:.0},{:.0})", "  ".repeat(d), c.depth, c.name, c.cid, kind, c.frame, c.total, if c.playing { "▶" } else { "■" }, if c.visible { "" } else { " hidden" }, c.m.tx, c.m.ty);
        }
        if d < maxd {
            for ch in c.children.values() {
                walk(w, *ch, d + 1, maxd);
            }
        }
    }
    walk(w, id, d, maxd);
}

#[allow(dead_code)]
fn dep_probe() {
    let _ = ffmpeg_next::init();
    let _ = sdl2::init();
    let _ = symphonia::default::get_probe();
}

/// `snowdrift level <assets> <repo-root> <n> [--script "R:60,RU:20,.:10"] [--shot out.png] [--every k] [--scale s]`
/// Runs a level headlessly with scripted input (L R U D keys) and writes screenshots.
fn cmd_level(args: &[String]) -> Result<()> {
    let assets = PathBuf::from(&args[0]);
    let repo = PathBuf::from(&args[1]);
    let n: u32 = args[2].parse()?;
    let mut script = String::from(".:30");
    let mut shot = PathBuf::from("level.png");
    let mut every = 0u32;
    let mut scale = 1.0f32;
    let mut i = 3;
    while i < args.len() {
        match args[i].as_str() {
            "--script" => { script = args[i + 1].clone(); i += 1; }
            "--shot" => { shot = PathBuf::from(&args[i + 1]); i += 1; }
            "--every" => { every = args[i + 1].parse()?; i += 1; }
            "--scale" => { scale = args[i + 1].parse()?; i += 1; }
            _ => {}
        }
        i += 1;
    }
    let xml = std::fs::read_to_string(repo.join(format!("data/levels/level_{}.xml", n)))?;
    let data = level::LevelData::parse(&xml)?;
    let (mut rd, _a) = headless_renderer()?;
    let src = data.layer_source.trim_end_matches(".swf").to_string();
    let names = vec!["data/gamebase".to_string(), format!("data/levels/{}", src), format!("data/levels/backgrounds/{}", data.background)];
    let refs: Vec<&str> = names.iter().map(|s| s.as_str()).collect();
    let libs = assets::load_libraries(&mut rd, &assets, &refs, 0)?;
    let mut world = movie::World::new();
    let ids: Vec<u32> = libs.into_iter().map(|l| world.add_lib(l)).collect();
    let mut host = level::LHost::default();
    let root = world.root;
    world.load_into(root, ids[0]);
    world.start_movie(root, &mut host);
    let mut lv = level::Level::new(&mut world, root, ids[1], Some(ids[2]), data, &mut host, [false; 4], 1, false)?;
    let target = gfx::Target::new(&rd.device, (480.0 * scale) as u32, (360.0 * scale) as u32, wgpu::TextureFormat::Rgba8Unorm);
    let mut t = 0u32;
    let mut frame_no = 0;
    let mut render = |world: &movie::World, rd: &mut gfx::Renderer, path: &PathBuf| -> Result<()> {
        rd.begin_frame();
        render::Scene { world, alpha: 1.0 }.render(rd, world.root);
        let mut enc = rd.device.create_command_encoder(&Default::default());
        rd.flush(&mut enc, &target, None, Some(wgpu::Color::BLACK), render::stage_view(480.0, 360.0), [0.0, 0.0, target.width as f32, target.height as f32]);
        rd.queue.submit([enc.finish()]);
        gfx::read_target(&rd.device, &rd.queue, &target).save(path)?;
        Ok(())
    };
    if let Ok(at) = std::env::var("HERO_AT") {
        if let Some((x, y)) = at.split_once(',') {
            lv.teleport_hero(x.parse()?, y.parse()?);
        }
    }
    for seg in script.split(',') {
        let (keys, cnt) = seg.split_once(':').unwrap_or((".", "1"));
        let cnt: u32 = cnt.parse()?;
        let inp = level::Input { left: keys.contains('L'), right: keys.contains('R'), up: keys.contains('U'), down: keys.contains('D') };
        for _ in 0..cnt {
            let out = lv.tick(&mut world, &mut host, &inp);
            t += 1;
            if std::env::var("TRACE").is_ok() {
                println!("{:4} {} {}", t, keys, lv.debug_hero());
            }
            if every > 0 && t % every == 0 {
                let p = shot.with_file_name(format!("{}_{:04}.png", shot.file_stem().unwrap().to_string_lossy(), t));
                render(&world, &mut rd, &p)?;
                frame_no += 1;
            }
            if out != level::Outcome::Playing {
                println!("outcome {:?} at tick {}", out, t);
            }
        }
        let (hx, hy) = lv.hero_pos();
        println!("t={:4} hero=({:.1},{:.1}) energy={} crystals={}", t, hx, hy, lv.hero_energy(), lv.crystals);
    }
    if let Ok(d) = std::env::var("TREE_DEPTH") {
        walk_tree(&world, world.root, 0, d.parse().unwrap_or(3));
    }
    render(&world, &mut rd, &shot)?;
    println!("wrote {} ({} extra frames)", shot.display(), frame_no);
    Ok(())
}

/// `snowdrift ui <assets> <repo> --script "tick:30;move:x,y;click:x,y;key:L;shot:out.png" [--lang de] [--unlock]`
/// Boots the real UI headlessly and drives it with scripted ticks, mouse and screenshots.
fn cmd_ui(args: &[String]) -> Result<()> {
    let assets = PathBuf::from(&args[0]);
    let repo = PathBuf::from(&args[1]);
    let mut script = String::new();
    let mut lang = texts::Lang::En;
    let mut unlock = 0usize;
    let mut debug = false;
    let mut i = 2;
    while i < args.len() {
        match args[i].as_str() {
            "--script" => { script = args[i + 1].clone(); i += 1; }
            "--lang" => { lang = texts::Lang::parse(&args[i + 1]).unwrap_or(texts::Lang::En); i += 1; }
            "--unlock" => { unlock = args[i + 1].parse()?; i += 1; }
            "--debug" => debug = true,
            _ => {}
        }
        i += 1;
    }
    let (rd, _a) = headless_renderer()?;
    let audio = audio::Audio::new(None);
    if unlock > 0 {
        let mut s = save::Save::load();
        s.intro = true;
        s.test_unlock(unlock, true);
    }
    let mut ui = ui::Ui::new(rd, audio, assets, repo, lang, debug)?;
    let target = gfx::Target::new(&ui.rd.device, 900, 578, wgpu::TextureFormat::Rgba8Unorm);
    let mut input = level::Input { left: false, right: false, up: false, down: false };
    for op in script.split(';').filter(|s| !s.trim().is_empty()) {
        let (cmd, arg) = op.trim().split_once(':').unwrap_or((op.trim(), ""));
        match cmd {
            "tick" => {
                for _ in 0..arg.parse::<u32>()? {
                    ui.tick(&input);
                }
            }
            "move" | "click" => {
                let (x, y) = arg.split_once(',').ok_or_else(|| anyhow!("bad point"))?;
                let (x, y): (f32, f32) = (x.parse()?, y.parse()?);
                ui.mouse_moved(x, y);
                if cmd == "click" {
                    ui.mouse_pressed();
                    ui.tick(&input);
                    ui.mouse_released();
                }
            }
            "sleep" => std::thread::sleep(std::time::Duration::from_millis(arg.parse()?)),
            "keys" => {
                input = level::Input { left: arg.contains('L'), right: arg.contains('R'), up: arg.contains('U'), down: arg.contains('D') };
            }
            "topic" => ui.show_topic(Some(arg), 0),
            "level" => ui.show_topic(Some("game"), arg.parse()?),
            "shot" => {
                ui.rd.begin_frame();
                render::Scene { world: &ui.world, alpha: 1.0 }.render(&mut ui.rd, ui.world.root);
                let mut enc = ui.rd.device.create_command_encoder(&Default::default());
                ui.rd.flush(&mut enc, &target, None, Some(wgpu::Color::WHITE), render::stage_view(900.0, 578.0), [0.0, 0.0, 900.0, 578.0]);
                ui.rd.queue.submit([enc.finish()]);
                gfx::read_target(&ui.rd.device, &ui.rd.queue, &target).save(arg)?;
                println!("shot {} (topic={})", arg, ui.topic);
            }
            "bounds" => {
                let c = ui.clip(arg);
                let root = ui.world.root;
                let vis = ui.world.clip(c).map(|c| c.visible);
                println!("{} bounds {:?} visible {:?} m {:?}", arg, ui.world.bounds_in(c, root), vis, ui.world.clip(c).map(|c| c.m));
            }
            "hide" | "show" => {
                let c = ui.clip(arg);
                ui.world.set_var(c, "_visible", movie::Value::Bool(cmd == "show"));
            }
            "tree" => {
                // "/path" is relative to the stage root (layers), otherwise to the main movie
                let c = match arg.strip_prefix('/') {
                    Some(p) => { let r = ui.world.root; if p.is_empty() { r } else { ui.world.path(r, p) } }
                    None => ui.clip(arg),
                };
                walk_tree(&ui.world, c, 0, std::env::var("TREE_DEPTH").ok().and_then(|d| d.parse().ok()).unwrap_or(3));
            }
            "hit" => {
                let (x, y) = arg.split_once(',').unwrap();
                let root = ui.world.root;
                let h = ui.world.pick(root, (x.parse()?, y.parse()?)).unwrap_or(movie::NONE);
                let mut chain = Vec::new();
                let mut cur = h;
                while cur != movie::NONE {
                    match ui.world.clip(cur) { Some(c) => { chain.push(format!("{}(cid{},d{})", c.name, c.cid, c.depth)); cur = c.parent; } None => break }
                }
                println!("hit {} -> {}", arg, chain.join(" < "));
            }
            "info" => println!("topic={} game={} tickers={} hover={}", ui.topic, ui.game.is_some(), ui.tickers.len(), ui.hover),
            _ => {}
        }
    }
    Ok(())
}

/// `snowdrift video <file.flv> [out.png]`: decode test.
fn cmd_video(args: &[String]) -> Result<()> {
    let (mut rd, _a) = headless_renderer()?;
    let mut audio = audio::Audio::new(None);
    let mut v = video::VideoPlayer::open(std::path::Path::new(&args[0]), &mut rd, &mut audio).ok_or_else(|| anyhow!("cannot open"))?;
    println!("{}x{} duration {:.1}s", v.w, v.h, v.duration);
    let mut shown = 0;
    let t0 = std::time::Instant::now();
    while t0.elapsed().as_secs_f32() < 4.0 {
        if v.update(&mut rd, &audio) { shown += 1; }
        std::thread::sleep(std::time::Duration::from_millis(5));
    }
    println!("frames shown {} clock {:.2}", shown, v.position());
    Ok(())
}

fn main() -> Result<()> {
    env_logger::init();
    let args: Vec<String> = std::env::args().skip(1).collect();
    match args.first().map(|s| s.as_str()) {
        Some("shot") => cmd_shot(&args[1..]),
        Some("tree") => cmd_tree(&args[1..]),
        Some("level") => cmd_level(&args[1..]),
        Some("ui") => cmd_ui(&args[1..]),
        Some("video") => cmd_video(&args[1..]),
        Some("adec") => {
            // dev: dump a video's decoded audio as f32le stereo
            let (rate, s) = video::decode_audio(std::path::Path::new(&args[1])).ok_or_else(|| anyhow::anyhow!("no audio"))?;
            std::fs::write(&args[2], s.iter().flat_map(|v| v.to_le_bytes()).collect::<Vec<u8>>())?;
            println!("rate {rate} frames {}", s.len() / 2);
            Ok(())
        }
        _ => {
            let mut opt = app::Options { assets: PathBuf::from("assets"), repo: PathBuf::from("original"), level: None, fullscreen: false, mute: false, max_seconds: None, lang: texts::Lang::detect(), debug: false, unlock_all: false };
            let mut i = 0;
            while i < args.len() {
                match args[i].as_str() {
                    "--assets" => { opt.assets = PathBuf::from(&args[i + 1]); i += 1; }
                    "--data" => { opt.repo = PathBuf::from(&args[i + 1]); i += 1; }
                    "--level" => { opt.level = Some(args[i + 1].parse()?); i += 1; }
                    "--lang" => { opt.lang = texts::Lang::parse(&args[i + 1]).unwrap_or(opt.lang); i += 1; }
                    "--seconds" => { opt.max_seconds = Some(args[i + 1].parse()?); i += 1; }
                    "--fullscreen" => opt.fullscreen = true,
                    "--mute" => opt.mute = true,
                    "--debug" => opt.debug = true,
                    "--unlock-all" => opt.unlock_all = true,
                    "-h" | "--help" => {
                        println!("snowdrift [--assets DIR] [--data REPO] [--lang en|de|fr|nl] [--level N] [--fullscreen] [--mute] [--unlock-all] [--debug]\n  mouse: menus and doors; keys: arrows/WASD/space move, Esc back/quit, F11 fullscreen\ndev tools: shot, tree, level, ui, video");
                        return Ok(());
                    }
                    _ => {}
                }
                i += 1;
            }
            app::run(opt)
        }
    }
}
