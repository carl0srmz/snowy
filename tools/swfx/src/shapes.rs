//! SWF shape records -> tessellated GPU meshes.
use lyon::math::point;
use lyon::path::Path;
use lyon::tessellation::{
    BuffersBuilder, FillOptions, FillRule, FillTessellator, FillVertex, LineCap, LineJoin, StrokeOptions,
    StrokeTessellator, StrokeVertex, VertexBuffers,
};
use snow_fmt::*;
use std::collections::HashMap;
use swf::{FillStyle, LineStyle, Rectangle, ShapeRecord, Twips};

pub fn tw(t: Twips) -> f32 {
    t.get() as f32 / 20.0
}

pub fn rect(r: &Rectangle<Twips>) -> Rect {
    Rect { x0: tw(r.x_min), y0: tw(r.y_min), x1: tw(r.x_max), y1: tw(r.y_max) }
}

pub fn matrix(m: &swf::Matrix) -> Matrix {
    Matrix {
        a: m.a.to_f32(),
        b: m.b.to_f32(),
        c: m.c.to_f32(),
        d: m.d.to_f32(),
        tx: tw(m.tx),
        ty: tw(m.ty),
    }
}

pub fn color(c: &swf::Color) -> [f32; 4] {
    [c.r as f32 / 255.0, c.g as f32 / 255.0, c.b as f32 / 255.0, c.a as f32 / 255.0]
}

pub fn convert_fill(f: &FillStyle) -> Fill {
    match f {
        FillStyle::Color(c) => Fill::Solid(color(c)),
        FillStyle::LinearGradient(g) => Fill::Gradient(grad(g, GradKind::Linear)),
        FillStyle::RadialGradient(g) => Fill::Gradient(grad(g, GradKind::Radial)),
        FillStyle::FocalGradient { gradient, focal_point } => {
            Fill::Gradient(grad(gradient, GradKind::Focal(focal_point.to_f32())))
        }
        FillStyle::Bitmap { id, matrix: m, is_smoothed, is_repeating } => {
            Fill::Bitmap(BitmapFill { id: *id, matrix: matrix(m), smooth: *is_smoothed, repeat: *is_repeating })
        }
    }
}

fn grad(g: &swf::Gradient, kind: GradKind) -> GradFill {
    GradFill {
        kind,
        matrix: matrix(&g.matrix),
        spread: match g.spread {
            swf::GradientSpread::Pad => Spread::Pad,
            swf::GradientSpread::Reflect => Spread::Reflect,
            swf::GradientSpread::Repeat => Spread::Repeat,
        },
        linear_rgb: g.interpolation == swf::GradientInterpolation::LinearRgb,
        stops: g.records.iter().map(|r| (r.ratio as f32 / 255.0, color(&r.color))).collect(),
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Hash, Debug)]
struct Pt(i32, i32);

#[derive(Clone, Debug)]
struct Seg {
    start: Pt,
    /// (optional control point, end point)
    edges: Vec<(Option<Pt>, Pt)>,
    fill0: usize,
    fill1: usize,
    line: usize,
}

impl Seg {
    fn end(&self) -> Pt {
        self.edges.last().map(|e| e.1).unwrap_or(self.start)
    }
    fn reversed(&self) -> Seg {
        let mut pts = vec![self.start];
        pts.extend(self.edges.iter().map(|e| e.1));
        let mut edges = Vec::new();
        for i in (0..self.edges.len()).rev() {
            edges.push((self.edges[i].0, pts[i]));
        }
        Seg { start: self.end(), edges, fill0: self.fill1, fill1: self.fill0, line: self.line }
    }
}

struct Group {
    fills: Vec<FillStyle>,
    lines: Vec<LineStyle>,
    segs: Vec<Seg>,
}

fn px(p: Pt) -> lyon::math::Point {
    point(p.0 as f32 / 20.0, p.1 as f32 / 20.0)
}

fn flatten_segments(segs: &[&Seg]) -> Vec<Vec<(Pt, Seg)>> {
    // Chain segments end->start into closed or open polylines.
    let mut by_start: HashMap<Pt, Vec<usize>> = HashMap::new();
    for (i, s) in segs.iter().enumerate() {
        by_start.entry(s.start).or_default().push(i);
    }
    let mut used = vec![false; segs.len()];
    let mut out = Vec::new();
    for i in 0..segs.len() {
        if used[i] {
            continue;
        }
        used[i] = true;
        let mut chain = vec![(segs[i].start, segs[i].clone())];
        let first = segs[i].start;
        let mut cur = segs[i].end();
        while cur != first {
            let next = by_start.get(&cur).and_then(|v| v.iter().copied().find(|&j| !used[j]));
            match next {
                Some(j) => {
                    used[j] = true;
                    chain.push((segs[j].start, segs[j].clone()));
                    cur = segs[j].end();
                }
                None => break,
            }
        }
        out.push(chain);
    }
    out
}

fn build_path(chains: &[Vec<(Pt, Seg)>], close: bool) -> Path {
    let mut b = Path::builder();
    for chain in chains {
        let first = chain[0].1.start;
        b.begin(px(first));
        for (_, seg) in chain {
            for (c, e) in &seg.edges {
                match c {
                    Some(c) => {
                        b.quadratic_bezier_to(px(*c), px(*e));
                    }
                    None => {
                        b.line_to(px(*e));
                    }
                }
            }
        }
        b.end(close);
    }
    b.build()
}

pub struct Tess {
    fill: FillTessellator,
    stroke: StrokeTessellator,
}

impl Tess {
    pub fn new() -> Tess {
        Tess { fill: FillTessellator::new(), stroke: StrokeTessellator::new() }
    }
}

fn parse_records(records: &[ShapeRecord], fills: Vec<FillStyle>, lines: Vec<LineStyle>) -> Vec<Group> {
    let mut groups = vec![Group { fills, lines, segs: vec![] }];
    let (mut f0, mut f1, mut l) = (0usize, 0usize, 0usize);
    let mut pos = Pt(0, 0);
    let mut cur: Option<Seg> = None;
    macro_rules! flush {
        () => {
            if let Some(s) = cur.take() {
                if !s.edges.is_empty() {
                    groups.last_mut().unwrap().segs.push(s);
                }
            }
        };
    }
    for r in records {
        match r {
            ShapeRecord::StyleChange(sc) => {
                flush!();
                if let Some(ns) = &sc.new_styles {
                    groups.push(Group { fills: ns.fill_styles.clone(), lines: ns.line_styles.clone(), segs: vec![] });
                    f0 = 0;
                    f1 = 0;
                    l = 0;
                }
                if let Some(mt) = sc.move_to {
                    pos = Pt(mt.x.get(), mt.y.get());
                }
                if let Some(v) = sc.fill_style_0 {
                    f0 = v as usize;
                }
                if let Some(v) = sc.fill_style_1 {
                    f1 = v as usize;
                }
                if let Some(v) = sc.line_style {
                    l = v as usize;
                }
            }
            ShapeRecord::StraightEdge { delta } => {
                let s = cur.get_or_insert(Seg { start: pos, edges: vec![], fill0: f0, fill1: f1, line: l });
                let np = Pt(pos.0 + delta.dx.get(), pos.1 + delta.dy.get());
                s.edges.push((None, np));
                pos = np;
            }
            ShapeRecord::CurvedEdge { control_delta, anchor_delta } => {
                let s = cur.get_or_insert(Seg { start: pos, edges: vec![], fill0: f0, fill1: f1, line: l });
                let c = Pt(pos.0 + control_delta.dx.get(), pos.1 + control_delta.dy.get());
                let np = Pt(c.0 + anchor_delta.dx.get(), c.1 + anchor_delta.dy.get());
                s.edges.push((Some(c), np));
                pos = np;
            }
        }
    }
    flush!();
    groups
}

pub fn tessellate(tess: &mut Tess, records: &[ShapeRecord], fills: &[FillStyle], lines: &[LineStyle], bounds: Rect) -> ShapeDef {
    let groups = parse_records(records, fills.to_vec(), lines.to_vec());
    let mut meshes = Vec::new();
    for g in &groups {
        // fills, in style order
        for (fi, fs) in g.fills.iter().enumerate() {
            let idx = fi + 1;
            let mut segs: Vec<Seg> = Vec::new();
            for s in &g.segs {
                if s.fill1 == idx {
                    segs.push(s.clone());
                }
                if s.fill0 == idx {
                    segs.push(s.reversed());
                }
            }
            if segs.is_empty() {
                continue;
            }
            let refs: Vec<&Seg> = segs.iter().collect();
            let chains = flatten_segments(&refs);
            let path = build_path(&chains, true);
            let mut buf: VertexBuffers<[f32; 2], u32> = VertexBuffers::new();
            let res = tess.fill.tessellate_path(
                &path,
                &FillOptions::default().with_fill_rule(FillRule::EvenOdd).with_tolerance(0.01),
                &mut BuffersBuilder::new(&mut buf, |v: FillVertex| v.position().to_array()),
            );
            if res.is_ok() && !buf.indices.is_empty() {
                meshes.push(Mesh { fill: convert_fill(fs), verts: buf.vertices, indices: buf.indices });
            }
        }
        // strokes, in style order
        for (li, ls) in g.lines.iter().enumerate() {
            let idx = li + 1;
            let segs: Vec<&Seg> = g.segs.iter().filter(|s| s.line == idx).collect();
            if segs.is_empty() {
                continue;
            }
            let chains = flatten_segments(&segs);
            let mut buf: VertexBuffers<[f32; 2], u32> = VertexBuffers::new();
            let width = (ls.width().get() as f32 / 20.0).max(1.0);
            let cap = match ls.start_cap() {
                swf::LineCapStyle::None => LineCap::Butt,
                swf::LineCapStyle::Round => LineCap::Round,
                swf::LineCapStyle::Square => LineCap::Square,
            };
            let join = match ls.join_style() {
                swf::LineJoinStyle::Round => LineJoin::Round,
                swf::LineJoinStyle::Bevel => LineJoin::Bevel,
                swf::LineJoinStyle::Miter(_) => LineJoin::MiterClip,
            };
            for chain in &chains {
                let closed = chain.first().map(|c| c.1.start) == chain.last().map(|c| c.1.end());
                let path = build_path(std::slice::from_ref(chain), closed);
                let opts = StrokeOptions::default()
                    .with_line_width(width)
                    .with_line_cap(cap)
                    .with_line_join(join)
                    .with_tolerance(0.01);
                let _ = tess.stroke.tessellate_path(
                    &path,
                    &opts,
                    &mut BuffersBuilder::new(&mut buf, |v: StrokeVertex| v.position().to_array()),
                );
            }
            if !buf.indices.is_empty() {
                meshes.push(Mesh { fill: convert_fill(ls.fill_style()), verts: buf.vertices, indices: buf.indices });
            }
        }
    }
    ShapeDef { bounds, meshes }
}
