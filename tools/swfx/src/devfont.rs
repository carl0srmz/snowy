//! Device fonts. A text field without embedded outlines is drawn by Flash with a system font
//! (in this game: the impressum's "Verdana"). The converter turns a free font with similar
//! metrics (DejaVu Sans, derived from Bitstream Vera) into the same glyph format as the SWF
//! fonts, so the game needs no font rasteriser.
use crate::shapes::{tessellate, Tess};
use anyhow::{anyhow, Result};
use snow_fmt::{FontDef, GlyphDef, Rect};
use swf::{FillStyle, Point, PointDelta, ShapeRecord, StyleChangeData, Twips};

/// EM square used for the glyph records (as a DefineFont3: 1024 px = 20480 twips).
const EM_TWIPS: f64 = 20480.0;

struct Builder {
    scale: f64,
    records: Vec<ShapeRecord>,
    /// current pen position in twips
    cur: (i32, i32),
}

impl Builder {
    fn pt(&self, x: f32, y: f32) -> (i32, i32) {
        // font units, y up -> twips, y down
        ((x as f64 * self.scale).round() as i32, (-(y as f64) * self.scale).round() as i32)
    }
}

impl ttf_parser::OutlineBuilder for Builder {
    fn move_to(&mut self, x: f32, y: f32) {
        let p = self.pt(x, y);
        self.records.push(ShapeRecord::StyleChange(Box::new(StyleChangeData {
            move_to: Some(Point::new(Twips::new(p.0), Twips::new(p.1))),
            fill_style_0: None,
            fill_style_1: Some(1),
            line_style: None,
            new_styles: None,
        })));
        self.cur = p;
    }
    fn line_to(&mut self, x: f32, y: f32) {
        let p = self.pt(x, y);
        self.records.push(ShapeRecord::StraightEdge { delta: PointDelta::new(Twips::new(p.0 - self.cur.0), Twips::new(p.1 - self.cur.1)) });
        self.cur = p;
    }
    fn quad_to(&mut self, x1: f32, y1: f32, x: f32, y: f32) {
        let c = self.pt(x1, y1);
        let p = self.pt(x, y);
        self.records.push(ShapeRecord::CurvedEdge {
            control_delta: PointDelta::new(Twips::new(c.0 - self.cur.0), Twips::new(c.1 - self.cur.1)),
            anchor_delta: PointDelta::new(Twips::new(p.0 - c.0), Twips::new(p.1 - c.1)),
        });
        self.cur = p;
    }
    fn curve_to(&mut self, x1: f32, y1: f32, x2: f32, y2: f32, x: f32, y: f32) {
        // cubic (CFF fonts): two quadratic halves are plenty at text sizes
        let (x0, y0) = ((self.cur.0 as f64 / self.scale) as f32, (-(self.cur.1 as f64) / self.scale) as f32);
        let mid = |a: f32, b: f32| (a + b) * 0.5;
        let (mx, my) = (
            0.125 * x0 + 0.375 * x1 + 0.375 * x2 + 0.125 * x,
            0.125 * y0 + 0.375 * y1 + 0.375 * y2 + 0.125 * y,
        );
        self.quad_to(mid(x0, x1), mid(y0, y1), mx, my);
        self.quad_to(mid(x2, x), mid(y2, y), x, y);
    }
    fn close(&mut self) {}
}

/// The characters the game's texts can contain (Latin-1 plus typographic punctuation).
fn charset() -> Vec<char> {
    let mut v: Vec<char> = (0x20u32..=0x7e).chain(0xa0..=0xff).filter_map(char::from_u32).collect();
    v.extend(['€', '–', '—', '‘', '’', '‚', '“', '”', '„', '•', '…', '™', '‹', '›']);
    v
}

pub fn build(name: &str, ttf: &[u8]) -> Result<FontDef> {
    let face = ttf_parser::Face::parse(ttf, 0).map_err(|e| anyhow!("font: {e}"))?;
    let upem = face.units_per_em() as f64;
    let scale = EM_TWIPS / upem;
    let em_px = (EM_TWIPS / 20.0) as f32;
    let white = [FillStyle::Color(swf::Color { r: 255, g: 255, b: 255, a: 255 })];
    let mut tess = Tess::new();
    let mut glyphs = Vec::new();
    for c in charset() {
        let Some(id) = face.glyph_index(c) else { continue };
        let mut b = Builder { scale, records: Vec::new(), cur: (0, 0) };
        let _ = face.outline_glyph(id, &mut b);
        let mut shape = tessellate(&mut tess, &b.records, &white, &[], Rect::default());
        for m in &mut shape.meshes {
            for v in &mut m.verts {
                v[0] /= em_px;
                v[1] /= em_px;
            }
        }
        let advance = face.glyph_hor_advance(id).unwrap_or(0) as f64 / upem;
        glyphs.push(GlyphDef { code: c as u32 as u16, advance: advance as f32, shape });
    }
    // The face stands in for Verdana (the font the impressum asks for); lines are laid out with
    // Verdana's Windows metrics (usWinAscent 2059, usWinDescent 430 per 2048) like Flash did.
    let _ = (face.ascender(), face.descender());
    Ok(FontDef {
        name: name.to_string(),
        ascent: 2059.0 / 2048.0,
        descent: 430.0 / 2048.0,
        leading: (face.line_gap() as f64 / upem) as f32,
        bold: false,
        italic: false,
        glyphs,
        kerning: Vec::new(),
    })
}
