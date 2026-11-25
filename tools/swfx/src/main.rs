//! swfx: converts the original Flash data of "Mission in Snowdriftland" into native
//! assets and offers a few developer tools used while porting the game logic.
mod behaviors;
mod bitmaps;
mod convert;
mod decomp;
mod devfont;
mod dis;
mod morph;
mod scripts;
mod shapes;
mod sounds;

use rayon::prelude::*;
use std::collections::BTreeSet;
use std::env;
use std::fs;
use std::path::{Path, PathBuf};

fn usage() -> ! {
    eprintln!(
        "usage:\n  swfx convert <original-repo-root> <out-dir>   convert every SWF to native assets\n  swfx dis|tags|dec|features <file.swf>        developer tools"
    );
    std::process::exit(2);
}

fn find_swfs(root: &Path) -> Vec<PathBuf> {
    let mut out = Vec::new();
    fn walk(d: &Path, out: &mut Vec<PathBuf>) {
        if let Ok(rd) = fs::read_dir(d) {
            for e in rd.flatten() {
                let p = e.path();
                if p.is_dir() {
                    let n = p.file_name().unwrap().to_string_lossy().to_string();
                    if n == ".git" || n == "native" || n == "K8dD6H3hDJ3DF" {
                        continue;
                    }
                    walk(&p, out);
                } else if p.extension().map(|x| x == "swf").unwrap_or(false) {
                    out.push(p);
                }
            }
        }
    }
    walk(root, &mut out);
    out.sort();
    out
}

fn cmd_convert(root: &Path, out: &Path) {
    let swfs = find_swfs(root);
    println!("converting {} SWF files", swfs.len());
    let unknown: BTreeSet<String> = swfs
        .par_iter()
        .map(|p| {
            let rel = p.strip_prefix(root).unwrap().with_extension("");
            let name = rel.to_string_lossy().replace('\\', "/");
            let data = fs::read(p).unwrap();
            let t = std::time::Instant::now();
            let c = match convert::convert(&name, &data) {
                Ok(c) => c,
                Err(e) => {
                    eprintln!("FAILED {}: {:#}", name, e);
                    return Vec::new();
                }
            };
            let dir = out.join(&name);
            fs::create_dir_all(dir.join("bitmaps")).unwrap();
            fs::create_dir_all(dir.join("sounds")).unwrap();
            c.lib.save(&dir.join("lib.bin")).unwrap();
            c.bitmaps.par_iter().for_each(|(id, img)| {
                img.save(dir.join("bitmaps").join(format!("{}.png", id))).unwrap();
            });
            for (_, file, bytes) in &c.sounds {
                fs::write(dir.join("sounds").join(file), bytes).unwrap();
            }
            let tris: usize = c
                .lib
                .chars
                .values()
                .map(|ch| match ch {
                    snow_fmt::Char::Shape(s) => s.meshes.iter().map(|m| m.indices.len() / 3).sum(),
                    _ => 0,
                })
                .sum();
            println!(
                "{:<34} {:>4} chars {:>4} bitmaps {:>3} sounds {:>7} tris  {:.2}s",
                name,
                c.lib.chars.len(),
                c.bitmaps.len(),
                c.sounds.len(),
                tris,
                t.elapsed().as_secs_f32()
            );
            c.unknown_scripts
        })
        .flatten()
        .collect();
    // the system font for text fields without embedded outlines
    let font_path = env::var("SWFX_DEVICE_FONT").map(PathBuf::from).unwrap_or_else(|_| PathBuf::from("fonts/DejaVuSans.ttf"));
    match fs::read(&font_path).map_err(anyhow::Error::from).and_then(|d| devfont::build("_sans", &d)) {
        Ok(f) => {
            let mut lib = snow_fmt::Library { name: "device".into(), ..Default::default() };
            println!("{:<34} {:>4} glyphs", "device font", f.glyphs.len());
            lib.fonts.insert(1, f);
            let dir = out.join("device");
            fs::create_dir_all(&dir).unwrap();
            lib.save(&dir.join("lib.bin")).unwrap();
        }
        Err(e) => eprintln!("device font {}: {:#} (device text will use an embedded face)", font_path.display(), e),
    }
    if !unknown.is_empty() {
        println!("\n{} native behaviours referenced (see scripts_index.txt)", unknown.len());
        let _ = fs::create_dir_all(out);
        let mut all = String::new();
        let mut seen = BTreeSet::new();
        for u in unknown.iter() {
            let id = u.lines().next().unwrap_or("").to_string();
            if seen.insert(id) {
                all.push_str(&format!("==== {}\n", u));
            }
        }
        fs::write(out.join("scripts_index.txt"), all).unwrap();
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() < 3 {
        usage();
    }
    if args[1] == "convert" {
        if args.len() < 4 {
            usage();
        }
        cmd_convert(Path::new(&args[2]), Path::new(&args[3]));
        return;
    }
    if args[1] == "info" {
        let lib = snow_fmt::Library::load(Path::new(&args[2])).expect("load lib.bin");
        println!("{} v{} fps={} stage={:?}", lib.name, lib.swf_version, lib.frame_rate, lib.stage);
        for (id, f) in &lib.fonts {
            let codes: String = f.glyphs.iter().filter_map(|g| char::from_u32(g.code as u32)).collect();
            println!("font {} '{}' glyphs={} bold={} asc={:.2} desc={:.2}: {}", id, f.name, f.glyphs.len(), f.bold, f.ascent, f.descent, codes);
        }
        let mut n = 0;
        for (id, c) in &lib.chars {
            if let snow_fmt::Char::EditText(t) = c {
                n += 1;
                if n <= 40 {
                    println!("edit {} font={:?} size={} align={:?} var='{}' html={} multi={} wrap={} autosize={} init='{}' bounds={:?}", id, t.font, t.size, t.align, t.variable, t.html, t.multiline, t.word_wrap, t.auto_size, t.initial_text, t.bounds);
                }
            }
        }
        println!("{} edit texts, {} exports", n, lib.exports.len());
        if let Some(id) = args.get(3).and_then(|v| v.parse::<u16>().ok()) {
            match lib.chars.get(&id) {
                Some(snow_fmt::Char::Shape(sh)) => {
                    println!("shape {} bounds {:?}", id, sh.bounds);
                    for m in &sh.meshes {
                        let f = match &m.fill {
                            snow_fmt::Fill::Solid(c) => format!("solid {:?}", c),
                            snow_fmt::Fill::Bitmap(b) => format!("bitmap {} smooth={} repeat={} m={:?}", b.id, b.smooth, b.repeat, b.matrix),
                            snow_fmt::Fill::Gradient(g) => format!("grad {:?} stops={:?}", g.kind, g.stops),
                        };
                        println!("  mesh {} verts {} tris: {}", m.verts.len(), m.indices.len() / 3, f);
                    }
                }
                Some(snow_fmt::Char::Sprite(t)) => {
                    println!("sprite {} frames {} labels {:?}", id, t.frames.len(), t.labels);
                    for (i, f) in t.frames.iter().enumerate().take(std::env::var("INFO_FRAMES").ok().and_then(|v| v.parse().ok()).unwrap_or(7)) {
                        let cmds: Vec<String> = f.cmds.iter().map(|c| match c {
                            snow_fmt::Cmd::Place(p) => format!("P(d{} id{:?} mv{} name{:?} clip{:?} a{:?} m{:?})", p.depth, p.id, p.is_move, p.name, p.clip_depth, p.cx.map(|c| c.mul[3]), p.matrix.map(|m| (m.a, m.d, m.tx, m.ty))),
                            snow_fmt::Cmd::Remove(d) => format!("R(d{})", d),
                        }).collect();
                        println!("  f{}: {} ops={:?}", i + 1, cmds.join(" "), f.ops);
                    }
                }
                other => println!("char {} = {:?}", id, other.map(|c| std::mem::discriminant(c))),
            }
        }
        return;
    }
    let data = fs::read(&args[2]).expect("read swf");
    let buf = swf::decompress_swf(&data[..]).expect("decompress");
    let movie = swf::parse_swf(&buf).expect("parse");
    match args[1].as_str() {
        "dis" => dis::dump_actions(&movie),
        "tags" => dis::dump_tags(&movie),
        "dec" => dis::dump_decomp(&movie),
        "features" => dis::dump_features(&movie),
        _ => usage(),
    }
}
