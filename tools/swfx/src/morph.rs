//! Morph shape interpolation (tessellated per used ratio).
use crate::shapes::{tessellate, Tess};
use snow_fmt::{Rect, ShapeDef};
use swf::{
    Color, DefineMorphShape, FillStyle, Fixed8, Gradient, GradientRecord, LineStyle, Matrix, PointDelta, ShapeRecord,
    StyleChangeData, Twips,
};

fn lerp_i(a: i32, b: i32, t: f32) -> i32 {
    (a as f32 + (b - a) as f32 * t).round() as i32
}

fn lerp_u8(a: u8, b: u8, t: f32) -> u8 {
    (a as f32 + (b as f32 - a as f32) * t).round().clamp(0.0, 255.0) as u8
}

fn lerp_color(a: &Color, b: &Color, t: f32) -> Color {
    Color { r: lerp_u8(a.r, b.r, t), g: lerp_u8(a.g, b.g, t), b: lerp_u8(a.b, b.b, t), a: lerp_u8(a.a, b.a, t) }
}

fn lerp_matrix(a: &Matrix, b: &Matrix, t: f32) -> Matrix {
    let f = |x: f32, y: f32| x + (y - x) * t;
    Matrix {
        a: swf::Fixed16::from_f32(f(a.a.to_f32(), b.a.to_f32())),
        b: swf::Fixed16::from_f32(f(a.b.to_f32(), b.b.to_f32())),
        c: swf::Fixed16::from_f32(f(a.c.to_f32(), b.c.to_f32())),
        d: swf::Fixed16::from_f32(f(a.d.to_f32(), b.d.to_f32())),
        tx: Twips::new(lerp_i(a.tx.get(), b.tx.get(), t)),
        ty: Twips::new(lerp_i(a.ty.get(), b.ty.get(), t)),
    }
}

fn lerp_grad(a: &Gradient, b: &Gradient, t: f32) -> Gradient {
    let n = a.records.len().min(b.records.len());
    let records = (0..n)
        .map(|i| GradientRecord {
            ratio: lerp_u8(a.records[i].ratio, b.records[i].ratio, t),
            color: lerp_color(&a.records[i].color, &b.records[i].color, t),
        })
        .collect();
    Gradient { matrix: lerp_matrix(&a.matrix, &b.matrix, t), spread: a.spread, interpolation: a.interpolation, records }
}

fn lerp_fill(a: &FillStyle, b: &FillStyle, t: f32) -> FillStyle {
    match (a, b) {
        (FillStyle::Color(x), FillStyle::Color(y)) => FillStyle::Color(lerp_color(x, y, t)),
        (FillStyle::LinearGradient(x), FillStyle::LinearGradient(y)) => FillStyle::LinearGradient(lerp_grad(x, y, t)),
        (FillStyle::RadialGradient(x), FillStyle::RadialGradient(y)) => FillStyle::RadialGradient(lerp_grad(x, y, t)),
        (FillStyle::Bitmap { id, matrix: m1, is_smoothed, is_repeating }, FillStyle::Bitmap { matrix: m2, .. }) => {
            FillStyle::Bitmap { id: *id, matrix: lerp_matrix(m1, m2, t), is_smoothed: *is_smoothed, is_repeating: *is_repeating }
        }
        _ => a.clone(),
    }
}

fn lerp_line(a: &LineStyle, b: &LineStyle, t: f32) -> LineStyle {
    let w = lerp_i(a.width().get(), b.width().get(), t);
    a.clone().with_width(Twips::new(w)).with_fill_style(lerp_fill(a.fill_style(), b.fill_style(), t))
}

fn lerp_pd(a: &PointDelta<Twips>, b: &PointDelta<Twips>, t: f32) -> PointDelta<Twips> {
    PointDelta::new(Twips::new(lerp_i(a.dx.get(), b.dx.get(), t)), Twips::new(lerp_i(a.dy.get(), b.dy.get(), t)))
}

/// Straight edges are promoted to curves when only one side is curved.
fn as_curve(r: &ShapeRecord) -> Option<(PointDelta<Twips>, PointDelta<Twips>)> {
    match r {
        ShapeRecord::CurvedEdge { control_delta, anchor_delta } => Some((*control_delta, *anchor_delta)),
        ShapeRecord::StraightEdge { delta } => {
            let half = PointDelta::new(Twips::new(delta.dx.get() / 2), Twips::new(delta.dy.get() / 2));
            let rest = PointDelta::new(Twips::new(delta.dx.get() - half.dx.get()), Twips::new(delta.dy.get() - half.dy.get()));
            Some((half, rest))
        }
        _ => None,
    }
}

pub fn tessellate_morph(tess: &mut Tess, def: &DefineMorphShape, ratio: u16) -> ShapeDef {
    let t = ratio as f32 / 65535.0;
    let fills: Vec<FillStyle> = def.start.fill_styles.iter().zip(&def.end.fill_styles).map(|(a, b)| lerp_fill(a, b, t)).collect();
    let lines: Vec<LineStyle> = def.start.line_styles.iter().zip(&def.end.line_styles).map(|(a, b)| lerp_line(a, b, t)).collect();
    // The end shape carries only geometry; pair its edge records with the start shape's records.
    let end_edges: Vec<&ShapeRecord> = def.end.shape.iter().collect();
    let mut recs = Vec::new();
    let mut ei = 0usize;
    for r in &def.start.shape {
        match r {
            ShapeRecord::StyleChange(sc) => {
                // the matching end record is a style change too (moves only matter)
                let mut moved = sc.move_to;
                if let Some(ShapeRecord::StyleChange(esc)) = end_edges.get(ei) {
                    if let (Some(a), Some(b)) = (sc.move_to, esc.move_to) {
                        moved = Some(swf::Point::new(Twips::new(lerp_i(a.x.get(), b.x.get(), t)), Twips::new(lerp_i(a.y.get(), b.y.get(), t))));
                    }
                    ei += 1;
                } else if sc.move_to.is_some() {
                    // end shape may omit style-only changes; keep going
                }
                recs.push(ShapeRecord::StyleChange(Box::new(StyleChangeData {
                    move_to: moved,
                    fill_style_0: sc.fill_style_0,
                    fill_style_1: sc.fill_style_1,
                    line_style: sc.line_style,
                    new_styles: None,
                })));
            }
            edge => {
                // skip end-side style changes between edges
                while let Some(ShapeRecord::StyleChange(_)) = end_edges.get(ei) {
                    ei += 1;
                }
                let e = end_edges.get(ei).copied();
                ei += 1;
                match (edge, e) {
                    (ShapeRecord::StraightEdge { delta: a }, Some(ShapeRecord::StraightEdge { delta: b })) => {
                        recs.push(ShapeRecord::StraightEdge { delta: lerp_pd(a, b, t) });
                    }
                    (a, Some(b)) => {
                        if let (Some((ac, aa)), Some((bc, ba))) = (as_curve(a), as_curve(b)) {
                            recs.push(ShapeRecord::CurvedEdge { control_delta: lerp_pd(&ac, &bc, t), anchor_delta: lerp_pd(&aa, &ba, t) });
                        } else {
                            recs.push(a.clone());
                        }
                    }
                    (a, None) => recs.push(a.clone()),
                }
            }
        }
    }
    let b0 = &def.start.shape_bounds;
    let b1 = &def.end.shape_bounds;
    let l = |a: Twips, b: Twips| lerp_i(a.get(), b.get(), t) as f32 / 20.0;
    let bounds = Rect { x0: l(b0.x_min, b1.x_min), y0: l(b0.y_min, b1.y_min), x1: l(b0.x_max, b1.x_max), y1: l(b0.y_max, b1.y_max) };
    let _ = Fixed8::ONE;
    tessellate(tess, &recs, &fills, &lines, bounds)
}
