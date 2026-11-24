//! Dynamic text fields, laid out from the embedded glyph outlines.
use crate::gfx::*;
use crate::movie::World;
use snow_fmt::*;
use std::cell::RefCell;

#[derive(Clone, Debug)]
pub struct Fmt {
    pub size: f32,
    pub color: [f32; 4],
    pub letter_spacing: f32,
}

#[derive(Clone, Debug)]
struct Span {
    text: String,
    fmt: Fmt,
}

#[derive(Clone, Debug)]
struct Para {
    align: Align,
    spans: Vec<Span>,
}

struct Group {
    color: [f32; 4],
    verts: Vec<[f32; 2]>,
    idx: Vec<u32>,
}

#[derive(Default)]
struct Layout {
    groups: Vec<Group>,
    lines: usize,
    visible_lines: usize,
}

pub struct TextField {
    pub def: EditTextDef,
    pub lib: u32,
    paras: Vec<Para>,
    pub scroll: u32,
    /// text format applied to all content (TextFormat.letterSpacing etc.)
    pub letter_spacing: Option<f32>,
    pub size_override: Option<f32>,
    pub auto_size: bool,
    layout: RefCell<Option<Layout>>,
}

fn base_fmt(def: &EditTextDef) -> Fmt {
    Fmt { size: def.size, color: def.color, letter_spacing: 0.0 }
}

impl TextField {
    fn cur_fmt(&self) -> Fmt {
        let mut f = base_fmt(&self.def);
        if let Some(s) = self.size_override {
            f.size = s;
        }
        if let Some(l) = self.letter_spacing {
            f.letter_spacing = l;
        }
        f
    }

    /// TextFormat applied to the whole field (size and/or letter spacing).
    pub fn set_format(&mut self, size: Option<f32>, ls: Option<f32>) {
        if size.is_some() {
            self.size_override = size;
        }
        if ls.is_some() {
            self.letter_spacing = ls;
        }
        for p in &mut self.paras {
            for sp in &mut p.spans {
                if let Some(s) = size {
                    sp.fmt.size = s;
                }
                if let Some(l) = ls {
                    sp.fmt.letter_spacing = l;
                }
            }
        }
        *self.layout.borrow_mut() = None;
    }
}

impl TextField {
    pub fn new(def: EditTextDef, lib: u32) -> TextField {
        let mut t = TextField { auto_size: def.auto_size, def, lib, paras: Vec::new(), scroll: 1, letter_spacing: None, size_override: None, layout: RefCell::new(None) };
        let init = t.def.initial_text.clone();
        if t.def.html {
            t.set_html(&init);
        } else {
            t.set_text(&init);
        }
        t
    }

    pub fn set_text(&mut self, s: &str) {
        let f = self.cur_fmt();
        self.paras = s
            .replace("\r\n", "\n")
            .split(['\n', '\r'])
            .map(|l| Para { align: self.def.align, spans: vec![Span { text: l.to_string(), fmt: f.clone() }] })
            .collect();
        self.scroll = 1;
        *self.layout.borrow_mut() = None;
    }

    pub fn text(&self) -> String {
        self.paras.iter().map(|p| p.spans.iter().map(|s| s.text.as_str()).collect::<String>()).collect::<Vec<_>>().join("\n")
    }

    pub fn append(&mut self, s: &str) {
        if self.paras.is_empty() {
            self.set_text(s);
            return;
        }
        let f = self.cur_fmt();
        let mut first = true;
        for part in s.split('\n') {
            if !first {
                self.paras.push(Para { align: self.def.align, spans: vec![] });
            }
            first = false;
            if let Some(p) = self.paras.last_mut() {
                match p.spans.last_mut() {
                    Some(sp) => sp.text.push_str(part),
                    None => p.spans.push(Span { text: part.to_string(), fmt: f.clone() }),
                }
            }
        }
        *self.layout.borrow_mut() = None;
    }

    pub fn set_letter_spacing(&mut self, ls: f32) {
        self.letter_spacing = Some(ls);
        for p in &mut self.paras {
            for s in &mut p.spans {
                s.fmt.letter_spacing = ls;
            }
        }
        *self.layout.borrow_mut() = None;
    }

    pub fn set_html(&mut self, html: &str) {
        let fmt = self.cur_fmt();
        self.paras = parse_html(html, &fmt, self.def.align);
        self.scroll = 1;
        *self.layout.borrow_mut() = None;
    }

    pub fn invalidate(&self) {
        *self.layout.borrow_mut() = None;
    }

    pub fn max_scroll(&self, world: &World) -> u32 {
        self.ensure_layout(world);
        let l = self.layout.borrow();
        let l = l.as_ref().unwrap();
        (l.lines.saturating_sub(l.visible_lines) + 1).max(1) as u32
    }

    fn ensure_layout(&self, world: &World) {
        if self.layout.borrow().is_none() {
            *self.layout.borrow_mut() = Some(self.build(world));
        }
    }

    fn font<'a>(&self, world: &'a World) -> Option<&'a FontDef> {
        let lib = &world.libs[self.lib as usize].lib;
        if let Some(id) = self.def.font {
            if let Some(f) = lib.fonts.get(&id) {
                if !f.glyphs.is_empty() {
                    return Some(f);
                }
            }
        }
        // device fonts: fall back to the most text-like embedded face
        lib.fonts
            .values()
            .filter(|f| !f.glyphs.is_empty())
            .max_by_key(|f| (f.name.contains("Univers") as u32) * 1000 + f.glyphs.len() as u32)
    }

    fn build(&self, world: &World) -> Layout {
        let Some(font) = self.font(world) else { return Layout::default() };
        let b = self.def.bounds;
        let gutter = 2.0;
        let left = b.x0 + gutter + self.def.left_margin;
        let width = (b.width() - gutter * 2.0 - self.def.left_margin - self.def.right_margin).max(1.0);
        let wrap = self.def.word_wrap && self.def.multiline;
        let glyph_of = |c: char| -> Option<&GlyphDef> {
            let code = c as u32;
            let find = |cc: u32| font.glyphs.iter().find(|g| g.code as u32 == cc);
            find(code).or_else(|| {
                let up = c.to_uppercase().next().map(|u| u as u32).unwrap_or(code);
                find(up)
            })
        };
        struct Tok {
            text: String,
            fmt: Fmt,
            width: f32,
            space: bool,
        }
        let mut out = Layout::default();
        let mut y = b.y0 + gutter;
        let mut line_idx = 0usize;
        let visible_height = b.height() - gutter * 2.0;
        let line_h = |size: f32| (font.ascent + font.descent + font.leading) * size + self.def.leading;
        let mut groups: Vec<Group> = Vec::new();
        let skip_lines = (self.scroll.max(1) - 1) as usize;
        let mut cur_visible = 0usize;
        let mut max_line_w: f32 = 0.0;
        let _ = &mut max_line_w;
        for para in &self.paras {
            // tokenise into words and spaces
            let mut toks: Vec<Tok> = Vec::new();
            for sp in &para.spans {
                let mut cur = String::new();
                let mut cur_space = false;
                let mut flush = |cur: &mut String, space: bool, toks: &mut Vec<Tok>| {
                    if cur.is_empty() {
                        return;
                    }
                    let w: f32 = cur.chars().map(|c| glyph_of(c).map(|g| g.advance * sp.fmt.size).unwrap_or(0.35 * sp.fmt.size) + sp.fmt.letter_spacing).sum();
                    toks.push(Tok { text: std::mem::take(cur), fmt: sp.fmt.clone(), width: w, space });
                };
                for c in sp.text.chars() {
                    let is_space = c == ' ';
                    if is_space != cur_space {
                        flush(&mut cur, cur_space, &mut toks);
                        cur_space = is_space;
                    }
                    cur.push(c);
                }
                flush(&mut cur, cur_space, &mut toks);
            }
            // greedy line breaking
            let mut lines: Vec<Vec<Tok>> = vec![Vec::new()];
            let mut lw = 0.0f32;
            for t in toks {
                if wrap && !t.space && lw + t.width > width && !lines.last().unwrap().is_empty() {
                    // drop trailing spaces on the finished line
                    while lines.last().map(|l| l.last().map(|x| x.space).unwrap_or(false)).unwrap_or(false) {
                        lines.last_mut().unwrap().pop();
                    }
                    lines.push(Vec::new());
                    lw = 0.0;
                }
                if wrap && t.space && lines.last().unwrap().is_empty() && !lines.is_empty() && lines.len() > 1 {
                    continue;
                }
                lw += t.width;
                lines.last_mut().unwrap().push(t);
            }
            for line in lines {
                let size = line.iter().map(|t| t.fmt.size).fold(0.0f32, f32::max).max(self.def.size * if line.is_empty() { 1.0 } else { 0.0 });
                let size = if size == 0.0 { self.def.size } else { size };
                let lh = line_h(size);
                let lwidth: f32 = line.iter().map(|t| t.width).sum();
                max_line_w = max_line_w.max(lwidth);
                let in_view = line_idx >= skip_lines && (y - b.y0 - gutter) + lh <= visible_height + 0.5 + lh * 0.0;
                if line_idx >= skip_lines {
                    if in_view || !wrap && !self.def.multiline {
                        cur_visible += 1;
                    } else if (y - b.y0 - gutter) + lh <= visible_height + lh {
                        cur_visible += 0;
                    }
                }
                if line_idx >= skip_lines && (in_view || !self.def.multiline) {
                    let mut x = match para.align {
                        Align::Left | Align::Justify => left,
                        Align::Center => left + (width - lwidth) * 0.5,
                        Align::Right => left + width - lwidth,
                    };
                    if self.auto_size {
                        x = left;
                    }
                    let baseline = y + font.ascent * size;
                    for t in &line {
                        for c in t.text.chars() {
                            let g = glyph_of(c);
                            if let Some(g) = g {
                                for m in &g.shape.meshes {
                                    let grp = match groups.iter_mut().find(|g| g.color == t.fmt.color) {
                                        Some(gp) => gp,
                                        None => {
                                            groups.push(Group { color: t.fmt.color, verts: vec![], idx: vec![] });
                                            groups.last_mut().unwrap()
                                        }
                                    };
                                    let base = grp.verts.len() as u32;
                                    grp.verts.extend(m.verts.iter().map(|v| [x + v[0] * t.fmt.size, baseline + v[1] * t.fmt.size]));
                                    grp.idx.extend(m.indices.iter().map(|i| i + base));
                                }
                            }
                            x += g.map(|g| g.advance * t.fmt.size).unwrap_or(0.35 * t.fmt.size) + t.fmt.letter_spacing;
                        }
                    }
                    y += lh;
                } else if line_idx < skip_lines {
                    // scrolled out: occupies no space
                } else {
                    y += lh;
                }
                line_idx += 1;
            }
        }
        out.groups = groups;
        out.lines = line_idx;
        out.visible_lines = if self.def.multiline && self.def.word_wrap {
            ((visible_height / line_h(self.def.size)).floor() as usize).max(1)
        } else {
            cur_visible.max(1)
        };
        out
    }
}

fn entity(s: &str) -> String {
    s.replace("&lt;", "<").replace("&gt;", ">").replace("&quot;", "\"").replace("&apos;", "'").replace("&nbsp;", " ").replace("&amp;", "&")
}

fn attr(tag: &str, name: &str) -> Option<String> {
    let key = format!("{}=\"", name);
    let i = tag.find(&key)? + key.len();
    let j = tag[i..].find('"')? + i;
    Some(tag[i..j].to_string())
}

fn parse_color(s: &str) -> Option<[f32; 4]> {
    let h = s.trim_start_matches('#');
    if h.len() != 6 {
        return None;
    }
    let v = u32::from_str_radix(h, 16).ok()?;
    Some([((v >> 16) & 255) as f32 / 255.0, ((v >> 8) & 255) as f32 / 255.0, (v & 255) as f32 / 255.0, 1.0])
}

/// The subset of Flash HTML text used by the game: p, br, font, b, i, u, a.
fn parse_html(html: &str, base: &Fmt, align: Align) -> Vec<Para> {
    let mut paras: Vec<Para> = Vec::new();
    let mut cur = Para { align, spans: vec![] };
    let mut fmt_stack: Vec<Fmt> = vec![base.clone()];
    let mut open_p = false;
    let mut i = 0;
    let b = html.as_bytes();
    let mut text = String::new();
    macro_rules! flush_text {
        () => {
            if !text.is_empty() {
                cur.spans.push(Span { text: entity(&std::mem::take(&mut text)), fmt: fmt_stack.last().unwrap().clone() });
            }
        };
    }
    while i < b.len() {
        if b[i] == b'<' {
            if let Some(end) = html[i..].find('>') {
                let tag = &html[i + 1..i + end];
                let name = tag.trim_start_matches('/').split_whitespace().next().unwrap_or("").to_lowercase();
                let closing = tag.starts_with('/');
                flush_text!();
                match (name.as_str(), closing) {
                    ("p", false) => {
                        if open_p || !cur.spans.is_empty() {
                            paras.push(std::mem::replace(&mut cur, Para { align, spans: vec![] }));
                        }
                        open_p = true;
                        if let Some(a) = attr(tag, "align") {
                            cur.align = match a.as_str() {
                                "center" => Align::Center,
                                "right" => Align::Right,
                                "justify" => Align::Justify,
                                _ => Align::Left,
                            };
                        }
                    }
                    ("p", true) => {
                        paras.push(std::mem::replace(&mut cur, Para { align, spans: vec![] }));
                        open_p = false;
                    }
                    ("br", _) => {
                        let a = cur.align;
                        paras.push(std::mem::replace(&mut cur, Para { align: a, spans: vec![] }));
                    }
                    ("font", false) => {
                        let mut f = fmt_stack.last().unwrap().clone();
                        if let Some(s) = attr(tag, "size") {
                            f.size = s.parse().unwrap_or(f.size);
                        }
                        if let Some(c) = attr(tag, "color").and_then(|c| parse_color(&c)) {
                            f.color = c;
                        }
                        if let Some(l) = attr(tag, "letterSpacing") {
                            f.letter_spacing = l.parse().unwrap_or(f.letter_spacing);
                        }
                        fmt_stack.push(f);
                    }
                    ("font", true) => {
                        if fmt_stack.len() > 1 {
                            fmt_stack.pop();
                        }
                    }
                    _ => {}
                }
                i += end + 1;
                continue;
            }
        }
        if b[i] == b'\r' || b[i] == b'\n' {
            // raw line breaks in Flash HTML text start a new line
            flush_text!();
            if b[i] == b'\r' && b.get(i + 1) == Some(&b'\n') {
                i += 1;
            }
            let a = cur.align;
            paras.push(std::mem::replace(&mut cur, Para { align: a, spans: vec![] }));
            i += 1;
            continue;
        }
        // plain character
        let ch = html[i..].chars().next().unwrap();
        text.push(ch);
        i += ch.len_utf8();
    }
    flush_text!();
    if !cur.spans.is_empty() || paras.is_empty() {
        paras.push(cur);
    }
    paras
}

pub fn draw(world: &World, rd: &mut Renderer, t: &TextField, m: &Matrix, cx: &CXform, blend: Blend, level: u8) {
    t.ensure_layout(world);
    let l = t.layout.borrow();
    let l = l.as_ref().unwrap();
    let (mode, sref) = if level > 0 { (StencilMode::Test, level) } else { (StencilMode::None, 0) };
    for g in &l.groups {
        rd.draw_transient(&g.verts, &g.idx, m, cx, &FillRef::Solid(g.color), blend_index(blend), mode, sref);
    }
}
