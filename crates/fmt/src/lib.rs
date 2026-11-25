//! Native asset format shared by the converter (`swfx`) and the game.
//!
//! Everything the original Flash movies contained is converted ahead of time:
//! vector art is tessellated into GPU-ready triangle meshes, bitmaps become PNG
//! files, timelines become plain data, sounds become audio files. The game never
//! parses SWF files and has no scripting VM; behaviour is implemented in Rust.

use serde::{Deserialize, Serialize};
use std::collections::BTreeMap;

pub type CharId = u16;

#[derive(Clone, Copy, Debug, Default, Serialize, Deserialize, PartialEq)]
pub struct Rect {
    pub x0: f32,
    pub y0: f32,
    pub x1: f32,
    pub y1: f32,
}

impl Rect {
    pub fn width(&self) -> f32 {
        self.x1 - self.x0
    }
    pub fn height(&self) -> f32 {
        self.y1 - self.y0
    }
}

/// 2x3 affine matrix; translation in pixels.
#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq)]
pub struct Matrix {
    pub a: f32,
    pub b: f32,
    pub c: f32,
    pub d: f32,
    pub tx: f32,
    pub ty: f32,
}

impl Matrix {
    pub const IDENTITY: Matrix = Matrix { a: 1.0, b: 0.0, c: 0.0, d: 1.0, tx: 0.0, ty: 0.0 };
    pub fn translate(x: f32, y: f32) -> Matrix {
        Matrix { tx: x, ty: y, ..Matrix::IDENTITY }
    }
    pub fn scale(x: f32, y: f32) -> Matrix {
        Matrix { a: x, d: y, ..Matrix::IDENTITY }
    }
    /// self * other (apply `other` first, then `self`).
    pub fn mul(&self, o: &Matrix) -> Matrix {
        Matrix {
            a: self.a * o.a + self.c * o.b,
            b: self.b * o.a + self.d * o.b,
            c: self.a * o.c + self.c * o.d,
            d: self.b * o.c + self.d * o.d,
            tx: self.a * o.tx + self.c * o.ty + self.tx,
            ty: self.b * o.tx + self.d * o.ty + self.ty,
        }
    }
    pub fn apply(&self, x: f32, y: f32) -> (f32, f32) {
        (self.a * x + self.c * y + self.tx, self.b * x + self.d * y + self.ty)
    }
    pub fn det(&self) -> f32 {
        self.a * self.d - self.b * self.c
    }
    pub fn inverse(&self) -> Matrix {
        let det = self.det();
        if det.abs() < 1e-12 {
            return Matrix::IDENTITY;
        }
        let id = 1.0 / det;
        Matrix {
            a: self.d * id,
            b: -self.b * id,
            c: -self.c * id,
            d: self.a * id,
            tx: (self.c * self.ty - self.d * self.tx) * id,
            ty: (self.b * self.tx - self.a * self.ty) * id,
        }
    }
}

impl Default for Matrix {
    fn default() -> Self {
        Matrix::IDENTITY
    }
}

/// Colour transform: out = in * mul + add (all channels 0..1 range).
#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq)]
pub struct CXform {
    pub mul: [f32; 4],
    pub add: [f32; 4],
}

impl CXform {
    pub const IDENTITY: CXform = CXform { mul: [1.0; 4], add: [0.0; 4] };
    pub fn is_identity(&self) -> bool {
        *self == CXform::IDENTITY
    }
    /// self applied after `inner`.
    pub fn concat(&self, inner: &CXform) -> CXform {
        let mut r = CXform::IDENTITY;
        for i in 0..4 {
            r.mul[i] = self.mul[i] * inner.mul[i];
            r.add[i] = self.mul[i] * inner.add[i] + self.add[i];
        }
        r
    }
}

impl Default for CXform {
    fn default() -> Self {
        CXform::IDENTITY
    }
}

#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq)]
pub enum Spread {
    Pad,
    Reflect,
    Repeat,
}

#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq)]
pub enum GradKind {
    Linear,
    Radial,
    Focal(f32),
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct GradFill {
    pub kind: GradKind,
    /// Maps gradient space (-16384..16384 twips box, expressed in pixels) to shape space.
    pub matrix: Matrix,
    pub spread: Spread,
    pub linear_rgb: bool,
    pub stops: Vec<(f32, [f32; 4])>,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct BitmapFill {
    pub id: CharId,
    /// Maps bitmap pixel space to shape space.
    pub matrix: Matrix,
    pub smooth: bool,
    pub repeat: bool,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub enum Fill {
    /// Straight (non-premultiplied) RGBA, 0..1.
    Solid([f32; 4]),
    Gradient(GradFill),
    Bitmap(BitmapFill),
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Mesh {
    pub fill: Fill,
    pub verts: Vec<[f32; 2]>,
    pub indices: Vec<u32>,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct ShapeDef {
    pub bounds: Rect,
    pub meshes: Vec<Mesh>,
}

/// Morph shapes are pre-tessellated at every ratio the movies actually use.
#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct MorphDef {
    pub frames: BTreeMap<u16, ShapeDef>,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct GlyphDef {
    pub code: u16,
    /// Advance in em units.
    pub advance: f32,
    /// Outline in em units (y down, baseline at 0), white fill.
    pub shape: ShapeDef,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct FontDef {
    pub name: String,
    pub ascent: f32,
    pub descent: f32,
    pub leading: f32,
    pub bold: bool,
    pub italic: bool,
    pub glyphs: Vec<GlyphDef>,
    pub kerning: Vec<(u16, u16, f32)>,
}

#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq)]
pub enum Align {
    Left,
    Right,
    Center,
    Justify,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct EditTextDef {
    pub bounds: Rect,
    pub font: Option<CharId>,
    pub size: f32,
    pub color: [f32; 4],
    pub align: Align,
    pub left_margin: f32,
    pub right_margin: f32,
    pub indent: f32,
    pub leading: f32,
    pub variable: String,
    pub initial_text: String,
    pub html: bool,
    pub multiline: bool,
    pub word_wrap: bool,
    pub selectable: bool,
    pub read_only: bool,
    pub password: bool,
    pub auto_size: bool,
    pub border: bool,
    pub max_length: u16,
    /// no embedded outlines: Flash draws it with a system font
    pub device: bool,
}

#[derive(Clone, Copy, Debug, Serialize, Deserialize, PartialEq)]
pub enum Blend {
    Normal,
    Layer,
    Multiply,
    Screen,
    Lighten,
    Darken,
    Difference,
    Add,
    Subtract,
    Invert,
    Alpha,
    Erase,
    Overlay,
    HardLight,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub enum Filter {
    Blur { x: f32, y: f32, passes: u8 },
    ColorMatrix([f32; 20]),
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct ButtonRecordDef {
    pub up: bool,
    pub over: bool,
    pub down: bool,
    pub hit: bool,
    pub id: CharId,
    pub depth: u16,
    pub matrix: Matrix,
    pub cx: CXform,
}

/// Button state-transition bits, identical to the SWF `ButtonCondition` layout.
pub mod btn_cond {
    pub const IDLE_TO_OVER_UP: u16 = 1 << 0; // roll over
    pub const OVER_UP_TO_IDLE: u16 = 1 << 1; // roll out
    pub const OVER_UP_TO_OVER_DOWN: u16 = 1 << 2; // press
    pub const OVER_DOWN_TO_OVER_UP: u16 = 1 << 3; // release
    pub const OVER_DOWN_TO_OUT_DOWN: u16 = 1 << 4; // drag out
    pub const OUT_DOWN_TO_OVER_DOWN: u16 = 1 << 5; // drag over
    pub const OUT_DOWN_TO_IDLE: u16 = 1 << 6; // release outside
    pub const IDLE_TO_OVER_DOWN: u16 = 1 << 7;
    pub const OVER_DOWN_TO_IDLE: u16 = 1 << 8;
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct ButtonAct {
    pub cond: u16,
    pub ops: Vec<Op>,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct ButtonDef {
    pub records: Vec<ButtonRecordDef>,
    pub actions: Vec<ButtonAct>,
}

/// Lowered timeline scripts. Only constructs that occur in the original movies exist.
#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
pub enum Val {
    Undefined,
    Null,
    Bool(bool),
    Num(f64),
    Str(String),
    /// Dotted variable/clip path such as `_root.treebase` or `_parent.txt.bla_txt`.
    Path(String),
}

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
pub enum Op {
    Stop,
    Play,
    NextFrame,
    PrevFrame,
    GotoFrame(u16),
    GotoLabel(String),
    /// `target.name = value`
    Set { target: String, name: String, val: Val },
    /// `target.name(args)`; target is a dotted path relative to the clip ("" = this).
    Call { target: String, name: String, args: Vec<Val> },
    /// A behaviour implemented natively in the game, referenced by name.
    Behavior(String),
    /// Source of a script the converter could not lower (kept for diagnostics).
    Unknown(String),
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct ClipEvent {
    pub flags: u32,
    pub ops: Vec<Op>,
}

pub mod clip_event {
    pub const LOAD: u32 = 1 << 0;
    pub const ENTER_FRAME: u32 = 1 << 1;
    pub const UNLOAD: u32 = 1 << 2;
    pub const MOUSE_MOVE: u32 = 1 << 3;
    pub const MOUSE_DOWN: u32 = 1 << 4;
    pub const MOUSE_UP: u32 = 1 << 5;
    pub const KEY_DOWN: u32 = 1 << 6;
    pub const KEY_UP: u32 = 1 << 7;
    pub const DATA: u32 = 1 << 8;
    pub const INITIALIZE: u32 = 1 << 9;
    pub const PRESS: u32 = 1 << 10;
    pub const RELEASE: u32 = 1 << 11;
    /// onClipEvent(construct): component parameters, before the clip's first frame
    pub const CONSTRUCT: u32 = 1 << 12;
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Place {
    pub depth: u16,
    pub id: Option<CharId>,
    /// true when this modifies/replaces an existing object instead of adding one.
    pub is_move: bool,
    pub matrix: Option<Matrix>,
    pub cx: Option<CXform>,
    pub ratio: Option<u16>,
    pub name: Option<String>,
    pub clip_depth: Option<u16>,
    pub filters: Vec<Filter>,
    pub blend: Option<Blend>,
    pub visible: Option<bool>,
    pub events: Vec<ClipEvent>,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub enum Cmd {
    Place(Place),
    Remove(u16),
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct SoundStart {
    pub id: CharId,
    pub stop: bool,
    pub no_restart: bool,
    pub loops: u16,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct Frame {
    pub cmds: Vec<Cmd>,
    pub ops: Vec<Op>,
    pub sounds: Vec<SoundStart>,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct Timeline {
    pub frames: Vec<Frame>,
    /// (label, 1-based frame)
    pub labels: Vec<(String, u16)>,
}

impl Timeline {
    pub fn num_frames(&self) -> u16 {
        self.frames.len().max(1) as u16
    }
    pub fn label_frame(&self, name: &str) -> Option<u16> {
        self.labels.iter().find(|(l, _)| l.eq_ignore_ascii_case(name)).map(|(_, f)| *f)
    }
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub enum Char {
    Shape(ShapeDef),
    Morph(MorphDef),
    Sprite(Timeline),
    EditText(EditTextDef),
    Button(ButtonDef),
    Video { width: u16, height: u16 },
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct BitmapMeta {
    pub id: CharId,
    pub width: u32,
    pub height: u32,
    /// File name relative to the library's bitmap directory.
    pub file: String,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct SoundMeta {
    pub id: CharId,
    /// File name relative to the library's sound directory (wav or mp3).
    pub file: String,
    pub sample_rate: u32,
    pub channels: u8,
    pub samples: u32,
}

#[derive(Clone, Debug, Default, Serialize, Deserialize)]
pub struct Library {
    pub name: String,
    pub swf_version: u8,
    pub frame_rate: f32,
    pub stage: Rect,
    pub background: [u8; 3],
    pub bitmaps: Vec<BitmapMeta>,
    pub sounds: Vec<SoundMeta>,
    pub fonts: BTreeMap<CharId, FontDef>,
    pub chars: BTreeMap<CharId, Char>,
    /// Linkage name -> character id (movie clip symbols exported for AttachMovie).
    pub exports: BTreeMap<String, CharId>,
    pub root: Timeline,
}

impl Library {
    pub fn save(&self, path: &std::path::Path) -> std::io::Result<()> {
        let bytes = bincode::serialize(self).map_err(|e| std::io::Error::new(std::io::ErrorKind::Other, e))?;
        std::fs::write(path, bytes)
    }
    pub fn load(path: &std::path::Path) -> std::io::Result<Library> {
        let bytes = std::fs::read(path)?;
        bincode::deserialize(&bytes).map_err(|e| std::io::Error::new(std::io::ErrorKind::Other, e))
    }
}
