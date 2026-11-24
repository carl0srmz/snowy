//! Walks the display tree and records draw calls.
use crate::gfx::*;
use crate::movie::*;
use snow_fmt::*;

pub struct Scene<'a> {
    pub world: &'a World,
    /// interpolation factor between the previous and current logic tick (0..1)
    pub alpha: f32,
}

impl<'a> Scene<'a> {
    pub fn render(&self, rd: &mut Renderer, root: ClipId) {
        self.render_clip(rd, root, &Matrix::IDENTITY, &CXform::IDENTITY, Blend::Normal, 0, false);
    }

    /// `mask_geom`: draw geometry only into the stencil buffer (the clip is a mask shape).
    fn render_clip(&self, rd: &mut Renderer, id: ClipId, parent_m: &Matrix, parent_cx: &CXform, blend: Blend, level: u8, mask_geom: bool) {
        let Some(c) = self.world.clip(id) else { return };
        if !c.visible && !mask_geom {
            return;
        }
        let m = parent_m.mul(&self.world.local_matrix(id, self.alpha));
        let cx = parent_cx.concat(&c.cx);
        if cx.mul[3] <= 0.0 && cx.add[3] <= 0.0 && !mask_geom {
            return;
        }
        let blend = if c.blend != Blend::Normal && c.blend != Blend::Layer { c.blend } else { blend };
        if !c.filters.is_empty() && !mask_geom {
            // display-list filters: draw the subtree offscreen, filter it, composite with the clip's
            // own colour transform / blend / stencil level
            rd.begin_layer();
            self.render_node(rd, c, &m, &CXform::IDENTITY, Blend::Normal, 0, false);
            let (mode, sref) = if level > 0 { (StencilMode::Test, level) } else { (StencilMode::None, 0) };
            rd.end_layer(&c.filters, &cx, blend_index(blend), mode, sref);
            return;
        }
        self.render_node(rd, c, &m, &cx, blend, level, mask_geom);
    }

    fn render_node(&self, rd: &mut Renderer, c: &Clip, m: &Matrix, cx: &CXform, blend: Blend, level: u8, mask_geom: bool) {
        let (m, cx) = (m, cx);
        match &c.kind {
            Kind::Shape => {
                let l = &self.world.libs[c.lib as usize];
                if let Some(s) = l.shapes.get(&c.cid) {
                    self.draw_shape(rd, s, &m, &cx, blend, level, mask_geom);
                }
            }
            Kind::Morph => {
                let l = &self.world.libs[c.lib as usize];
                if let Some(frames) = l.morphs.get(&c.cid) {
                    let s = frames.range(..=c.ratio).next_back().map(|x| x.1).or_else(|| frames.values().next());
                    if let Some(s) = s {
                        self.draw_shape(rd, s, &m, &cx, blend, level, mask_geom);
                    }
                }
            }
            Kind::Text(t) => {
                if !mask_geom {
                    crate::text::draw(self.world, rd, t, &m, &cx, blend, level);
                }
            }
            Kind::Button { state } => {
                for ch in c.children.values() {
                    let Some(cc) = self.world.clip(*ch) else { continue };
                    let on = match state {
                        BtnState::Up => cc.btn_states.0,
                        BtnState::Over => cc.btn_states.1,
                        BtnState::Down => cc.btn_states.2,
                    };
                    if on {
                        self.render_clip(rd, *ch, &m, &cx, blend, level, mask_geom);
                    }
                }
            }
            Kind::Video => {}
            Kind::Image { tex, w, h } => {
                if !mask_geom {
                    let (w, h) = (*w as f32, *h as f32);
                    let v = [[0.0, 0.0], [w, 0.0], [w, h], [0.0, h]];
                    let idx = [0u32, 1, 2, 0, 2, 3];
                    let fill = FillRef::Bitmap { tex: *tex, size: (w as u32, h as u32), matrix: Matrix::IDENTITY, smooth: true, repeat: false };
                    let (mode, sref) = if level > 0 { (StencilMode::Test, level) } else { (StencilMode::None, 0) };
                    rd.draw_transient(&v, &idx, &m, &cx, &fill, blend_index(blend), mode, sref);
                }
            }
            Kind::Sprite => {
                if let (Some(r), false) = (c.mask, mask_geom) {
                    let v = [[r.x0, r.y0], [r.x1, r.y0], [r.x1, r.y1], [r.x0, r.y1]];
                    let idx = [0u32, 1, 2, 0, 2, 3];
                    let white = FillRef::Solid([1.0; 4]);
                    rd.draw_transient(&v, &idx, &m, &CXform::IDENTITY, &white, 0, StencilMode::MaskWrite, level);
                    self.render_children(rd, c, &m, &cx, blend, level + 1, mask_geom);
                    rd.draw_transient(&v, &idx, &m, &CXform::IDENTITY, &white, 0, StencilMode::MaskErase, level + 1);
                } else {
                    self.render_children(rd, c, &m, &cx, blend, level, mask_geom);
                }
            }
        }
    }

    fn render_children(&self, rd: &mut Renderer, c: &Clip, m: &Matrix, cx: &CXform, blend: Blend, level: u8, mask_geom: bool) {
        // active masks: (last masked depth, mask clip)
        let mut stack: Vec<(i32, ClipId)> = Vec::new();
        for (&depth, &kid) in c.children.iter() {
            while let Some(&(end, mk)) = stack.last() {
                if depth > end {
                    // remove the mask again before drawing anything outside its range
                    let l = level + stack.len() as u8;
                    self.render_mask(rd, mk, m, level + stack.len() as u8 - 1, l);
                    stack.pop();
                } else {
                    break;
                }
            }
            let Some(kc) = self.world.clip(kid) else { continue };
            if let Some(end) = kc.clip_depth {
                if !mask_geom {
                    let l = level + stack.len() as u8;
                    self.render_mask_write(rd, kid, m, l);
                    stack.push((end as i32, kid));
                }
                continue;
            }
            let lvl = level + stack.len() as u8;
            self.render_clip(rd, kid, m, cx, blend, lvl, mask_geom);
        }
        while let Some((_, mk)) = stack.pop() {
            let l = level + stack.len() as u8 + 1;
            self.render_mask(rd, mk, m, l - 1, l);
        }
    }

    fn render_mask_write(&self, rd: &mut Renderer, mask: ClipId, parent_m: &Matrix, level: u8) {
        self.mask_pass(rd, mask, parent_m, StencilMode::MaskWrite, level);
    }

    /// Erase the mask: decrement stencil where the mask shape covers (stencil == `cur`).
    fn render_mask(&self, rd: &mut Renderer, mask: ClipId, parent_m: &Matrix, _below: u8, cur: u8) {
        self.mask_pass(rd, mask, parent_m, StencilMode::MaskErase, cur);
    }

    fn mask_pass(&self, rd: &mut Renderer, mask: ClipId, parent_m: &Matrix, mode: StencilMode, sref: u8) {
        let prev = MASK_MODE.with(|m| m.replace(Some((mode, sref))));
        self.render_clip(rd, mask, parent_m, &CXform::IDENTITY, Blend::Normal, sref, true);
        MASK_MODE.with(|m| m.set(prev));
    }

    fn draw_shape(&self, rd: &mut Renderer, s: &crate::assets::GpuShape, m: &Matrix, cx: &CXform, blend: Blend, level: u8, mask_geom: bool) {
        let (mode, sref) = if mask_geom {
            MASK_MODE.with(|x| x.get()).unwrap_or((StencilMode::MaskWrite, level))
        } else if level > 0 {
            (StencilMode::Test, level)
        } else {
            (StencilMode::None, 0)
        };
        let b = blend_index(blend);
        for mf in &s.meshes {
            rd.draw(mf.mesh, m, cx, &mf.fill, if mask_geom { 0 } else { b }, mode, sref);
        }
    }
}

thread_local! {
    static MASK_MODE: std::cell::Cell<Option<(StencilMode, u8)>> = const { std::cell::Cell::new(None) };
}

/// Letterboxed viewport (x, y, w, h) for a stage inside a window.
pub fn fit_viewport(win_w: u32, win_h: u32, stage_w: f32, stage_h: f32) -> [f32; 4] {
    let s = (win_w as f32 / stage_w).min(win_h as f32 / stage_h);
    let (w, h) = (stage_w * s, stage_h * s);
    [((win_w as f32 - w) * 0.5).floor(), ((win_h as f32 - h) * 0.5).floor(), w.floor(), h.floor()]
}

/// `view` uniform mapping stage pixels (0..w, 0..h) to clip space.
pub fn stage_view(stage_w: f32, stage_h: f32) -> [f32; 4] {
    [2.0 / stage_w, -2.0 / stage_h, -1.0, 1.0]
}
