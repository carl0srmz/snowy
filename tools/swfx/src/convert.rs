//! SWF -> snow_fmt::Library conversion.
use crate::bitmaps;
use crate::scripts;
use crate::shapes::{self, matrix, rect, tessellate, tw, Tess};
use anyhow::Result;
use image::RgbaImage;
use snow_fmt::*;
use std::collections::{BTreeMap, BTreeSet, HashMap};
use swf::{FillStyle, Tag};

pub struct Converted {
    pub lib: Library,
    pub bitmaps: Vec<(CharId, RgbaImage)>,
    /// (id, file name, bytes)
    pub sounds: Vec<(CharId, String, Vec<u8>)>,
    pub unknown_scripts: Vec<String>,
}

struct Cx<'a> {
    tess: Tess,
    fonts: HashMap<CharId, FontDef>,
    morphs_used: BTreeMap<CharId, BTreeSet<u16>>,
    morph_defs: HashMap<CharId, &'a swf::DefineMorphShape>,
    version: u8,
    unknown: Vec<String>,
}

fn s(x: &swf::SwfStr) -> String {
    x.to_string_lossy(swf::UTF_8)
}

fn cxform(c: &swf::ColorTransform) -> CXform {
    CXform {
        mul: [c.r_multiply.to_f32(), c.g_multiply.to_f32(), c.b_multiply.to_f32(), c.a_multiply.to_f32()],
        add: [c.r_add as f32 / 255.0, c.g_add as f32 / 255.0, c.b_add as f32 / 255.0, c.a_add as f32 / 255.0],
    }
}

fn blend(b: swf::BlendMode) -> Blend {
    use swf::BlendMode as B;
    match b {
        B::Normal => Blend::Normal,
        B::Layer => Blend::Layer,
        B::Multiply => Blend::Multiply,
        B::Screen => Blend::Screen,
        B::Lighten => Blend::Lighten,
        B::Darken => Blend::Darken,
        B::Difference => Blend::Difference,
        B::Add => Blend::Add,
        B::Subtract => Blend::Subtract,
        B::Invert => Blend::Invert,
        B::Alpha => Blend::Alpha,
        B::Erase => Blend::Erase,
        B::Overlay => Blend::Overlay,
        B::HardLight => Blend::HardLight,
    }
}

fn filters(f: &Option<Vec<swf::Filter>>) -> Vec<Filter> {
    let mut out = Vec::new();
    if let Some(v) = f {
        for x in v {
            match x {
                swf::Filter::BlurFilter(b) => out.push(Filter::Blur { x: b.blur_x.to_f32(), y: b.blur_y.to_f32(), passes: b.num_passes() }),
                swf::Filter::ColorMatrixFilter(m) => out.push(Filter::ColorMatrix(m.matrix)),
                other => eprintln!("warning: unsupported filter {:?}", std::mem::discriminant(other)),
            }
        }
    }
    out
}

fn clip_flags(f: swf::ClipEventFlag) -> u32 {
    use swf::ClipEventFlag as C;
    let mut o = 0;
    let map = [
        (C::LOAD, clip_event::LOAD),
        (C::ENTER_FRAME, clip_event::ENTER_FRAME),
        (C::UNLOAD, clip_event::UNLOAD),
        (C::MOUSE_MOVE, clip_event::MOUSE_MOVE),
        (C::MOUSE_DOWN, clip_event::MOUSE_DOWN),
        (C::MOUSE_UP, clip_event::MOUSE_UP),
        (C::KEY_DOWN, clip_event::KEY_DOWN),
        (C::KEY_UP, clip_event::KEY_UP),
        (C::DATA, clip_event::DATA),
        (C::INITIALIZE, clip_event::INITIALIZE),
        (C::PRESS, clip_event::PRESS),
        (C::RELEASE, clip_event::RELEASE),
        (C::CONSTRUCT, clip_event::CONSTRUCT),
    ];
    for (a, b) in map {
        if f.contains(a) {
            o |= b;
        }
    }
    o
}

impl<'a> Cx<'a> {
    fn timeline(&mut self, tags: &[Tag<'a>], depth_ids: &mut HashMap<u16, CharId>) -> Timeline {
        let mut tl = Timeline::default();
        let mut cur = Frame::default();
        for t in tags {
            match t {
                Tag::ShowFrame => {
                    tl.frames.push(std::mem::take(&mut cur));
                }
                Tag::FrameLabel(l) => {
                    tl.labels.push((s(l.label), tl.frames.len() as u16 + 1));
                }
                Tag::DoAction(d) => {
                    let ops = self.lowered(d);
                    cur.ops.extend(ops);
                }
                Tag::PlaceObject(p) => {
                    let (id, is_move) = match p.action {
                        swf::PlaceObjectAction::Place(i) => (Some(i), false),
                        swf::PlaceObjectAction::Replace(i) => (Some(i), true),
                        swf::PlaceObjectAction::Modify => (None, true),
                    };
                    if let Some(i) = id {
                        depth_ids.insert(p.depth, i);
                    }
                    let cid = id.or_else(|| depth_ids.get(&p.depth).copied());
                    if let (Some(cid), Some(r)) = (cid, p.ratio) {
                        if self.morph_defs.contains_key(&cid) {
                            self.morphs_used.entry(cid).or_default().insert(r);
                        }
                    }
                    let mut events = Vec::new();
                    if let Some(ca) = &p.clip_actions {
                        for c in ca {
                            let ops = self.lowered(c.action_data);
                            events.push(ClipEvent { flags: clip_flags(c.events), ops });
                        }
                    }
                    cur.cmds.push(Cmd::Place(Place {
                        depth: p.depth,
                        id,
                        is_move,
                        matrix: p.matrix.as_ref().map(matrix),
                        cx: p.color_transform.as_ref().map(cxform),
                        ratio: p.ratio,
                        name: p.name.map(s),
                        clip_depth: p.clip_depth,
                        filters: filters(&p.filters),
                        blend: p.blend_mode.map(blend),
                        visible: p.is_visible,
                        events,
                    }));
                }
                Tag::RemoveObject(r) => {
                    depth_ids.remove(&r.depth);
                    cur.cmds.push(Cmd::Remove(r.depth));
                }
                Tag::StartSound(ss) => {
                    use swf::SoundEvent as E;
                    cur.sounds.push(SoundStart {
                        id: ss.id,
                        stop: ss.sound_info.event == E::Stop,
                        no_restart: ss.sound_info.event == E::Start,
                        loops: ss.sound_info.num_loops,
                    });
                }
                _ => {}
            }
        }
        tl
    }

    /// Lowers a script; whatever cannot be expressed as plain ops becomes a `script:<hash>`
    /// behaviour that the game implements by hand. The source text is recorded for reference.
    fn lowered(&mut self, data: &[u8]) -> Vec<Op> {
        let ops = scripts::lower(data, self.version);
        if std::env::var("SWFX_LOWER_DUMP").is_ok() {
            let key = scripts::script_id(&crate::decomp::decompile_tag_legacy(data, self.version));
            eprintln!("LOWER {} {:?}", key, ops.iter().map(|o| match o { Op::Unknown(_) => "Unknown".to_string(), o => format!("{:?}", o) }).collect::<Vec<_>>());
        }
        ops.into_iter()
            .map(|o| match o {
                Op::Unknown(text) => {
                    let id = scripts::script_id(&text);
                    self.unknown.push(format!("{}\n{}", id, text));
                    Op::Behavior(id)
                }
                o => o,
            })
            .collect()
    }

    fn font(&mut self, f: &swf::Font) -> FontDef {
        let em_twips: f32 = if f.version >= 3 { 20480.0 } else { 1024.0 };
        let em_px = em_twips / 20.0;
        let white = [FillStyle::Color(swf::Color { r: 255, g: 255, b: 255, a: 255 })];
        let mut glyphs = Vec::new();
        for g in &f.glyphs {
            let mut shape = tessellate(&mut self.tess, &g.shape_records, &white, &[], Rect::default());
            for m in &mut shape.meshes {
                for v in &mut m.verts {
                    v[0] /= em_px;
                    v[1] /= em_px;
                }
            }
            glyphs.push(GlyphDef { code: g.code, advance: g.advance as f32 / em_twips, shape });
        }
        let (mut ascent, mut descent, mut leading, mut kerning) = (0.8, 0.2, 0.0, Vec::new());
        if let Some(l) = &f.layout {
            ascent = l.ascent as f32 / em_twips;
            descent = l.descent as f32 / em_twips;
            leading = l.leading as f32 / em_twips;
            for k in &l.kerning {
                kerning.push((k.left_code, k.right_code, k.adjustment.get() as f32 / em_twips));
            }
        }
        FontDef {
            name: s(f.name),
            ascent,
            descent,
            leading,
            bold: f.flags.contains(swf::FontFlag::IS_BOLD),
            italic: f.flags.contains(swf::FontFlag::IS_ITALIC),
            glyphs,
            kerning,
        }
    }

    fn static_text(&mut self, t: &swf::Text) -> ShapeDef {
        let m = matrix(&t.matrix);
        let mut out: Vec<Mesh> = Vec::new();
        let (mut font, mut color, mut x, mut y, mut height) = (None::<CharId>, [0.0, 0.0, 0.0, 1.0f32], 0.0f32, 0.0f32, 12.0f32);
        for r in &t.records {
            if let Some(f) = r.font_id {
                font = Some(f);
            }
            if let Some(c) = &r.color {
                color = shapes::color(c);
            }
            if let Some(v) = r.x_offset {
                x = tw(v);
            }
            if let Some(v) = r.y_offset {
                y = tw(v);
            }
            if let Some(h) = r.height {
                height = tw(h);
            }
            let fd = font.and_then(|f| self.fonts.get(&f));
            for g in &r.glyphs {
                if let Some(fd) = fd {
                    if let Some(gd) = fd.glyphs.get(g.index as usize) {
                        for mesh in &gd.shape.meshes {
                            let verts: Vec<[f32; 2]> = mesh
                                .verts
                                .iter()
                                .map(|v| m.apply(v[0] * height + x, v[1] * height + y))
                                .map(|(a, b)| [a, b])
                                .collect();
                            push_merge(&mut out, Fill::Solid(color), verts, &mesh.indices);
                        }
                    }
                }
                x += g.advance as f32 / 20.0;
            }
        }
        ShapeDef { bounds: rect(&t.bounds), meshes: out }
    }

    fn morph_frame(&mut self, def: &swf::DefineMorphShape, ratio: u16) -> ShapeDef {
        crate::morph::tessellate_morph(&mut self.tess, def, ratio)
    }
}

/// Appends triangles to the last mesh when it has the same solid colour (cuts draw calls for text).
fn push_merge(out: &mut Vec<Mesh>, fill: Fill, verts: Vec<[f32; 2]>, idx: &[u32]) {
    if let (Some(last), Fill::Solid(c)) = (out.last_mut(), &fill) {
        if let Fill::Solid(lc) = &last.fill {
            if lc == c {
                let base = last.verts.len() as u32;
                last.verts.extend(verts);
                last.indices.extend(idx.iter().map(|i| i + base));
                return;
            }
        }
    }
    out.push(Mesh { fill, verts, indices: idx.to_vec() });
}

pub fn convert(name: &str, data: &[u8]) -> Result<Converted> {
    let buf = swf::decompress_swf(data)?;
    let movie = swf::parse_swf(&buf)?;
    let version = movie.header.version();
    let mut lib = Library {
        name: name.to_string(),
        swf_version: version,
        frame_rate: movie.header.frame_rate().to_f32(),
        stage: rect(movie.header.stage_size()),
        ..Default::default()
    };
    let mut bitmaps_out: Vec<(CharId, RgbaImage)> = Vec::new();
    let mut sounds_out = Vec::new();
    let mut jpeg_tables: &[u8] = &[];
    let mut cx = Cx {
        tess: Tess::new(),
        fonts: HashMap::new(),
        morphs_used: BTreeMap::new(),
        morph_defs: HashMap::new(),
        version,
        unknown: Vec::new(),
    };

    // pass 1: tables, fonts, morph defs, bitmaps, sounds
    for t in &movie.tags {
        match t {
            Tag::JpegTables(j) => jpeg_tables = j,
            Tag::SetBackgroundColor(c) => lib.background = [c.r, c.g, c.b],
            Tag::DefineFont2(f) => {
                let fd = cx.font(f);
                cx.fonts.insert(f.id, fd);
            }
            Tag::DefineMorphShape(m) => {
                cx.morph_defs.insert(m.id, m);
            }
            Tag::DefineBits { id, jpeg_data } => {
                bitmaps_out.push((*id, bitmaps::decode_jpeg_with_tables(jpeg_tables, jpeg_data)?));
            }
            Tag::DefineBitsJpeg2 { id, jpeg_data } => bitmaps_out.push((*id, bitmaps::decode_jpeg(jpeg_data)?)),
            Tag::DefineBitsJpeg3(j) => bitmaps_out.push((j.id, bitmaps::decode_jpeg3(j.data, j.alpha_data)?)),
            Tag::DefineBitsLossless(l) => bitmaps_out.push((l.id, bitmaps::decode_lossless(l)?)),
            Tag::DefineSound(snd) => {
                let (file, bytes, rate, ch) = crate::sounds::extract(snd)?;
                lib.sounds.push(SoundMeta { id: snd.id, file: file.clone(), sample_rate: rate, channels: ch, samples: snd.num_samples });
                sounds_out.push((snd.id, file, bytes));
            }
            Tag::ExportAssets(v) => {
                for e in v {
                    let n = s(e.name);
                    if !n.starts_with("__Packages") {
                        lib.exports.insert(n, e.id);
                    }
                }
            }
            _ => {}
        }
    }
    for (id, img) in &bitmaps_out {
        lib.bitmaps.push(BitmapMeta { id: *id, width: img.width(), height: img.height(), file: format!("{}.png", id) });
    }
    lib.fonts = cx.fonts.iter().map(|(k, v)| (*k, v.clone())).collect();

    // pass 2: characters
    let mut sprites: Vec<(CharId, u16, &[Tag])> = Vec::new();
    for t in &movie.tags {
        match t {
            Tag::DefineShape(sh) => {
                let def = tessellate(&mut cx.tess, &sh.shape, &sh.styles.fill_styles, &sh.styles.line_styles, rect(&sh.shape_bounds));
                lib.chars.insert(sh.id, Char::Shape(def));
            }
            Tag::DefineText(tx) | Tag::DefineText2(tx) => {
                let def = cx.static_text(tx);
                lib.chars.insert(tx.id, Char::Shape(def));
            }
            Tag::DefineEditText(e) => {
                let layout = e.layout().cloned().unwrap_or_default();
                let c = e.color().map(shapes::color).unwrap_or([0.0, 0.0, 0.0, 1.0]);
                lib.chars.insert(
                    e.id(),
                    Char::EditText(EditTextDef {
                        bounds: rect(e.bounds()),
                        font: e.font_id(),
                        size: e.height().map(tw).unwrap_or(12.0),
                        color: c,
                        align: match layout.align {
                            swf::TextAlign::Left => Align::Left,
                            swf::TextAlign::Right => Align::Right,
                            swf::TextAlign::Center => Align::Center,
                            swf::TextAlign::Justify => Align::Justify,
                        },
                        left_margin: tw(layout.left_margin),
                        right_margin: tw(layout.right_margin),
                        indent: tw(layout.indent),
                        leading: tw(layout.leading),
                        variable: s(e.variable_name()),
                        initial_text: e.initial_text().map(s).unwrap_or_default(),
                        html: e.is_html(),
                        multiline: e.is_multiline(),
                        word_wrap: e.is_word_wrap(),
                        selectable: e.is_selectable(),
                        read_only: e.is_read_only(),
                        password: e.is_password(),
                        auto_size: e.is_auto_size(),
                        border: e.has_border(),
                        max_length: e.max_length().unwrap_or(0),
                        device: !e.use_outlines(),
                    }),
                );
            }
            Tag::DefineButton2(b) | Tag::DefineButton(b) => {
                let mut def = ButtonDef::default();
                for r in &b.records {
                    def.records.push(ButtonRecordDef {
                        up: r.states.contains(swf::ButtonState::UP),
                        over: r.states.contains(swf::ButtonState::OVER),
                        down: r.states.contains(swf::ButtonState::DOWN),
                        hit: r.states.contains(swf::ButtonState::HIT_TEST),
                        id: r.id,
                        depth: r.depth,
                        matrix: matrix(&r.matrix),
                        cx: cxform(&r.color_transform),
                    });
                }
                for a in &b.actions {
                    let ops = cx.lowered(a.action_data);
                    def.actions.push(ButtonAct { cond: a.conditions.bits() as u16, ops });
                }
                lib.chars.insert(b.id, Char::Button(def));
            }
            Tag::DefineVideoStream(v) => {
                lib.chars.insert(v.id, Char::Video { width: v.width, height: v.height });
            }
            Tag::DefineSprite(sp) => sprites.push((sp.id, sp.num_frames, &sp.tags)),
            _ => {}
        }
    }
    for (id, _n, tags) in &sprites {
        let mut ids = HashMap::new();
        let tl = cx.timeline(tags, &mut ids);
        lib.chars.insert(*id, Char::Sprite(tl));
    }
    let mut ids = HashMap::new();
    lib.root = cx.timeline(&movie.tags, &mut ids);

    // morph shapes at the ratios actually used
    let used = std::mem::take(&mut cx.morphs_used);
    for (id, ratios) in used {
        let def = cx.morph_defs[&id];
        let mut md = MorphDef::default();
        for r in ratios {
            md.frames.insert(r, cx.morph_frame(def, r));
        }
        lib.chars.insert(id, Char::Morph(md));
    }
    Ok(Converted { lib, bitmaps: bitmaps_out, sounds: sounds_out, unknown_scripts: cx.unknown })
}
