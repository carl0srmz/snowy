use swf::avm1::read::Reader;
use swf::{Tag, SwfStr};

fn dis_actions(indent: &str, data: &[u8], version: u8) {
    let mut r = Reader::new(data, version);
    loop {
        let pos = r.get_ref().as_ptr() as usize - data.as_ptr() as usize;
        match r.read_action() {
            Ok(swf::avm1::types::Action::End) => {
                println!("{indent}{pos:05x}: <end>");
                break;
            }
            Ok(a) => println!("{indent}{pos:05x}: {a:?}"),
            Err(e) => {
                println!("{indent}!! error {e:?}");
                break;
            }
        }
    }
}

fn s(x: &SwfStr) -> String {
    x.to_string_lossy(swf::UTF_8)
}

fn walk(tags: &[Tag], depth: usize, version: u8, ids: &mut Vec<(u16, String)>) {
    let ind = "  ".repeat(depth);
    for t in tags {
        match t {
            Tag::DoAction(d) => {
                println!("{ind}DoAction ({} bytes)", d.len());
                dis_actions(&format!("{ind}  "), d, version);
            }
            Tag::DoInitAction { id, action_data } => {
                println!("{ind}DoInitAction sprite={id} ({} bytes)", action_data.len());
                dis_actions(&format!("{ind}  "), action_data, version);
            }
            Tag::ExportAssets(v) => {
                for e in v {
                    println!("{ind}Export id={} name={}", e.id, s(e.name));
                    ids.push((e.id, s(e.name)));
                }
            }
            Tag::DefineSprite(sp) => {
                println!("{ind}Sprite id={} frames={}", sp.id, sp.num_frames);
                walk(&sp.tags, depth + 1, version, ids);
            }
            Tag::PlaceObject(p) => {
                println!(
                    "{ind}Place depth={} id={:?} name={:?}",
                    p.depth,
                    match p.action { swf::PlaceObjectAction::Place(i) | swf::PlaceObjectAction::Replace(i) => Some(i), _ => None },
                    p.name.map(s)
                );
                if let Some(ca) = &p.clip_actions {
                    for c in ca {
                        println!("{ind}  ClipAction events={:?}", c.events);
                        if let Some(d) = &c.action_data.get(..) {
                            dis_actions(&format!("{ind}    "), d, version);
                        }
                    }
                }
            }
            Tag::FrameLabel(l) => println!("{ind}Label {}", s(l.label)),
            Tag::ShowFrame => println!("{ind}ShowFrame"),
            _ => {}
        }
    }
}

pub fn dump_actions(m: &swf::Swf) {
    let mut ids = Vec::new();
    println!("SWF version {}", m.header.version());
    walk(&m.tags, 0, m.header.version(), &mut ids);
}

pub fn dump_tags(m: &swf::Swf) {
    for t in &m.tags {
        let n = format!("{t:?}");
        println!("{}", &n[..n.len().min(160)]);
    }
}

fn walk_dec(tags: &[Tag], depth: usize, version: u8, names: &mut std::collections::HashMap<u16, String>) {
    use crate::decomp::decompile_tag;
    use std::collections::HashMap;
    let ind = "  ".repeat(depth);
    for t in tags {
        match t {
            Tag::ExportAssets(v) => {
                for e in v {
                    names.insert(e.id, s(e.name));
                }
            }
            Tag::DoAction(d) => {
                println!("{ind}// ---- DoAction");
                print!("{}", decompile_tag(d, version, &[], HashMap::new(), depth));
            }
            Tag::DoInitAction { id, action_data } => {
                let n = names.get(id).cloned().unwrap_or_default();
                println!("{ind}// ======== DoInitAction sprite={id} {n}");
                print!("{}", decompile_tag(action_data, version, &[], HashMap::new(), depth));
            }
            Tag::DefineSprite(sp) => {
                let n = names.get(&sp.id).cloned().unwrap_or_default();
                let mut has = false;
                for st in &sp.tags {
                    if matches!(st, Tag::DoAction(_) | Tag::PlaceObject(_)) {
                        has = true;
                    }
                }
                if has {
                    println!("{ind}// sprite id={} {} frames={}", sp.id, n, sp.num_frames);
                }
                let mut frame = 1;
                for st in &sp.tags {
                    match st {
                        Tag::ShowFrame => frame += 1,
                        Tag::FrameLabel(l) => println!("{ind}  // frame {frame} label {}", s(l.label)),
                        Tag::DoAction(d) => {
                            println!("{ind}  // frame {frame} DoAction");
                            print!("{}", decompile_tag(d, version, &[], HashMap::new(), depth + 1));
                        }
                        Tag::PlaceObject(p) => {
                            if let Some(ca) = &p.clip_actions {
                                for c in ca {
                                    println!("{ind}  // frame {frame} ClipAction {:?} on depth {} name {:?}", c.events, p.depth, p.name.map(s));
                                    print!("{}", decompile_tag(c.action_data, version, &[], HashMap::new(), depth + 1));
                                }
                            }
                        }
                        _ => {}
                    }
                }
            }
            Tag::PlaceObject(p) => {
                if let Some(ca) = &p.clip_actions {
                    for c in ca {
                        println!("{ind}// root ClipAction {:?} depth {} name {:?}", c.events, p.depth, p.name.map(s));
                        print!("{}", decompile_tag(c.action_data, version, &[], HashMap::new(), depth + 1));
                    }
                }
            }
            _ => {}
        }
    }
}

pub fn dump_decomp(m: &swf::Swf) {
    let mut names = std::collections::HashMap::new();
    for t in &m.tags {
        if let Tag::ExportAssets(v) = t {
            for e in v {
                names.insert(e.id, s(e.name));
            }
        }
    }
    walk_dec(&m.tags, 0, m.header.version(), &mut names);
}

fn walk_p3(tags: &[Tag], depth: usize, cnt: &mut std::collections::BTreeMap<String, usize>) {
    for t in tags {
        match t {
            Tag::DefineSprite(sp) => walk_p3(&sp.tags, depth + 1, cnt),
            Tag::DefineButton2(b) | Tag::DefineButton(b) => {
                if !b.actions.is_empty() {
                    *cnt.entry("button-with-actions".into()).or_default() += 1;
                    for a in &b.actions {
                        let t = crate::decomp::decompile_tag(a.action_data, 8, &[], std::collections::HashMap::new(), 0);
                        println!("BUTTON {} cond={:?}: {}", b.id, a.conditions, t.replace('\n', " | "));
                    }
                }
            }
            Tag::PlaceObject(p) => {
                if let Some(b) = p.blend_mode { *cnt.entry(format!("blend {:?}", b)).or_default() += 1; }
                if let Some(f) = &p.filters { for x in f { let n = format!("{:?}", x); *cnt.entry(format!("filter {}", &n[..n.len().min(12)])).or_default() += 1; } }
                if p.is_bitmap_cached.is_some() { *cnt.entry("cacheAsBitmap".into()).or_default() += 1; }
                if p.clip_depth.is_some() { *cnt.entry("clipdepth".into()).or_default() += 1; }
                if p.clip_actions.is_some() { *cnt.entry("clipactions".into()).or_default() += 1; }
                if p.color_transform.is_some() { *cnt.entry("cxform".into()).or_default() += 1; }
                if p.ratio.is_some() { *cnt.entry("ratio".into()).or_default() += 1; }
                if p.class_name.is_some() { *cnt.entry("classname".into()).or_default() += 1; }
            }
            _ => {}
        }
    }
}

pub fn dump_features(m: &swf::Swf) {
    let mut cnt = std::collections::BTreeMap::new();
    walk_p3(&m.tags, 0, &mut cnt);
    println!("{:?}", cnt);
}
