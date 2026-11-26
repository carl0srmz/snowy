//! The display tree: movie clips with timelines, placed from converted libraries.
//!
//! This reproduces the Flash display-list semantics the original game relies on
//! (depths, instance names, frame labels, play/stop/goto, attachMovie, clip events,
//! clip depth masks) as plain Rust data structures; there is no script interpreter.
use crate::assets::*;
use snow_fmt::*;
use std::collections::{BTreeMap, HashMap, HashSet};
use std::sync::Arc;

pub type ClipId = u32;
pub const NONE: ClipId = u32::MAX;
/// Character id meaning "the library's root timeline".
pub const ROOT_CID: CharId = u16::MAX;

#[derive(Clone, Debug, PartialEq)]
pub enum Value {
    Undef,
    Null,
    Bool(bool),
    Num(f64),
    Str(String),
    Clip(ClipId),
}

impl Value {
    pub fn num(&self) -> f64 {
        match self {
            Value::Num(n) => *n,
            Value::Bool(b) => *b as i32 as f64,
            Value::Str(s) => s.trim().parse().unwrap_or(f64::NAN),
            _ => f64::NAN,
        }
    }
    pub fn truthy(&self) -> bool {
        match self {
            Value::Undef | Value::Null => false,
            Value::Bool(b) => *b,
            Value::Num(n) => *n != 0.0 && !n.is_nan(),
            Value::Str(s) => !s.is_empty(),
            Value::Clip(_) => true,
        }
    }
    pub fn is_undef(&self) -> bool {
        matches!(self, Value::Undef)
    }
}

impl From<&Val> for Value {
    fn from(v: &Val) -> Value {
        match v {
            Val::Undefined => Value::Undef,
            Val::Null => Value::Null,
            Val::Bool(b) => Value::Bool(*b),
            Val::Num(n) => Value::Num(*n),
            Val::Str(s) => Value::Str(s.clone()),
            Val::Path(p) => Value::Str(format!("<path {}>", p)),
        }
    }
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum BtnState {
    Up,
    Over,
    Down,
}

pub enum Kind {
    Sprite,
    Shape,
    Morph,
    Text(Box<crate::text::TextField>),
    Button { state: BtnState },
    Video,
    /// bitmap loaded at runtime (promo art, thumbnails)
    Image { tex: crate::gfx::TexId, w: u32, h: u32 },
}

pub struct Clip {
    pub lib: u32,
    pub cid: CharId,
    pub name: String,
    pub depth: i32,
    pub parent: ClipId,
    pub kind: Kind,
    pub m: Matrix,
    pub prev_m: Matrix,
    pub cx: CXform,
    /// colour transform at the start of the current logic tick (for interpolation)
    pub prev_cx: CXform,
    /// false until the first `latch` after creation: a clip born this tick has no previous
    /// state, so it is drawn where it is instead of sliding in from the origin
    pub latched: bool,
    pub visible: bool,
    pub blend: Blend,
    pub filters: Vec<Filter>,
    pub clip_depth: Option<u16>,
    pub ratio: u16,
    pub children: BTreeMap<i32, ClipId>,
    pub frame: u16,
    pub total: u16,
    pub playing: bool,
    /// depths placed by the timeline (the rest were attached by game code)
    pub tl_depths: HashSet<i32>,
    /// timeline frame of the parent that placed this instance (0 = created by script)
    pub place_frame: u16,
    pub vars: HashMap<String, Value>,
    pub events: Vec<ClipEvent>,
    pub born: u64,
    /// For button children: visible in (up, over, down, hit)
    pub btn_states: (bool, bool, bool, bool),
    pub pending_goto: Option<(u16, bool)>,
    /// true when `_lockroot`-style root of a loaded movie
    pub is_movie_root: bool,
    /// setMask-style clipping rectangle in the clip's own space
    pub mask: Option<Rect>,
    /// clips that react to the mouse like buttons (movie clips with onPress handlers)
    pub interactive: bool,
}

pub trait Host {
    /// A named native behaviour (see `Op::Behavior`) fired by a script on `clip`.
    fn behavior(&mut self, _w: &mut World, _clip: ClipId, _name: &str) {}
    /// A method call that is not a timeline builtin. `target` is the resolved receiver.
    fn call(&mut self, _w: &mut World, _clip: ClipId, _target: ClipId, _name: &str, _args: &[Value]) {}
    /// A call whose receiver path does not name a clip (script objects such as sounds).
    fn unresolved(&mut self, _w: &mut World, _clip: ClipId, _path: &str, _name: &str, _args: &[Value]) {}
}

pub struct NullHost;
impl Host for NullHost {}

pub struct SoundEvent {
    pub lib: u32,
    pub start: SoundStart,
}

pub struct World {
    pub libs: Vec<Arc<GpuLib>>,
    /// the system font for text fields without embedded outlines (assets/device)
    pub device_font: Option<snow_fmt::FontDef>,
    pub clips: Vec<Option<Clip>>,
    free: Vec<u32>,
    pub root: ClipId,
    pub globals: HashMap<String, Value>,
    pub tick: u64,
    instance_counter: u32,
    /// clips whose frame is being entered right now (their own gotos are applied by that loop)
    entering: Vec<ClipId>,
    /// gotos on clips that are not entering a frame: applied right after the op that issued them
    queued_gotos: Vec<(ClipId, u16, bool)>,
    /// frame whose commands `apply_cmds` is placing (stamped on new instances)
    placing_frame: u16,
    pub sound_events: Vec<SoundEvent>,
    pub pending_removals: Vec<ClipId>,
    /// clips whose script cleared `onEnterFrame` (cancels pending delayed actions)
    pub cancelled_enter: Vec<ClipId>,
}

/// True when a transform changed in a way that is a cut rather than motion: a sprite turning
/// round (`_xscale = -100`), a large rotation, or a jump such as a respawn or a wrapping
/// background. Blending those would squash or smear the sprite for a tick.
fn is_jump(a: &Matrix, b: &Matrix) -> bool {
    let (da, db) = (a.a * a.d - a.b * a.c, b.a * b.d - b.b * b.c);
    if da * db < 0.0 {
        return true;
    }
    let (dx, dy) = (b.tx - a.tx, b.ty - a.ty);
    if dx * dx + dy * dy > JUMP_DIST * JUMP_DIST {
        return true;
    }
    // angle between the x axes
    let cross = a.a * b.b - a.b * b.a;
    let dot = a.a * b.a + a.b * b.b;
    (dot != 0.0 || cross != 0.0) && cross.atan2(dot).abs() > std::f32::consts::FRAC_PI_3
}

/// Movement per tick above which a position change is treated as a jump (stage pixels at 1x).
const JUMP_DIST: f32 = 150.0;

fn lerp_m(a: &Matrix, b: &Matrix, t: f32) -> Matrix {
    let f = |x: f32, y: f32| x + (y - x) * t;
    Matrix { a: f(a.a, b.a), b: f(a.b, b.b), c: f(a.c, b.c), d: f(a.d, b.d), tx: f(a.tx, b.tx), ty: f(a.ty, b.ty) }
}

impl World {
    pub fn new() -> World {
        let mut w = World {
            libs: Vec::new(),
            device_font: None,
            clips: Vec::new(),
            free: Vec::new(),
            root: NONE,
            globals: HashMap::new(),
            tick: 0,
            instance_counter: 0,
            entering: Vec::new(),
            queued_gotos: Vec::new(),
            placing_frame: 0,
            sound_events: Vec::new(),
            pending_removals: Vec::new(),
            cancelled_enter: Vec::new(),
        };
        w.root = w.alloc(Clip::empty(0, ROOT_CID, Kind::Sprite));
        w
    }

    pub fn add_lib(&mut self, l: GpuLib) -> u32 {
        let id = self.libs.len() as u32;
        let mut l = l;
        l.id = id;
        self.libs.push(Arc::new(l));
        id
    }

    pub fn add_lib_arc(&mut self, l: Arc<GpuLib>) -> u32 {
        self.libs.push(l);
        self.libs.len() as u32 - 1
    }

    pub fn lib_by_name(&self, name: &str) -> Option<u32> {
        self.libs.iter().position(|l| l.lib.name == name).map(|i| i as u32)
    }

    fn alloc(&mut self, mut c: Clip) -> ClipId {
        c.born = self.tick;
        if let Some(i) = self.free.pop() {
            self.clips[i as usize] = Some(c);
            i
        } else {
            self.clips.push(Some(c));
            self.clips.len() as u32 - 1
        }
    }

    pub fn clip(&self, id: ClipId) -> Option<&Clip> {
        self.clips.get(id as usize).and_then(|c| c.as_ref())
    }
    pub fn clip_mut(&mut self, id: ClipId) -> Option<&mut Clip> {
        self.clips.get_mut(id as usize).and_then(|c| c.as_mut())
    }
    pub fn alive(&self, id: ClipId) -> bool {
        id != NONE && self.clip(id).is_some()
    }

    fn timeline(&self, lib: u32, cid: CharId) -> Option<&Timeline> {
        let l = &self.libs[lib as usize];
        if cid == ROOT_CID {
            return Some(&l.lib.root);
        }
        match l.lib.chars.get(&cid) {
            Some(Char::Sprite(t)) => Some(t),
            _ => None,
        }
    }

    // ---- creation -------------------------------------------------------

    /// Creates an empty movie clip (createEmptyMovieClip).
    pub fn create_empty(&mut self, parent: ClipId, name: &str, depth: i32) -> ClipId {
        let lib = self.clip(parent).map(|c| c.lib).unwrap_or(0);
        let mut c = Clip::empty(lib, ROOT_CID - 1, Kind::Sprite);
        c.name = name.to_string();
        c.depth = depth;
        c.parent = parent;
        c.total = 1;
        c.playing = false;
        let id = self.alloc(c);
        self.link_child(parent, depth, id);
        id
    }

    fn link_child(&mut self, parent: ClipId, depth: i32, id: ClipId) {
        if parent == NONE {
            return;
        }
        let old = self.clip(parent).and_then(|p| p.children.get(&depth).copied());
        if let Some(o) = old {
            if o != id {
                self.remove(o);
            }
        }
        if let Some(p) = self.clip_mut(parent) {
            p.children.insert(depth, id);
        }
    }

    /// Replaces the content of `clip` by the root timeline of a library (loadMovie).
    pub fn load_into(&mut self, clip: ClipId, lib: u32) {
        self.clear_children(clip);
        let total = self.libs[lib as usize].lib.root.num_frames();
        if let Some(c) = self.clip_mut(clip) {
            c.lib = lib;
            c.cid = ROOT_CID;
            c.kind = Kind::Sprite;
            c.frame = 0;
            c.total = total;
            c.playing = true;
            c.tl_depths.clear();
            c.is_movie_root = true;
        }
    }

    /// Runs the first frame of a freshly loaded movie root (call after `load_into`).
    pub fn start_movie(&mut self, clip: ClipId, host: &mut dyn Host) {
        self.enter_frame_of(clip, 1, host);
    }

    fn make_char(&mut self, lib: u32, cid: CharId, parent: ClipId, depth: i32, host: &mut dyn Host) -> Option<ClipId> {
        let l = self.libs[lib as usize].clone();
        let ch = l.lib.chars.get(&cid)?;
        let mut c = Clip::empty(lib, cid, Kind::Sprite);
        c.parent = parent;
        c.depth = depth;
        match ch {
            Char::Sprite(t) => {
                c.total = t.num_frames();
                c.playing = c.total > 1;
            }
            Char::Shape(_) => c.kind = Kind::Shape,
            Char::Morph(_) => c.kind = Kind::Morph,
            Char::EditText(def) => {
                c.kind = Kind::Text(Box::new(crate::text::TextField::new(def.clone(), lib)));
            }
            Char::Button(_) => c.kind = Kind::Button { state: BtnState::Up },
            Char::Video { .. } => c.kind = Kind::Video,
        }
        let id = self.alloc(c);
        // buttons: instantiate their state records as children
        if let Char::Button(b) = ch {
            for r in &b.records {
                if let Some(cc) = self.make_char(lib, r.id, id, r.depth as i32, host) {
                    if let Some(k) = self.clip_mut(cc) {
                        k.m = r.matrix;
                        k.prev_m = r.matrix;
                        k.cx = r.cx;
                        k.btn_states = (r.up, r.over, r.down, r.hit);
                    }
                    // several records may share a depth; key them uniquely
                    let key = r.depth as i32 * 16 + self.clip(id).map(|c| c.children.len()).unwrap_or(0) as i32;
                    if let Some(k) = self.clip_mut(cc) {
                        k.depth = key;
                    }
                    if let Some(p) = self.clip_mut(id) {
                        p.children.insert(key, cc);
                    }
                    // state sprites get their first frame right away (a one-frame sprite would
                    // otherwise never be entered and stay empty)
                    self.on_create(cc, host);
                }
            }
        }
        Some(id)
    }

    /// attachMovie: instantiate an exported symbol of the parent's library.
    pub fn attach(&mut self, parent: ClipId, link: &str, name: &str, depth: i32, host: &mut dyn Host) -> Option<ClipId> {
        let lib = self.clip(parent)?.lib;
        let cid = self.libs[lib as usize].export(link)?;
        let id = self.make_char(lib, cid, parent, depth, host)?;
        if let Some(c) = self.clip_mut(id) {
            c.name = name.to_string();
        }
        self.link_child(parent, depth, id);
        self.on_create(id, host);
        Some(id)
    }

    /// Attach with an explicit library (used by the game when symbols come from another SWF).
    pub fn attach_from(&mut self, parent: ClipId, lib: u32, link: &str, name: &str, depth: i32, host: &mut dyn Host) -> Option<ClipId> {
        let cid = self.libs[lib as usize].export(link)?;
        let id = self.make_char(lib, cid, parent, depth, host)?;
        if let Some(c) = self.clip_mut(id) {
            c.name = name.to_string();
        }
        self.link_child(parent, depth, id);
        self.on_create(id, host);
        Some(id)
    }

    /// Places an arbitrary character by id under `parent`.
    pub fn place_char(&mut self, parent: ClipId, lib: u32, cid: CharId, name: &str, depth: i32, host: &mut dyn Host) -> Option<ClipId> {
        let id = self.make_char(lib, cid, parent, depth, host)?;
        if let Some(c) = self.clip_mut(id) {
            c.name = name.to_string();
        }
        self.link_child(parent, depth, id);
        self.on_create(id, host);
        Some(id)
    }

    /// First frame, `load` clip events, frame-1 scripts.
    fn on_create(&mut self, id: ClipId, host: &mut dyn Host) {
        let is_sprite = matches!(self.clip(id).map(|c| &c.kind), Some(Kind::Sprite));
        if !is_sprite {
            return;
        }
        let (lib, cid) = {
            let c = self.clip(id).unwrap();
            (c.lib, c.cid)
        };
        if self.timeline(lib, cid).is_none() {
            return;
        }
        self.enter_frame_of(id, 1, host);
    }

    pub fn remove(&mut self, id: ClipId) {
        if !self.alive(id) {
            return;
        }
        let (parent, depth, children) = {
            let c = self.clip(id).unwrap();
            (c.parent, c.depth, c.children.values().copied().collect::<Vec<_>>())
        };
        for ch in children {
            self.remove(ch);
        }
        if let Some(p) = self.clip_mut(parent) {
            if p.children.get(&depth) == Some(&id) {
                p.children.remove(&depth);
                p.tl_depths.remove(&depth);
            }
        }
        self.clips[id as usize] = None;
        self.free.push(id);
    }

    pub fn clear_children(&mut self, id: ClipId) {
        let kids: Vec<ClipId> = self.clip(id).map(|c| c.children.values().copied().collect()).unwrap_or_default();
        for k in kids {
            self.remove(k);
        }
        if let Some(c) = self.clip_mut(id) {
            c.children.clear();
            c.tl_depths.clear();
        }
    }

    // ---- paths ------------------------------------------------------------

    pub fn child_named(&self, id: ClipId, name: &str) -> Option<ClipId> {
        let c = self.clip(id)?;
        c.children.values().copied().find(|k| self.clip(*k).map(|k| k.name == name).unwrap_or(false))
    }

    pub fn movie_root(&self, mut id: ClipId) -> ClipId {
        loop {
            match self.clip(id) {
                Some(c) if c.is_movie_root || c.parent == NONE => return id,
                Some(c) => id = c.parent,
                None => return NONE,
            }
        }
    }

    pub fn resolve(&self, from: ClipId, path: &str) -> Option<ClipId> {
        if path.is_empty() || path == "this" {
            return Some(from);
        }
        let mut cur = from;
        for seg in path.split('.') {
            cur = match seg {
                "this" => cur,
                "_parent" => self.clip(cur)?.parent,
                "_root" => self.movie_root(cur),
                n => self.child_named(cur, n)?,
            };
            if cur == NONE || !self.alive(cur) {
                return None;
            }
        }
        Some(cur)
    }

    // ---- scripts ----------------------------------------------------------

    pub fn set_var(&mut self, id: ClipId, name: &str, v: Value) {
        let Some(c) = self.clip_mut(id) else { return };
        match name {
            "_x" => c.m.tx = v.num() as f32,
            "_y" => c.m.ty = v.num() as f32,
            "_visible" => c.visible = v.truthy(),
            "_alpha" => c.cx.mul[3] = v.num() as f32 / 100.0,
            "_name" => {
                if let Value::Str(s) = v {
                    c.name = s;
                }
            }
            "_rotation" => {
                let (sx, sy) = (c.m.a.hypot(c.m.b), c.m.c.hypot(c.m.d));
                let r = (v.num() as f32).to_radians();
                c.m.a = r.cos() * sx;
                c.m.b = r.sin() * sx;
                c.m.c = -r.sin() * sy;
                c.m.d = r.cos() * sy;
            }
            "_xscale" => {
                let s = v.num() as f32 / 100.0;
                let cur = c.m.a.hypot(c.m.b).max(1e-6);
                c.m.a *= s / cur;
                c.m.b *= s / cur;
            }
            "_yscale" => {
                let s = v.num() as f32 / 100.0;
                let cur = c.m.c.hypot(c.m.d).max(1e-6);
                c.m.c *= s / cur;
                c.m.d *= s / cur;
            }
            "onEnterFrame" if matches!(v, Value::Null | Value::Undef) => {
                self.cancelled_enter.push(id);
            }
            _ => {
                c.vars.insert(name.to_string(), v);
            }
        }
    }

    pub fn get_var(&self, id: ClipId, name: &str) -> Value {
        let Some(c) = self.clip(id) else { return Value::Undef };
        match name {
            "_x" => Value::Num(c.m.tx as f64),
            "_y" => Value::Num(c.m.ty as f64),
            "_visible" => Value::Bool(c.visible),
            "_alpha" => Value::Num(c.cx.mul[3] as f64 * 100.0),
            "_name" => Value::Str(c.name.clone()),
            "_currentframe" => Value::Num(c.frame as f64),
            "_totalframes" => Value::Num(c.total as f64),
            "_rotation" => Value::Num(c.m.b.atan2(c.m.a).to_degrees() as f64),
            "_xscale" => Value::Num((c.m.a.hypot(c.m.b) * 100.0) as f64),
            "_yscale" => Value::Num((c.m.c.hypot(c.m.d) * 100.0) as f64),
            _ => c.vars.get(name).cloned().unwrap_or(Value::Undef),
        }
    }

    pub fn exec_ops(&mut self, id: ClipId, ops: &[Op], host: &mut dyn Host) {
        for op in ops {
            if !self.alive(id) {
                return;
            }
            match op {
                Op::Stop => {
                    if let Some(c) = self.clip_mut(id) {
                        c.playing = false;
                    }
                }
                Op::Play => {
                    if let Some(c) = self.clip_mut(id) {
                        c.playing = true;
                    }
                }
                Op::NextFrame => self.goto_frame(id, self.clip(id).map(|c| c.frame + 1).unwrap_or(1), false),
                Op::PrevFrame => self.goto_frame(id, self.clip(id).map(|c| c.frame.saturating_sub(1).max(1)).unwrap_or(1), false),
                Op::GotoFrame(f) => {
                    let playing = self.clip(id).map(|c| c.playing).unwrap_or(false);
                    self.goto_frame(id, *f, playing);
                }
                Op::GotoLabel(l) => {
                    let playing = self.clip(id).map(|c| c.playing).unwrap_or(false);
                    self.goto_label(id, l, playing);
                }
                Op::Set { target, name, val } => {
                    if let Some(t) = self.resolve(id, target) {
                        let v = match val {
                            Val::Path(p) => self.eval_path(id, p),
                            v => Value::from(v),
                        };
                        self.set_var(t, name, v);
                    }
                }
                Op::Call { target, name, args } => {
                    let vals: Vec<Value> = args
                        .iter()
                        .map(|a| match a {
                            Val::Path(p) => self.eval_path(id, p),
                            v => Value::from(v),
                        })
                        .collect();
                    self.call(id, target, name, &vals, host);
                }
                Op::Behavior(name) => self.behavior(id, name, host),
                Op::Unknown(_) => {}
            }
            if !self.queued_gotos.is_empty() {
                self.flush_gotos(host);
            }
        }
    }

    /// Evaluates a dotted path to a clip reference or a variable value.
    pub fn eval_path(&self, from: ClipId, path: &str) -> Value {
        if let Some(c) = self.resolve(from, path) {
            return Value::Clip(c);
        }
        if let Some((head, last)) = path.rsplit_once('.') {
            if let Some(c) = self.resolve(from, head) {
                return self.get_var(c, last);
            }
            if head == "_root" {
                return self.globals.get(last).cloned().unwrap_or(Value::Undef);
            }
        }
        self.get_var(from, path)
    }

    fn call(&mut self, from: ClipId, target: &str, name: &str, args: &[Value], host: &mut dyn Host) {
        let Some(t) = self.resolve(from, target) else {
            host.unresolved(self, from, target, name, args);
            return;
        };
        match name {
            "stop" => {
                if let Some(c) = self.clip_mut(t) {
                    c.playing = false;
                }
            }
            "play" => {
                if let Some(c) = self.clip_mut(t) {
                    c.playing = true;
                }
            }
            "nextFrame" => self.goto_frame(t, self.clip(t).map(|c| c.frame + 1).unwrap_or(1), false),
            "prevFrame" => self.goto_frame(t, self.clip(t).map(|c| c.frame.saturating_sub(1).max(1)).unwrap_or(1), false),
            "gotoAndPlay" | "gotoAndStop" => {
                let play = name == "gotoAndPlay";
                match args.first() {
                    Some(Value::Str(l)) => self.goto_label(t, l, play),
                    Some(v) => self.goto_frame(t, v.num() as u16, play),
                    None => {}
                }
            }
            "removeMovieClip" => self.pending_removals.push(t),
            _ => host.call(self, from, t, name, args),
        }
    }

    fn behavior(&mut self, id: ClipId, name: &str, host: &mut dyn Host) {
        if let Some(n) = name.strip_prefix("autoname:") {
            if let Some(c) = self.clip_mut(id) {
                if c.name.contains("instance") {
                    c.name = n.to_string();
                }
            }
        } else if let Some(n) = name.strip_prefix("default_offset:") {
            if self.get_var(id, "offset").is_undef() {
                self.set_var(id, "offset", Value::Num(n.parse().unwrap_or(0.0)));
            }
        } else if let Some(s) = name.strip_prefix("die:") {
            self.set_var(id, "die_ops", Value::Str(s.to_string()));
        } else if let Some(s) = name.strip_prefix("event:") {
            self.set_var(id, "event_ops", Value::Str(s.to_string()));
        } else if let Some(which) = name.strip_prefix("sync:") {
            // animations that stay in phase across tiles via a global frame counter
            let (key, plus) = match which.strip_suffix("+1") {
                Some(k) => (k, 1),
                None => (which, 0),
            };
            let counter = self.globals.get(&format!("{}frame", key)).map(|v| v.num()).unwrap_or(1.0) as u16;
            let init = self.get_var(id, "init");
            let skip = if key == "bee" || key == "cloud" { counter == 2 } else { counter == 1 };
            if !skip && init.is_undef() {
                self.set_var(id, "init", Value::Bool(true));
                self.goto_frame(id, counter + plus, true);
            }
        } else {
            host.behavior(self, id, name);
        }
    }

    // ---- external control (game code) ------------------------------------

    /// gotoAndPlay/gotoAndStop from game code: applies the frame immediately.
    pub fn jump(&mut self, id: ClipId, frame: u16, play: bool, host: &mut dyn Host) {
        if !self.alive(id) {
            return;
        }
        let total = self.clip(id).map(|c| c.total).unwrap_or(1);
        let target = frame.clamp(1, total.max(1));
        if let Some(c) = self.clip_mut(id) {
            c.playing = play;
            // jumping to the frame we are already on does not re-run its scripts
            if c.frame == target {
                return;
            }
        }
        self.enter_frame_of(id, target, host);
    }

    pub fn jump_label(&mut self, id: ClipId, label: &str, play: bool, host: &mut dyn Host) {
        let f = self.clip(id).and_then(|c| self.timeline(c.lib, c.cid)).and_then(|t| t.label_frame(label));
        if let Some(f) = f {
            self.jump(id, f, play, host);
        }
    }

    pub fn set_playing(&mut self, id: ClipId, playing: bool) {
        if let Some(c) = self.clip_mut(id) {
            c.playing = playing;
        }
    }

    /// `_xscale = -_xscale`
    pub fn flip_x(&mut self, id: ClipId) {
        if let Some(c) = self.clip_mut(id) {
            c.m.a = -c.m.a;
            c.m.b = -c.m.b;
        }
    }

    pub fn set_text(&mut self, id: ClipId, text: &str) {
        if let Some(c) = self.clip_mut(id) {
            if let Kind::Text(t) = &mut c.kind {
                t.set_text(text);
            }
        }
    }

    pub fn set_html(&mut self, id: ClipId, html: &str) {
        if let Some(c) = self.clip_mut(id) {
            if let Kind::Text(t) = &mut c.kind {
                t.set_html(html);
            }
        }
    }

    pub fn stop_subtree(&mut self, id: ClipId, except: ClipId) {
        if id == except || !self.alive(id) {
            return;
        }
        self.set_playing(id, false);
        let kids: Vec<ClipId> = self.clip(id).map(|c| c.children.values().copied().collect()).unwrap_or_default();
        for k in kids {
            self.stop_subtree(k, except);
        }
    }

    // ---- timeline ---------------------------------------------------------

    pub fn goto_label(&mut self, id: ClipId, label: &str, play: bool) {
        let Some(c) = self.clip(id) else { return };
        let Some(tl) = self.timeline(c.lib, c.cid) else { return };
        if let Some(f) = tl.label_frame(label) {
            self.goto_frame(id, f, play);
        }
    }

    /// `gotoAndPlay/gotoAndStop`. On a clip that is entering a frame (its own frame script) the
    /// jump is applied by that frame loop once the script finishes; on any other clip the playhead
    /// moves right after the current action, as in Flash (a stopped clip jumps too).
    pub fn goto_frame(&mut self, id: ClipId, frame: u16, play: bool) {
        let entering = self.entering.contains(&id);
        if let Some(c) = self.clip_mut(id) {
            let f = frame.clamp(1, c.total.max(1));
            if entering {
                c.pending_goto = Some((f, play));
            } else {
                self.queued_gotos.push((id, f, play));
            }
        }
    }

    /// Applies gotos queued by `goto_frame` (see there).
    pub fn flush_gotos(&mut self, host: &mut dyn Host) {
        let mut guard = 0;
        while !self.queued_gotos.is_empty() && guard < 256 {
            guard += 1;
            let list = std::mem::take(&mut self.queued_gotos);
            for (id, f, play) in list {
                self.jump(id, f, play, host);
            }
        }
    }

    /// Going backwards (or looping): Flash/Ruffle goto semantics. Children placed after `frame`
    /// are removed; for every depth the commands of frames 1..=frame are merged into one final
    /// placement; an existing instance of the same character is kept (only its properties change,
    /// so nested animations keep running), anything else is created anew.
    fn rebuild_to(&mut self, id: ClipId, frame: u16, host: &mut dyn Host) {
        let (lib, cid) = {
            let c = self.clip(id).unwrap();
            (c.lib, c.cid)
        };
        let l = self.libs[lib as usize].clone();
        let tl = if cid == ROOT_CID {
            &l.lib.root
        } else {
            match l.lib.chars.get(&cid) {
                Some(Char::Sprite(t)) => t,
                _ => return,
            }
        };
        // final state per depth: (placing frame, merged place)
        let mut fin: std::collections::BTreeMap<i32, (u16, Place)> = std::collections::BTreeMap::new();
        for f in 1..=frame {
            let Some(fr) = tl.frames.get(f as usize - 1) else { break };
            for cmd in &fr.cmds {
                match cmd {
                    Cmd::Remove(d) => {
                        fin.remove(&(*d as i32));
                    }
                    Cmd::Place(p) => {
                        let d = p.depth as i32;
                        match (p.id, fin.get_mut(&d)) {
                            (Some(_), Some(e)) if p.is_move => {
                                // character replaced in place: keeps the old transform unless given
                                let mut np = p.clone();
                                if np.matrix.is_none() {
                                    np.matrix = e.1.matrix;
                                }
                                if np.cx.is_none() {
                                    np.cx = e.1.cx;
                                }
                                if np.name.is_none() {
                                    np.name = e.1.name.clone();
                                }
                                np.is_move = false;
                                *e = (f, np);
                            }
                            (Some(_), _) => {
                                let mut np = p.clone();
                                np.is_move = false;
                                fin.insert(d, (f, np));
                            }
                            (None, Some(e)) => {
                                let q = &mut e.1;
                                if p.matrix.is_some() {
                                    q.matrix = p.matrix;
                                }
                                if p.cx.is_some() {
                                    q.cx = p.cx;
                                }
                                if p.ratio.is_some() {
                                    q.ratio = p.ratio;
                                }
                                if p.name.is_some() {
                                    q.name = p.name.clone();
                                }
                                if p.clip_depth.is_some() {
                                    q.clip_depth = p.clip_depth;
                                }
                                if p.blend.is_some() {
                                    q.blend = p.blend;
                                }
                                if !p.filters.is_empty() {
                                    q.filters = p.filters.clone();
                                }
                                if p.visible.is_some() {
                                    q.visible = p.visible;
                                }
                                if !p.events.is_empty() {
                                    q.events = p.events.clone();
                                }
                            }
                            (None, None) => {}
                        }
                    }
                }
            }
        }
        // drop timeline children that do not survive into the target frame
        let depths: Vec<i32> = self.clip(id).unwrap().tl_depths.iter().copied().collect();
        for d in depths {
            let Some(ch) = self.clip(id).and_then(|c| c.children.get(&d).copied()) else {
                if let Some(c) = self.clip_mut(id) {
                    c.tl_depths.remove(&d);
                }
                continue;
            };
            let (ccid, pf) = self.clip(ch).map(|c| (c.cid, c.place_frame)).unwrap_or((0, 0));
            let keep = match fin.get(&d) {
                Some((_, p)) => pf <= frame && p.id == Some(ccid),
                None => false,
            };
            if !keep {
                self.remove(ch);
                if let Some(c) = self.clip_mut(id) {
                    c.tl_depths.remove(&d);
                }
            }
        }
        // apply the final state
        for (d, (f, p)) in fin {
            let existing = self.clip(id).and_then(|c| c.children.get(&d).copied()).filter(|ch| self.clip(id).map(|c| c.tl_depths.contains(&d)).unwrap_or(false) && self.alive(*ch));
            match existing {
                Some(ch) => {
                    let c = self.clip_mut(ch).unwrap();
                    c.m = p.matrix.unwrap_or(Matrix::IDENTITY);
                    c.prev_m = c.m;
                    if let Some(cx) = p.cx {
                        c.cx = cx;
                    } else {
                        c.cx = CXform::IDENTITY;
                    }
                    c.prev_cx = c.cx;
                    if let Some(r) = p.ratio {
                        c.ratio = r;
                    }
                    if let Some(n) = &p.name {
                        c.name = n.clone();
                    }
                    c.clip_depth = p.clip_depth;
                    if let Some(b) = p.blend {
                        c.blend = b;
                    }
                }
                None => {
                    self.placing_frame = f;
                    self.place(id, lib, &p, host);
                }
            }
        }
    }

    /// Makes `frame` current for `id`: places/removes children, runs frame ops.
    fn enter_frame_of(&mut self, id: ClipId, frame: u16, host: &mut dyn Host) {
        self.entering.push(id);
        self.enter_frame_inner(id, frame, host);
        self.entering.pop();
    }

    fn enter_frame_inner(&mut self, id: ClipId, frame: u16, host: &mut dyn Host) {
        let mut target = frame;
        let mut guard = 0;
        let mut first = true;
        loop {
            guard += 1;
            if guard > 64 || !self.alive(id) {
                return;
            }
            let (lib, cid, cur) = {
                let c = self.clip(id).unwrap();
                (c.lib, c.cid, c.frame)
            };
            if self.timeline(lib, cid).is_none() {
                return;
            }
            if target < cur || (cur == 0 && false) {
                self.rebuild_to(id, target, host);
            } else {
                for f in cur + 1..=target {
                    self.apply_cmds(id, lib, cid, f, host);
                }
            }
            if let Some(c) = self.clip_mut(id) {
                c.frame = target;
                c.pending_goto = None;
            }
            // timeline sounds
            let snds: Vec<SoundStart> = self
                .timeline(lib, cid)
                .and_then(|t| t.frames.get(target as usize - 1))
                .map(|f| f.sounds.clone())
                .unwrap_or_default();
            for s in snds {
                self.sound_events.push(SoundEvent { lib, start: s });
            }
            if first {
                first = false;
                // `load` events fire once, right after the clip exists with its first frame
                let events: Vec<ClipEvent> = self.clip(id).map(|c| c.events.clone()).unwrap_or_default();
                if cur == 0 {
                    // construct (component parameters) and initialize run before load
                    for flag in [clip_event::CONSTRUCT, clip_event::INITIALIZE, clip_event::LOAD] {
                        for e in events.iter().filter(|e| e.flags & flag != 0) {
                            self.exec_ops(id, &e.ops, host);
                        }
                    }
                }
            }
            let ops: Vec<Op> = self
                .timeline(lib, cid)
                .and_then(|t| t.frames.get(target as usize - 1))
                .map(|f| f.ops.clone())
                .unwrap_or_default();
            self.exec_ops(id, &ops, host);
            match self.clip(id).and_then(|c| c.pending_goto) {
                Some((f, play)) => {
                    if let Some(c) = self.clip_mut(id) {
                        c.playing = play;
                    }
                    target = f;
                }
                None => return,
            }
        }
    }

    fn apply_cmds(&mut self, id: ClipId, lib: u32, cid: CharId, frame: u16, host: &mut dyn Host) {
        let l = self.libs[lib as usize].clone();
        let tl = if cid == ROOT_CID {
            &l.lib.root
        } else {
            match l.lib.chars.get(&cid) {
                Some(Char::Sprite(t)) => t,
                _ => return,
            }
        };
        let Some(fr) = tl.frames.get(frame as usize - 1) else { return };
        self.placing_frame = frame;
        for cmd in &fr.cmds {
            match cmd {
                Cmd::Remove(d) => {
                    let d = *d as i32;
                    if let Some(ch) = self.clip(id).and_then(|c| c.children.get(&d).copied()) {
                        self.remove(ch);
                    }
                    if let Some(c) = self.clip_mut(id) {
                        c.tl_depths.remove(&d);
                    }
                }
                Cmd::Place(p) => self.place(id, lib, p, host),
            }
        }
    }

    fn place(&mut self, parent: ClipId, lib: u32, p: &Place, host: &mut dyn Host) {
        let depth = p.depth as i32;
        let existing = self.clip(parent).and_then(|c| c.children.get(&depth).copied());
        let mut inherit: Option<(Matrix, CXform, String)> = None;
        let target = if let Some(cid) = p.id {
            if let Some(e) = existing {
                if p.is_move {
                    if let Some(old) = self.clip(e) {
                        inherit = Some((old.m, old.cx, old.name.clone()));
                    }
                }
                self.remove(e);
            }
            let Some(id) = self.make_char(lib, cid, parent, depth, host) else { return };
            self.instance_counter += 1;
            let auto = format!("instance{}", self.instance_counter);
            let c = self.clip_mut(id).unwrap();
            c.name = p.name.clone().unwrap_or_else(|| inherit.as_ref().map(|i| i.2.clone()).filter(|n| !n.contains("instance")).unwrap_or(auto));
            if let Some((m, cx, _)) = &inherit {
                c.m = *m;
                c.cx = *cx;
            }
            let pf = self.placing_frame;
            if let Some(c) = self.clip_mut(id) {
                c.place_frame = pf;
            }
            if let Some(pm) = self.clip_mut(parent) {
                pm.children.insert(depth, id);
                pm.tl_depths.insert(depth);
            }
            Some((id, true))
        } else {
            existing.map(|e| (e, false))
        };
        let Some((id, is_new)) = target else { return };
        {
            let c = self.clip_mut(id).unwrap();
            if let Some(m) = &p.matrix {
                c.m = *m;
                if is_new {
                    c.prev_m = *m;
                }
            } else if is_new && inherit.is_none() {
                c.m = Matrix::IDENTITY;
                c.prev_m = Matrix::IDENTITY;
            }
            if let Some(cx) = &p.cx {
                c.cx = *cx;
            }
            if let Some(r) = p.ratio {
                c.ratio = r;
            }
            if let Some(n) = &p.name {
                c.name = n.clone();
            }
            if p.clip_depth.is_some() {
                c.clip_depth = p.clip_depth;
            }
            if let Some(b) = p.blend {
                c.blend = b;
            }
            if !p.filters.is_empty() {
                c.filters = p.filters.clone();
            }
            if let Some(v) = p.visible {
                c.visible = v;
            }
            if !p.events.is_empty() {
                c.events = p.events.clone();
            }
        }
        if is_new {
            self.on_create(id, host);
        }
    }

    /// Advances every timeline by one frame, parents before children.
    pub fn advance(&mut self, host: &mut dyn Host) {
        self.tick += 1;
        self.flush_gotos(host);
        let root = self.root;
        self.advance_clip(root, host);
        self.flush_gotos(host);
        let rem = std::mem::take(&mut self.pending_removals);
        for r in rem {
            self.remove(r);
        }
    }

    fn advance_clip(&mut self, id: ClipId, host: &mut dyn Host) {
        let Some(c) = self.clip(id) else { return };
        if c.born == self.tick {
            return;
        }
        let (is_sprite, playing, total, frame) = (matches!(c.kind, Kind::Sprite), c.playing, c.total, c.frame);
        if is_sprite {
            // enter-frame clip events
            let evs: Vec<ClipEvent> = c.events.iter().filter(|e| e.flags & clip_event::ENTER_FRAME != 0).cloned().collect();
            for e in evs {
                self.exec_ops(id, &e.ops, host);
            }
        }
        let has_tl = self.clip(id).map(|c| self.timeline(c.lib, c.cid).is_some()).unwrap_or(false);
        if is_sprite && has_tl && playing && total > 0 {
            let next = if frame >= total { 1 } else { frame + 1 };
            if total > 1 || frame == 0 {
                self.enter_frame_of(id, next, host);
            }
        }
        let kids: Vec<ClipId> = self.clip(id).map(|c| c.children.values().copied().collect()).unwrap_or_default();
        for k in kids {
            self.advance_clip(k, host);
        }
    }

    /// Latch the current transforms so rendering can interpolate towards the next tick.
    pub fn latch(&mut self) {
        for c in self.clips.iter_mut().flatten() {
            c.prev_m = c.m;
            c.prev_cx = c.cx;
            c.latched = true;
        }
    }

    // ---- geometry ---------------------------------------------------------

    /// The clip's matrix `alpha` of the way from the previous logic tick to the current one.
    pub fn local_matrix(&self, id: ClipId, alpha: f32) -> Matrix {
        let c = self.clip(id).unwrap();
        if alpha >= 1.0 || !c.latched || c.prev_m == c.m || is_jump(&c.prev_m, &c.m) {
            c.m
        } else {
            lerp_m(&c.prev_m, &c.m, alpha)
        }
    }

    /// The clip's colour transform, interpolated like `local_matrix`.
    pub fn local_cx(&self, id: ClipId, alpha: f32) -> CXform {
        let c = self.clip(id).unwrap();
        if alpha >= 1.0 || !c.latched || c.prev_cx == c.cx {
            return c.cx;
        }
        let (a, b) = (&c.prev_cx, &c.cx);
        let mut r = *b;
        for i in 0..4 {
            // a blink or a hit flash changes a lot in one tick: keep it a step
            if (b.mul[i] - a.mul[i]).abs() > 0.5 || (b.add[i] - a.add[i]).abs() > 0.5 {
                return c.cx;
            }
            r.mul[i] = a.mul[i] + (b.mul[i] - a.mul[i]) * alpha;
            r.add[i] = a.add[i] + (b.add[i] - a.add[i]) * alpha;
        }
        r
    }

    /// Matrix from `id`'s space to stage space (no interpolation).
    pub fn world_matrix(&self, id: ClipId) -> Matrix {
        let mut chain = Vec::new();
        let mut cur = id;
        while cur != NONE {
            match self.clip(cur) {
                Some(c) => {
                    chain.push(c.m);
                    cur = c.parent;
                }
                None => break,
            }
        }
        let mut m = Matrix::IDENTITY;
        for x in chain.iter().rev() {
            m = m.mul(x);
        }
        m
    }

    /// Bounds of the clip's visible geometry in the coordinate space of `space`.
    pub fn bounds_in(&self, id: ClipId, space: ClipId) -> Option<Rect> {
        let to = self.world_matrix(space).inverse();
        let m = to.mul(&self.world_matrix(id));
        self.bounds_rec(id, &m)
    }

    fn bounds_rec(&self, id: ClipId, m: &Matrix) -> Option<Rect> {
        let c = self.clip(id)?;
        let mut out: Option<Rect> = None;
        let mut add = |r: Rect, mm: &Matrix| {
            let pts = [mm.apply(r.x0, r.y0), mm.apply(r.x1, r.y0), mm.apply(r.x0, r.y1), mm.apply(r.x1, r.y1)];
            let b = Rect {
                x0: pts.iter().map(|p| p.0).fold(f32::MAX, f32::min),
                y0: pts.iter().map(|p| p.1).fold(f32::MAX, f32::min),
                x1: pts.iter().map(|p| p.0).fold(f32::MIN, f32::max),
                y1: pts.iter().map(|p| p.1).fold(f32::MIN, f32::max),
            };
            out = Some(match out {
                None => b,
                Some(o) => Rect { x0: o.x0.min(b.x0), y0: o.y0.min(b.y0), x1: o.x1.max(b.x1), y1: o.y1.max(b.y1) },
            });
        };
        match &c.kind {
            Kind::Shape => {
                let l = &self.libs[c.lib as usize];
                if let Some(s) = l.shapes.get(&c.cid) {
                    if !s.meshes.is_empty() {
                        add(s.bounds, m);
                    }
                }
            }
            Kind::Text(t) => add(t.def.bounds, m),
            Kind::Image { w, h, .. } => add(Rect { x0: 0.0, y0: 0.0, x1: *w as f32, y1: *h as f32 }, m),
            _ => {}
        }
        for ch in c.children.values() {
            if let Some(cc) = self.clip(*ch) {
                if cc.clip_depth.is_some() {
                    continue;
                }
                let child_m = m.mul(&cc.m);
                if let Some(r) = self.bounds_rec(*ch, &child_m) {
                    add(r, &Matrix::IDENTITY);
                }
            }
        }
        out
    }
}

impl Clip {
    pub fn empty(lib: u32, cid: CharId, kind: Kind) -> Clip {
        Clip {
            lib,
            cid,
            name: String::new(),
            depth: 0,
            parent: NONE,
            kind,
            m: Matrix::IDENTITY,
            prev_m: Matrix::IDENTITY,
            cx: CXform::IDENTITY,
            prev_cx: CXform::IDENTITY,
            latched: false,
            visible: true,
            blend: Blend::Normal,
            filters: Vec::new(),
            clip_depth: None,
            ratio: 0,
            children: BTreeMap::new(),
            frame: 0,
            total: 1,
            playing: true,
            tl_depths: HashSet::new(),
            place_frame: 0,
            vars: HashMap::new(),
            events: Vec::new(),
            born: 0,
            btn_states: (true, false, false, false),
            pending_goto: None,
            is_movie_root: false,
            mask: None,
            interactive: false,
        }
    }
}

// ---- hit testing and button actions ---------------------------------------------

fn point_in_tri(p: (f32, f32), t: &[[f32; 2]; 3]) -> bool {
    let s = |a: [f32; 2], b: [f32; 2]| (p.0 - b[0]) * (a[1] - b[1]) - (a[0] - b[0]) * (p.1 - b[1]);
    let (d1, d2, d3) = (s(t[0], t[1]), s(t[1], t[2]), s(t[2], t[0]));
    let neg = d1 < 0.0 || d2 < 0.0 || d3 < 0.0;
    let pos = d1 > 0.0 || d2 > 0.0 || d3 > 0.0;
    !(neg && pos)
}

impl World {
    /// Does `p` (stage space) touch any shape in the subtree? `m` is the clip's world matrix.
    fn hit_subtree(&self, id: ClipId, m: &Matrix, p: (f32, f32), hit_states: bool) -> bool {
        let Some(c) = self.clip(id) else { return false };
        if !c.visible {
            return false;
        }
        match &c.kind {
            Kind::Shape => {
                let l = &self.libs[c.lib as usize];
                if let Some(s) = l.shapes.get(&c.cid) {
                    let inv = m.inverse();
                    let q = inv.apply(p.0, p.1);
                    if q.0 < s.bounds.x0 - 1.0 || q.0 > s.bounds.x1 + 1.0 || q.1 < s.bounds.y0 - 1.0 || q.1 > s.bounds.y1 + 1.0 {
                        return false;
                    }
                    return s.tris.iter().any(|t| point_in_tri(q, t));
                }
                false
            }
            Kind::Text(t) => {
                let inv = m.inverse();
                let q = inv.apply(p.0, p.1);
                let b = t.def.bounds;
                q.0 >= b.x0 && q.0 <= b.x1 && q.1 >= b.y0 && q.1 <= b.y1
            }
            Kind::Button { .. } => false,
            _ => {
                for ch in c.children.values() {
                    let Some(cc) = self.clip(*ch) else { continue };
                    if cc.clip_depth.is_some() {
                        continue;
                    }
                    if hit_states && !cc.btn_states.3 {
                        continue;
                    }
                    if self.hit_subtree(*ch, &m.mul(&cc.m), p, false) {
                        return true;
                    }
                }
                false
            }
        }
    }

    /// Topmost button (or interactive clip) under the point, in stage coordinates.
    pub fn pick(&self, root: ClipId, p: (f32, f32)) -> Option<ClipId> {
        let mut best = None;
        self.pick_rec(root, &Matrix::IDENTITY, p, &mut best);
        best
    }

    fn pick_rec(&self, id: ClipId, parent_m: &Matrix, p: (f32, f32), best: &mut Option<ClipId>) {
        let Some(c) = self.clip(id) else { return };
        if !c.visible {
            return;
        }
        let m = parent_m.mul(&c.m);
        match &c.kind {
            Kind::Button { .. } => {
                // only the Hit state defines the clickable area
                for ch in c.children.values() {
                    let Some(cc) = self.clip(*ch) else { continue };
                    if cc.btn_states.3 && self.hit_subtree(*ch, &m.mul(&cc.m), p, false) {
                        *best = Some(id);
                        return;
                    }
                }
            }
            Kind::Sprite => {
                if c.interactive && self.hit_subtree(id, &m, p, false) {
                    *best = Some(id);
                }
                for ch in c.children.values() {
                    self.pick_rec(*ch, &m, p, best);
                }
            }
            _ => {}
        }
    }

    pub fn set_button_state(&mut self, id: ClipId, s: BtnState) {
        if let Some(c) = self.clip_mut(id) {
            if let Kind::Button { state } = &mut c.kind {
                *state = s;
            }
        }
    }

    /// Runs the SWF button actions matching `cond` in the scope of the button's parent clip.
    pub fn button_actions(&mut self, id: ClipId, cond: u16, host: &mut dyn Host) {
        let Some(c) = self.clip(id) else { return };
        let (lib, cid, parent) = (c.lib, c.cid, c.parent);
        let l = self.libs[lib as usize].clone();
        if let Some(Char::Button(b)) = l.lib.chars.get(&cid) {
            for a in &b.actions {
                if a.cond & cond != 0 {
                    self.exec_ops(parent, &a.ops, host);
                }
            }
        }
    }

    pub fn set_mask(&mut self, id: ClipId, r: Option<Rect>) {
        if let Some(c) = self.clip_mut(id) {
            c.mask = r;
        }
    }

    pub fn text_field(&self, id: ClipId) -> Option<&crate::text::TextField> {
        match &self.clip(id)?.kind {
            Kind::Text(t) => Some(t),
            _ => None,
        }
    }

    pub fn text_field_mut(&mut self, id: ClipId) -> Option<&mut crate::text::TextField> {
        match &mut self.clip_mut(id)?.kind {
            Kind::Text(t) => Some(t),
            _ => None,
        }
    }

    /// Looks up a clip by dotted path from `from` and returns it if alive.
    pub fn path(&self, from: ClipId, path: &str) -> ClipId {
        self.resolve(from, path).unwrap_or(NONE)
    }
}

impl World {
    /// Replaces the content of `id` by a runtime-loaded bitmap, returning the old texture if any.
    pub fn set_image(&mut self, id: ClipId, tex: crate::gfx::TexId, w: u32, h: u32) -> Option<crate::gfx::TexId> {
        self.clear_children(id);
        let c = self.clip_mut(id)?;
        let old = if let Kind::Image { tex, .. } = c.kind { Some(tex) } else { None };
        c.kind = Kind::Image { tex, w, h };
        old
    }

    pub fn clear_image(&mut self, id: ClipId) -> Option<crate::gfx::TexId> {
        let c = self.clip_mut(id)?;
        if let Kind::Image { tex, .. } = c.kind {
            c.kind = Kind::Sprite;
            return Some(tex);
        }
        None
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn at(x: f32, y: f32) -> Matrix {
        Matrix { a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: x, ty: y }
    }

    /// A clip with a previous and a current state, as after one logic tick.
    fn moved(w: &mut World, from: Matrix, to: Matrix, cx0: CXform, cx1: CXform) -> ClipId {
        let id = w.create_empty(w.root, "c", 1);
        let c = w.clip_mut(id).unwrap();
        c.m = from;
        c.cx = cx0;
        w.latch();
        let c = w.clip_mut(id).unwrap();
        c.m = to;
        c.cx = cx1;
        id
    }

    #[test]
    fn motion_is_blended() {
        let mut w = World::new();
        let id = moved(&mut w, at(10.0, 0.0), at(20.0, 4.0), CXform::IDENTITY, CXform::IDENTITY);
        let m = w.local_matrix(id, 0.25);
        assert!((m.tx - 12.5).abs() < 1e-4 && (m.ty - 1.0).abs() < 1e-4);
    }

    #[test]
    fn new_clips_are_not_blended_from_the_origin() {
        let mut w = World::new();
        let id = w.create_empty(w.root, "c", 1);
        w.clip_mut(id).unwrap().m = at(300.0, 200.0);
        assert_eq!(w.local_matrix(id, 0.5).tx, 300.0);
    }

    #[test]
    fn cuts_are_not_blended() {
        let mut w = World::new();
        // turning round
        let flip = Matrix { a: -1.0, ..at(5.0, 0.0) };
        let id = moved(&mut w, at(0.0, 0.0), flip, CXform::IDENTITY, CXform::IDENTITY);
        assert_eq!(w.local_matrix(id, 0.5).a, -1.0);
        // respawn / wrap-around
        let id = moved(&mut w, at(0.0, 0.0), at(480.0, 0.0), CXform::IDENTITY, CXform::IDENTITY);
        assert_eq!(w.local_matrix(id, 0.5).tx, 480.0);
        // half turn
        let rot = Matrix { a: -1.0, b: 0.0, c: 0.0, d: -1.0, tx: 0.0, ty: 0.0 };
        let id = moved(&mut w, at(0.0, 0.0), rot, CXform::IDENTITY, CXform::IDENTITY);
        assert_eq!(w.local_matrix(id, 0.5).a, -1.0);
    }

    #[test]
    fn fades_are_blended_but_flashes_are_not() {
        let mut w = World::new();
        let half = CXform { mul: [1.0, 1.0, 1.0, 0.6], add: [0.0; 4] };
        let id = moved(&mut w, at(0.0, 0.0), at(0.0, 0.0), CXform::IDENTITY, half);
        assert!((w.local_cx(id, 0.5).mul[3] - 0.8).abs() < 1e-4);
        let white = CXform { mul: [1.0; 4], add: [1.0, 1.0, 1.0, 0.0] };
        let id = moved(&mut w, at(0.0, 0.0), at(0.0, 0.0), CXform::IDENTITY, white);
        assert_eq!(w.local_cx(id, 0.5).add[0], 1.0);
    }
}
