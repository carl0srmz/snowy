//! The v2 `UIScrollBar` component (Macromedia mx.controls) used next to long text fields
//! (the impressum). Its ActionScript is not run; the bar is assembled here from the same skin
//! symbols the component attaches (ScrollTrack, ScrollUpArrowUp, ScrollThumb...), laid out and
//! driven like the component: arrows scroll a line, the track a page, the thumb drags, and a held
//! arrow/track repeats after a delay.
use crate::level::LHost;
use crate::movie::*;
use crate::ui::*;
use snow_fmt::{Matrix, Rect};

/// ScrollBar.repeatDelay (500 ms) and repeatInterval (35 ms) at the game's 34 fps.
const REPEAT_DELAY: u32 = 17;
const REPEAT_EVERY: u32 = 1;

#[derive(Clone, Copy, PartialEq, Debug)]
enum Op {
    Line(i32),
    Page(i32),
    Drag(f32),
}

pub struct ScrollBar {
    root: ClipId,
    target: ClipId,
    height: f32,
    width: f32,
    track_top: f32,
    track_h: f32,
    up: ClipId,
    down: ClipId,
    track: ClipId,
    thumb: ClipId,
    thumb_top: ClipId,
    thumb_mid: ClipId,
    thumb_bot: ClipId,
    thumb_grip: ClipId,
    /// current thumb geometry (y, height) in bar coordinates
    thumb_y: f32,
    thumb_h: f32,
    op: Option<(Op, u32)>,
}

impl Ui {
    /// Finds every UIScrollBar instance in the main movie and builds it.
    pub fn build_scrollbars(&mut self) {
        let mut found = Vec::new();
        for (i, c) in self.world.clips.iter().enumerate() {
            let Some(c) = c else { continue };
            if let Some(Value::Str(t)) = c.vars.get("_targetInstanceName") {
                found.push((i as ClipId, t.clone()));
            }
        }
        for (root, target) in found {
            let parent = self.world.clip(root).map(|c| c.parent).unwrap_or(NONE);
            let target = self.world.path(parent, &target);
            if target == NONE {
                continue;
            }
            if let Some(sb) = self.make_scrollbar(root, target) {
                self.scrollbars.push(sb);
            }
        }
    }

    fn part(&mut self, root: ClipId, link: &str, depth: i32) -> ClipId {
        let lib = self.world.clip(root).map(|c| c.lib).unwrap_or(0);
        let mut h = LHost::default();
        self.world.attach_from(root, lib, link, link, depth, &mut h).unwrap_or(NONE)
    }

    fn part_bounds(&self, c: ClipId) -> Rect {
        self.world.bounds_in(c, c).unwrap_or(Rect { x0: 0.0, y0: 0.0, x1: 16.0, y1: 16.0 })
    }

    /// Places `c` so that its bounds' top-left is at (x, y), scaled to height `h` if given.
    fn place_part(&mut self, c: ClipId, x: f32, y: f32, h: Option<f32>) {
        let b = self.part_bounds(c);
        let sy = match h {
            Some(h) if b.height() > 0.0 => h / b.height(),
            _ => 1.0,
        };
        if let Some(cl) = self.world.clip_mut(c) {
            cl.m = Matrix { a: 1.0, b: 0.0, c: 0.0, d: sy, tx: x - b.x0, ty: y - b.y0 * sy };
            cl.prev_m = cl.m;
        }
    }

    fn make_scrollbar(&mut self, root: ClipId, target: ClipId) -> Option<ScrollBar> {
        // UIObject.init: the authored size is the scaled bounding box, then the scale is reset
        let parent = self.world.clip(root)?.parent;
        let b = self.world.bounds_in(root, parent)?;
        let (width, height) = (16.0f32, b.height().max(48.0));
        let kids: Vec<ClipId> = self.world.clip(root)?.children.values().copied().collect();
        for k in kids {
            self.world.remove(k);
        }
        if let Some(c) = self.world.clip_mut(root) {
            c.m.a = 1.0;
            c.m.b = 0.0;
            c.m.c = 0.0;
            c.m.d = 1.0;
            c.prev_m = c.m;
            c.playing = false;
            c.interactive = true;
        }
        let track = self.part(root, "ScrollTrack", 1);
        let up = self.part(root, "ScrollUpArrowUp", 2);
        let down = self.part(root, "ScrollDownArrowUp", 3);
        let thumb = self.world.create_empty(root, "thumb", 4);
        let thumb_top = self.part(thumb, "ScrollThumbTopUp", 1);
        let thumb_mid = self.part(thumb, "ScrollThumbMiddleUp", 2);
        let thumb_bot = self.part(thumb, "ScrollThumbBottomUp", 3);
        let thumb_grip = self.part(thumb, "ScrollThumbGripUp", 4);
        let up_h = self.part_bounds(up).height();
        let down_h = self.part_bounds(down).height();
        self.place_part(up, 0.0, 0.0, None);
        self.place_part(down, 0.0, height - down_h, None);
        let track_top = up_h;
        let track_h = (height - up_h - down_h).max(1.0);
        self.place_part(track, 0.0, track_top, Some(track_h));
        let sb = ScrollBar {
            root,
            target,
            height,
            width,
            track_top,
            track_h,
            up,
            down,
            track,
            thumb,
            thumb_top,
            thumb_mid,
            thumb_bot,
            thumb_grip,
            thumb_y: track_top,
            thumb_h: 0.0,
            op: None,
        };
        let idx = self.scrollbars.len();
        self.on_clip(up, Evt::Press, move |u| u.scrollbar_start(idx, Op::Line(-1)));
        self.on_clip(down, Evt::Press, move |u| u.scrollbar_start(idx, Op::Line(1)));
        self.on_clip(track, Evt::Press, move |u| {
            let y = u.scrollbar_mouse_y(idx);
            let below = u.scrollbars.get(idx).map(|s| y > s.thumb_y + s.thumb_h).unwrap_or(true);
            u.scrollbar_start(idx, Op::Page(if below { 1 } else { -1 }));
        });
        self.on_clip(thumb, Evt::Press, move |u| {
            let y = u.scrollbar_mouse_y(idx);
            let off = u.scrollbars.get(idx).map(|s| y - s.thumb_y).unwrap_or(0.0);
            if let Some(s) = u.scrollbars.get_mut(idx) {
                s.op = Some((Op::Drag(off), 0));
            }
        });
        Some(sb)
    }

    fn scrollbar_mouse_y(&self, idx: usize) -> f32 {
        let Some(s) = self.scrollbars.get(idx) else { return 0.0 };
        let m = self.world.world_matrix(s.root).inverse();
        let (x, y) = self.mouse;
        m.b * x + m.d * y + m.ty
    }

    /// (scroll, maxscroll, visible lines) of the target field
    fn scroll_state(&self, target: ClipId) -> (u32, u32, u32) {
        let max = self.world.text_field(target).map(|t| t.max_scroll(&self.world)).unwrap_or(1);
        let lines = self.world.text_field(target).map(|t| t.visible_line_count(&self.world)).unwrap_or(1).max(1);
        let cur = self.world.text_field(target).map(|t| t.scroll.max(1)).unwrap_or(1);
        (cur.min(max), max, lines as u32)
    }

    fn set_scroll(&mut self, target: ClipId, v: i32) {
        let (_, max, _) = self.scroll_state(target);
        if let Some(t) = self.world.text_field_mut(target) {
            let v = v.clamp(1, max as i32) as u32;
            if t.scroll != v {
                t.scroll = v;
                t.invalidate();
            }
        }
    }

    fn scrollbar_step(&mut self, idx: usize, op: Op) {
        let Some(target) = self.scrollbars.get(idx).map(|s| s.target) else { return };
        let (cur, _, page) = self.scroll_state(target);
        match op {
            Op::Line(d) => self.set_scroll(target, cur as i32 + d),
            Op::Page(d) => self.set_scroll(target, cur as i32 + d * page as i32),
            Op::Drag(_) => {}
        }
    }

    fn scrollbar_start(&mut self, idx: usize, op: Op) {
        self.scrollbar_step(idx, op);
        if let Some(s) = self.scrollbars.get_mut(idx) {
            s.op = Some((op, 0));
        }
    }

    /// Per tick: auto-repeat / dragging while the button is held, thumb layout from the field.
    pub fn scrollbars_tick(&mut self) {
        for idx in 0..self.scrollbars.len() {
            let (root, target) = (self.scrollbars[idx].root, self.scrollbars[idx].target);
            if !self.world.alive(root) || !self.world.alive(target) {
                continue;
            }
            // held operations
            if let Some((op, n)) = self.scrollbars[idx].op {
                if self.pressed == NONE {
                    self.scrollbars[idx].op = None;
                } else {
                    match op {
                        Op::Drag(off) => {
                            let y = self.scrollbar_mouse_y(idx) - off;
                            let s = &self.scrollbars[idx];
                            let (_, max, _) = self.scroll_state(target);
                            let span = (s.track_h - s.thumb_h).max(1.0);
                            let f = ((y - s.track_top) / span).clamp(0.0, 1.0);
                            let v = 1 + (f * (max.saturating_sub(1)) as f32).round() as i32;
                            self.set_scroll(target, v);
                        }
                        _ => {
                            let n = n + 1;
                            self.scrollbars[idx].op = Some((op, n));
                            if n >= REPEAT_DELAY && (n - REPEAT_DELAY) % REPEAT_EVERY == 0 {
                                // a page repeat stops once the thumb reaches the mouse
                                let go = match op {
                                    Op::Page(d) => {
                                        let y = self.scrollbar_mouse_y(idx);
                                        let s = &self.scrollbars[idx];
                                        if d > 0 { y > s.thumb_y + s.thumb_h } else { y < s.thumb_y }
                                    }
                                    _ => true,
                                };
                                if go {
                                    self.scrollbar_step(idx, op);
                                }
                            }
                        }
                    }
                }
            }
            // thumb from the field's scroll position (ScrollBar.setScrollProperties)
            let (cur, max, page) = self.scroll_state(target);
            let s = &self.scrollbars[idx];
            let total = (max - 1 + page) as f32;
            let thumb_h = if max <= 1 { 0.0 } else { (s.track_h * page as f32 / total).max(14.0).min(s.track_h) };
            let thumb_y = if max <= 1 { s.track_top } else { s.track_top + (s.track_h - thumb_h) * (cur - 1) as f32 / (max - 1) as f32 };
            let (thumb, top, mid, bot, grip) = (s.thumb, s.thumb_top, s.thumb_mid, s.thumb_bot, s.thumb_grip);
            let changed = (thumb_h - s.thumb_h).abs() > 0.01 || (thumb_y - s.thumb_y).abs() > 0.01;
            self.scrollbars[idx].thumb_h = thumb_h;
            self.scrollbars[idx].thumb_y = thumb_y;
            if changed || self.world.clip(thumb).map(|c| c.visible == (max <= 1)).unwrap_or(false) {
                self.world.set_var(thumb, "_visible", Value::Bool(max > 1));
                let th = self.part_bounds(top).height();
                let bh = self.part_bounds(bot).height();
                let mh = (thumb_h - th - bh).max(0.0);
                self.place_part(top, 0.0, 0.0, None);
                self.place_part(mid, 0.0, th, Some(mh.max(0.01)));
                self.place_part(bot, 0.0, th + mh, None);
                let gb = self.part_bounds(grip);
                self.place_part(grip, (16.0 - gb.width()) * 0.5, (thumb_h - gb.height()) * 0.5, None);
                if let Some(c) = self.world.clip_mut(thumb) {
                    c.m = Matrix { a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: thumb_y };
                    c.prev_m = c.m;
                }
            }
            let _ = (self.scrollbars[idx].width, self.scrollbars[idx].height, self.scrollbars[idx].up, self.scrollbars[idx].down, self.scrollbars[idx].track);
        }
    }
}
