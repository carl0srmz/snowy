//! Gameplay: a Rust port of the original engine classes (Game, Scroll, HandleTiles, Tile,
//! Char, Hero, CollisionUtil, PlatformUtil and the enemy actors). Constants and rules were
//! recovered from the original bytecode; nothing here interprets scripts.
use crate::movie::*;
use anyhow::{anyhow, Result};
use snow_fmt::{Matrix, Rect};
use std::collections::HashMap;

pub const SCREEN_W: f32 = 480.0;
pub const SCREEN_H: f32 = 360.0;

// Char constants
const GRAVITY: f32 = 1.2;
const FRICTION: f32 = 0.9;
const FRICTION_SLIDE: f32 = 0.975;
const WALK_ACC: f32 = 0.6;
const WALK_MAX_ACC: f32 = 7.0;
const RUN_MAX_ACC: f32 = 10.0;
const CLIMB_SPEED: f32 = 2.0;
const MAX_VEL: f32 = 16.0;
const TOLERANCE: f32 = 0.1;
const JUMP_FORCE: f32 = 23.0;

// move states == frames of the actor's `container` clip
const M_STAND: i32 = 1;
const M_WALK: i32 = 2;
const M_JUMP: i32 = 3;
const M_FALL: i32 = 4;
const M_CROUCH: i32 = 5;
const M_FLIP: i32 = 6;
const M_RUN: i32 = 7;
const M_SLIDE: i32 = 8;
const M_CLIMB: i32 = 9;
const M_DIE: i32 = 10;
const M_HURT: i32 = 11;

// collision actions
const A_SNAPTOP: i32 = 1;
const A_SNAPBOTTOM: i32 = 2;
const A_SNAPRIGHT: i32 = 3;
const A_SNAPLEFT: i32 = 4;
const A_HITLADDER: i32 = 5;
const A_HITENEMY: i32 = 6;
const A_DEADLY: i32 = 7;
const A_PICKUP: i32 = 8;

const O_MASSIVE: i32 = 0;
const O_BEVEL: i32 = 3;
const O_DEADLY: i32 = 4;
const O_LADDER: i32 = 8;

#[derive(Clone, Debug, Default)]
pub struct TileDef {
    pub link: String,
    pub x: i32,
    pub y: i32,
    pub w: i32,
    pub h: i32,
    pub depth: i32,
    pub o: i32,
}

pub struct LevelData {
    pub background: String,
    pub music: String,
    pub effects: String,
    pub sx: f32,
    pub sy: f32,
    pub d: i32,
    pub sh: f32,
    pub layer_source: String,
    pub width: f32,
    pub height: f32,
    pub lx: f32,
    pub ly: f32,
    pub tiles: Vec<TileDef>,
}

impl LevelData {
    pub fn parse(xml: &str) -> Result<LevelData> {
        let doc = roxmltree::Document::parse(xml)?;
        let root = doc.root_element();
        let f = |n: &str, d: f32| root.attribute(n).and_then(|v| v.parse::<f32>().ok()).unwrap_or(d);
        let layer = root.children().find(|n| n.has_tag_name("layer") && n.attribute("name") == Some("base")).ok_or_else(|| anyhow!("no base layer"))?;
        let int = |n: roxmltree::Node, a: &str| n.attribute(a).and_then(|v| v.trim().parse::<f32>().ok()).map(|v| v as i32).unwrap_or(0);
        let mut tiles = Vec::new();
        for t in layer.children().filter(|n| n.has_tag_name("t")) {
            tiles.push(TileDef { link: t.attribute("id").unwrap_or("").to_string(), x: int(t, "x"), y: int(t, "y"), w: int(t, "w"), h: int(t, "h"), depth: int(t, "d"), o: int(t, "o") });
        }
        Ok(LevelData {
            background: root.attribute("background").unwrap_or("").to_string(),
            music: root.attribute("music").unwrap_or("").to_string(),
            effects: root.attribute("effects").unwrap_or("").to_string(),
            sx: f("sx", 200.0),
            sy: f("sy", 500.0),
            d: f("d", 1000.0) as i32,
            sh: f("sh", 190.0),
            layer_source: layer.attribute("source").unwrap_or("").to_string(),
            width: layer.attribute("width").and_then(|v| v.parse().ok()).unwrap_or(480.0),
            height: layer.attribute("height").and_then(|v| v.parse().ok()).unwrap_or(360.0),
            lx: layer.attribute("x").and_then(|v| v.parse().ok()).unwrap_or(0.0),
            ly: layer.attribute("y").and_then(|v| v.parse().ok()).unwrap_or(0.0),
            tiles,
        })
    }
}

/// One tile of the level (HandleTiles/Tile).
struct Tile {
    link: String,
    x: i32,
    y: i32,
    depth: i32,
    off: bool,
    detached: bool,
    enemy: bool,
    tx: i32,
    ty: i32,
    xp: i32,
    yp: i32,
    clip: ClipId,
}

pub struct Input {
    pub left: bool,
    pub right: bool,
    pub up: bool,
    pub down: bool,
}

#[derive(Clone, Copy, Debug, PartialEq)]
pub enum Outcome {
    Playing,
    Dead,
    Finished,
}

/// Sound requests; the application maps them to audio files.
#[derive(Clone, Debug)]
pub enum Sfx {
    Player(&'static str),
    Effect(&'static str),
    PlayerStop(&'static str),
    MusicStart,
    MusicStop,
}

/// Collision entry produced by CollisionUtil.resolveCollisions.
struct Hit {
    action: i32,
    obstacle: ClipId,
    a: Option<f32>,
    b: Option<f32>,
    flag: bool,
}

struct Char {
    actor: ClipId,
    x: f32,
    y: f32,
    lx: f32,
    ly: f32,
    ox: f32,
    oy: f32,
    vx: f32,
    vy: f32,
    dir: i32,
    newdir: i32,
    lockmove: i32,
    jumps: i32,
    jumpstage: i32,
    jumpcnt: i32,
    walks: i32,
    slides: i32,
    r_action_up: bool,
    on_ground: bool,
    hit_ladder: bool,
    upon_ladder: bool,
    hit_top: bool,
    on_ladder: bool,
    mv: i32,
    up: bool,
    down: bool,
    left: bool,
    right: bool,
    l_down: bool,
    energy: i32,
    enemy: bool,
    weight: f32,
    half_w: f32,
    xoff: f32,
    ytop: f32,
    ybottom: f32,
    box_scale: f32,
    pivot: f32,
    on_movable: Option<ClipId>,
    pause: i32,
    walkspeed: f32,
    depth: i32,
    tile: usize,
    alive: bool,
    name: String,
    kind: EK,
    angry: i32,
    next_pause: i32,
    vdir: i32,
    changedir: i32,
    next_change: i32,
    speed: f32,
    throwcount: i32,
    untouchable: i32,
    hide_cnt: i32,
    pipeline: Vec<&'static str>,
    target: (f32, f32),
}

impl Char {
    fn new(actor: ClipId, enemy: bool) -> Char {
        Char {
            actor, x: 0.0, y: 0.0, lx: 0.0, ly: 0.0, ox: 0.0, oy: 0.0, vx: 0.0, vy: 0.0, dir: 1, newdir: 1, lockmove: 0, jumps: 0,
            jumpstage: 0, jumpcnt: 0, walks: 0, slides: 0, r_action_up: true, on_ground: false, hit_ladder: false, upon_ladder: false,
            hit_top: false, on_ladder: false, mv: 0, up: false, down: false, left: false, right: false, l_down: false, energy: 1,
            enemy, weight: 1.0, half_w: 10.0, xoff: 0.0, ytop: -30.0, ybottom: 0.0, box_scale: 1.0, pivot: 10.0, on_movable: None,
            pause: 0, walkspeed: 0.0, depth: 0, tile: usize::MAX, alive: true, name: String::new(), kind: EK::Pinku, angry: 0, next_pause: 0, vdir: 1, changedir: 0, next_change: 0, speed: 0.0, throwcount: 100, untouchable: 0, hide_cnt: 2, pipeline: Vec::new(), target: (0.0, 0.0),
        }
    }

    /// Char.createBox: the collision rectangle relative to the character position.
    fn create_box(&mut self, w: &World, h: f32, hoffset: f32, voffset: f32, xoff: f32) {
        let parent = w.clip(self.actor).map(|c| c.parent).unwrap_or(NONE);
        let b = w.bounds_in(self.actor, parent).unwrap_or(Rect { x0: 0.0, y0: 0.0, x1: 30.0, y1: 40.0 });
        self.half_w = (b.width() / 2.0).floor() - 4.0;
        self.ybottom = h - voffset;
        self.ytop = (-b.height() + hoffset) - voffset;
        self.xoff = xoff;
        self.pivot = self.half_w.trunc();
    }

    fn box_rect(&self) -> Rect {
        let (a, b) = (self.ytop * self.box_scale, self.ybottom * self.box_scale);
        Rect { x0: self.x - self.half_w + self.xoff, x1: self.x + self.half_w + self.xoff, y0: self.y + a.min(b), y1: self.y + a.max(b) }
    }
}

#[derive(Clone, Copy, PartialEq, Eq)]
enum MoverKind {
    Cloud,
    Stamm,
    Tilting,
    Wackel,
}

/// PlatformUtil movers: floating / tilting platforms driven by the player's weight.
struct Mover {
    kind: MoverKind,
    obstacle: ClipId,
    platform: ClipId,
    level: f32,
    vy: f32,
    offset: f32,
    limit: f32,
    angle: f32,
    drift: f32,
    force: f32,
    max_angle: f32,
    max_move: f32,
    pivot: f32,
    pub slip: f32,
    pub glide: f32,
    dir: i32,
}

fn lerp_clamp(v: f32, lo: f32, hi: f32) -> f32 {
    v.max(lo).min(hi)
}

pub struct Level {
    pub data: LevelData,
    pub root: ClipId,
    pub base: ClipId,
    pub base_lib: u32,
    tiles: Vec<Tile>,
    cells: HashMap<(i32, i32), Vec<usize>>,
    vts: HashMap<usize, bool>,
    vt: Vec<usize>,
    oax: Option<i32>,
    oay: Option<i32>,
    cam_x: f32,
    cam_y: f32,
    scroll_x: f32,
    scroll_y: f32,
    hero: Char,
    sox: f32,
    soy: f32,
    lockinput: i32,
    untouchable: i32,
    pub crystals: i32,
    found_container: bool,
    energymax: i32,
    pub outcome: Outcome,
    enemies: Vec<Char>,
    enemy_of_clip: HashMap<ClipId, usize>,
    movers: HashMap<ClipId, Mover>,
    pending_mover: HashMap<ClipId, MoverKind>,
    off_links: Vec<String>,
    hud_crystals: ClipId,
    hud_energy: ClipId,
    curtain: ClipId,
    pub sfx: Vec<Sfx>,
    pub paused: bool,
    pub tick_count: u64,
    pub ticks_since_end: u32,
    finished_goal: bool,
    pub world_no: u32,
    pub completed_before: bool,
    pub containers: [bool; 4],
    pub bonus: bool,
    pub got_container: bool,
    rng: u32,
    hero_frozen: bool,
    pub curtain_done: bool,
    attack_pinku: Option<f32>,
    spawn_counter: i32,
    pub noclip_check: bool,
}

/// Collects what scripts ask for; the game (UI or level) acts on it after the world step.
#[derive(Default)]
pub struct LHost {
    pub inits: Vec<ClipId>,
    pub finish: bool,
    /// (calling clip, receiver, method, args)
    pub calls: Vec<(ClipId, ClipId, String, Vec<Value>)>,
    /// (clip, `script:<hash>` behaviour name)
    pub behaviors: Vec<(ClipId, String)>,
}

impl Host for LHost {
    fn call(&mut self, _w: &mut World, clip: ClipId, target: ClipId, name: &str, args: &[Value]) {
        match name {
            "init" => self.inits.push(target),
            "finish" => self.finish = true,
            _ => self.calls.push((clip, target, name.to_string(), args.to_vec())),
        }
    }
    fn behavior(&mut self, _w: &mut World, clip: ClipId, name: &str) {
        self.behaviors.push((clip, name.to_string()));
    }
    fn unresolved(&mut self, _w: &mut World, clip: ClipId, path: &str, name: &str, args: &[Value]) {
        self.calls.push((clip, NONE, format!("{}\u{1}{}", path, name), args.to_vec()));
    }
}

fn mover_kind(link: &str) -> Option<MoverKind> {
    Some(match link {
        "floe" | "floe_b" => MoverKind::Tilting,
        "wackel_s" | "wackel_b" | "tiltstone_b" | "tiltstone_s" => MoverKind::Wackel,
        "stamm_s" | "p_ds" | "p_ds_b" => MoverKind::Stamm,
        "p_c_l" | "p_c_l_b" => MoverKind::Cloud,
        _ => None?,
    })
}

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
enum EK {
    Pinku,
    Speedy,
    Tree,
    Plain,
    Mom,
    Joggy,
    Stack(i32),
    Web,
    Runner,
    SnowSpider,
    Eagle,
    ElPix,
    Iceball,
}

fn enemy_kind(link: &str) -> Option<EK> {
    Some(match link {
        "pinku" | "orange" | "purpu" => EK::Pinku,
        "speedy" | "speedywood" => EK::Speedy,
        "treeguy" => EK::Tree,
        "beycnake" | "scorpion" | "hellscorpion" => EK::Plain,
        "pinkumom" => EK::Mom,
        "joggybear" => EK::Joggy,
        "pinkustack2x" => EK::Stack(2),
        "pinkustack3x" => EK::Stack(3),
        "pinkustack4x" => EK::Stack(4),
        "spider_web" => EK::Web,
        "spider_run" => EK::Runner,
        "snowspider" => EK::SnowSpider,
        "eagle" => EK::Eagle,
        "elpix" => EK::ElPix,
        "iceball" => EK::Iceball,
        _ => return None,
    })
}

fn is_enemy_link(link: &str) -> Option<(f32, f32)> {
    // (walk speed, weight) of the actor classes
    Some(match link {
        "pinku" | "orange" | "purpu" => (1.2, 0.55),
        "speedy" => (2.0, 0.35),
        "speedywood" => (5.0, 0.35),
        "treeguy" => (2.0, 0.55),
        "beycnake" => (1.0, 0.55),
        "scorpion" | "hellscorpion" => (2.0, 0.55),
        "eagle" => (1.2, 0.55),
        "pinkumom" => (1.0, 0.7),
        "pinkustack2x" | "pinkustack3x" | "pinkustack4x" => (1.2, 0.55),
        "spider_web" => (0.8, 0.55),
        "spider_run" => (4.0, 0.55),
        "snowspider" => (2.0, 0.7),
        "elpix" => (1.2, 0.55),
        "joggybear" => (0.0, 0.7),
        "iceball" => (3.0, 0.7),
        _ => return None,
    })
}

impl Level {
    /// Builds the level inside `screen` (the instantiated gamebase movie).
    pub fn new(w: &mut World, screen: ClipId, base_lib: u32, bg_lib: Option<u32>, data: LevelData, host: &mut LHost, containers: [bool; 4], world_no: u32, completed_before: bool) -> Result<Level> {
        let platform = w.child_named(screen, "platform").ok_or_else(|| anyhow!("gamebase has no platform clip"))?;
        let base = w.create_empty(platform, "base", 10000);
        w.load_into(base, base_lib);
        w.start_movie(base, host);
        if let (Some(bg), Some(bgc)) = (bg_lib, w.child_named(screen, "background")) {
            w.load_into(bgc, bg);
            w.start_movie(bgc, host);
        }
        let curtain = w.child_named(screen, "vorhang").unwrap_or(NONE);
        let hud_crystals = w.child_named(screen, "crystals").unwrap_or(NONE);
        let hud_energy = w.child_named(screen, "energy").unwrap_or(NONE);
        let mut tiles = Vec::new();
        let mut cells: HashMap<(i32, i32), Vec<usize>> = HashMap::new();
        for (i, t) in data.tiles.iter().enumerate() {
            let off = t.o + 30;
            let (tx, ty) = (t.x - t.w - off, t.y - t.h - off);
            let (xp, yp) = (tx + t.w + off * 2, ty + t.h + off * 2);
            let enemy = is_enemy_link(&t.link).is_some() || t.link == "iceball";
            tiles.push(Tile { link: t.link.clone(), x: t.x, y: t.y, depth: t.depth, off: false, detached: false, enemy, tx, ty, xp, yp, clip: NONE });
            let (c0, c1) = ((tx as f32 / SCREEN_W) as i32, (xp as f32 / SCREEN_W) as i32);
            let (r0, r1) = ((ty as f32 / SCREEN_H) as i32, (yp as f32 / SCREEN_H) as i32);
            for cx in c0.max(0)..=c1.max(0) {
                for cy in r0.max(0)..=r1.max(0) {
                    cells.entry((cx, cy)).or_default().push(i);
                }
            }
        }
        let mut off_links = Vec::new();
        let world_idx = (world_no.max(1) - 1) as usize;
        if containers.get(world_idx).copied().unwrap_or(false) {
            off_links.push("ec".to_string());
        }
        if completed_before {
            off_links.push("g".to_string());
            off_links.push("g_l".to_string());
        }
        let energymax = 3 + containers.iter().filter(|c| **c).count() as i32;
        // the hero is the exported `actor` symbol of the world's library
        let actor = w.attach_from(base, base_lib, "actor", "hero", data.d, host).ok_or_else(|| anyhow!("level library has no hero symbol"))?;
        let mut hero = Char::new(actor, false);
        hero.energy = energymax;
        hero.name = "hero".into();
        hero.create_box(w, 1.0, 10.0, 4.0, 0.0);
        hero.x = data.sx;
        hero.y = data.sy;
        hero.lx = data.sx;
        hero.ly = data.sy;
        let mut lv = Level {
            base,
            root: screen,
            base_lib,
            tiles,
            cells,
            vts: HashMap::new(),
            vt: Vec::new(),
            oax: None,
            oay: None,
            cam_x: 100.0,
            cam_y: 400.0,
            scroll_x: 100.0,
            scroll_y: 400.0,
            hero,
            sox: 0.0,
            soy: 0.0,
            lockinput: 0,
            untouchable: 0,
            crystals: 0,
            found_container: false,
            energymax,
            outcome: Outcome::Playing,
            enemies: Vec::new(),
            enemy_of_clip: HashMap::new(),
            movers: HashMap::new(),
            pending_mover: HashMap::new(),
            off_links,
            hud_crystals,
            hud_energy,
            curtain,
            sfx: Vec::new(),
            paused: false,
            tick_count: 0,
            ticks_since_end: 0,
            finished_goal: false,
            world_no,
            completed_before,
            containers,
            bonus: false,
            got_container: false,
            rng: 0x1234_5678,
            hero_frozen: false,
            curtain_done: false,
            attack_pinku: None,
            spawn_counter: 0,
            noclip_check: std::env::var("NOCLIP_CHECK").is_ok(),
            data,
        };
        lv.apply_hero_pos(w);
        for i in 1..=6 {
            if let Some(h) = w.child_named(lv.hud_energy, &format!("energy_{}", i)) {
                if i < energymax {
                    w.jump(h, 1, false, host);
                } else {
                    w.jump_label(h, "empty", false, host);
                }
            }
        }
        if let Some(c) = w.clip_mut(lv.hud_energy) {
            c.visible = true;
        }
        w.jump(curtain, 2, true, host);
        lv.sfx.push(Sfx::MusicStart);
        for (k, v) in [("coinframe", 0.0), ("waterframe", 0.0), ("beeframe", 2.0), ("cloudframe", 2.0)] {
            w.globals.insert(k.into(), Value::Num(v));
        }
        Ok(lv)
    }

    fn rand(&mut self, n: u32) -> u32 {
        self.rng ^= self.rng << 13;
        self.rng ^= self.rng >> 17;
        self.rng ^= self.rng << 5;
        self.rng % n.max(1)
    }

    fn apply_hero_pos(&mut self, w: &mut World) {
        let (x, y) = (self.hero.lx, self.hero.ly);
        if let Some(c) = w.clip_mut(self.hero.actor) {
            c.m.tx = x;
            c.m.ty = y;
        }
    }

    // ------------------------------------------------------------------ tiles

    fn tiles_process(&mut self, w: &mut World, host: &mut LHost) {
        let (ix, iy) = (self.cam_x as i32, self.cam_y as i32);
        let (cx, cy) = ((ix as f32 / SCREEN_W) as i32, (iy as f32 / SCREEN_H) as i32);
        if Some(cx) == self.oax && Some(cy) == self.oay {
            // detach tiles that fell out of the visible set
            let attached: Vec<usize> = self.tiles.iter().enumerate().filter(|(_, t)| t.clip != NONE).map(|(i, _)| i).collect();
            for i in attached {
                let clip = self.tiles[i].clip;
                if !w.alive(clip) {
                    self.tiles[i].clip = NONE;
                    continue;
                }
                // motion tiles (enemies) follow their clip
                if self.tiles[i].enemy {
                    if let Some(&e) = self.enemy_of_clip.get(&clip) {
                        let _ = e;
                    }
                    let (mx, my) = (w.get_var(clip, "_x").num() as i32, w.get_var(clip, "_y").num() as i32);
                    let t = &mut self.tiles[i];
                    let (tw, th) = (self.data.tiles[i].w, self.data.tiles[i].h);
                    let off = self.data.tiles[i].o + 30;
                    t.tx = mx - tw - off;
                    t.ty = my - th - off;
                    t.xp = t.tx + tw + off * 2;
                    t.yp = t.ty + th + off * 2;
                    t.x = mx;
                    t.y = my;
                }
                let in_vts = self.vts.get(&i).copied().unwrap_or(false);
                let det = w.get_var(clip, "detached").truthy();
                let notile = !w.get_var(clip, "notile").is_undef();
                if !in_vts && !det && !notile {
                    self.tiles[i].off = w.get_var(clip, "off").truthy();
                    self.tiles[i].detached = det;
                    self.detach(w, i);
                }
            }
        } else {
            self.oax = Some(cx);
            self.oay = Some(cy);
            let mut vt: Vec<usize> = Vec::new();
            for key in [(cx, cy), (cx + 1, cy), (cx, cy + 1), (cx + 1, cy + 1)] {
                if let Some(v) = self.cells.get(&key) {
                    vt.extend(v.iter().copied());
                }
            }
            vt.sort_unstable();
            vt.dedup();
            self.vt = vt;
        }
        let (r, b) = (ix + SCREEN_W as i32, iy + SCREEN_H as i32);
        self.vts.clear();
        for k in 0..self.vt.len() {
            let i = self.vt[k];
            let t = &self.tiles[i];
            if t.xp > ix && t.tx < r && t.yp > iy && t.ty < b {
                self.vts.insert(i, true);
                if t.clip == NONE || !w.alive(t.clip) {
                    let ok = self.attach(w, host, i);
                    self.vts.insert(i, ok);
                }
            }
        }
        if let Some(c) = w.clip_mut(self.base) {
            c.m.tx = -self.cam_x;
            c.m.ty = -self.cam_y;
        }
    }

    fn attach(&mut self, w: &mut World, host: &mut LHost, i: usize) -> bool {
        let (link, x, y, depth, enemy, detached, off) = {
            let t = &self.tiles[i];
            (t.link.clone(), t.x, t.y, t.depth, t.enemy, t.detached, t.off)
        };
        let off_now = off || self.off_links.contains(&link);
        if !enemy && detached {
            return false;
        }
        if enemy && off_now {
            return false;
        }
        let name = format!("{}", i + 1);
        let Some(clip) = w.attach_from(self.base, self.base_lib, &link, &name, depth, host) else { return false };
        if let Some(c) = w.clip_mut(clip) {
            c.m.tx = x as f32;
            c.m.ty = y as f32;
            c.prev_m = c.m;
        }
        self.tiles[i].clip = clip;
        if enemy {
            w.set_var(clip, "id", Value::Num(i as f64));
            self.pending_enemy(clip, i);
        } else {
            if let Some(k) = mover_kind(&link) {
                self.pending_mover.insert(clip, k);
            }
            if off_now {
                w.goto_label(clip, "off", false);
                w.set_var(clip, "off", Value::Bool(true));
            }
        }
        // symbols call init() from their frame scripts
        let inits = std::mem::take(&mut host.inits);
        for c in inits {
            self.on_init(w, c);
        }
        true
    }

    fn pending_enemy(&mut self, clip: ClipId, tile: usize) {
        let link = self.tiles[tile].link.clone();
        self.spawn_enemy(clip, &link, tile);
    }

    /// EnemyUtil.create: the actor object for a freshly attached enemy symbol.
    fn spawn_enemy(&mut self, clip: ClipId, link: &str, tile: usize) {
        let Some(kind) = enemy_kind(link) else { return };
        let (ws, weight) = is_enemy_link(link).unwrap_or((1.0, 0.55));
        let mut e = Char::new(clip, true);
        e.walkspeed = ws;
        e.weight = weight;
        e.kind = kind;
        e.energy = match kind {
            EK::Stack(n) => n,
            EK::SnowSpider => 9999,
            EK::ElPix => 8,
            _ => 1,
        };
        e.newdir = -1;
        e.dir = -1;
        e.tile = tile;
        e.name = if tile == usize::MAX { format!("spawn{}", self.spawn_counter) } else { format!("{}", tile + 1) };
        e.depth = if tile == usize::MAX { 6000 } else { self.tiles[tile].depth };
        e.alive = false; // becomes active on init()
        self.enemies.push(e);
        self.enemy_of_clip.insert(clip, self.enemies.len() - 1);
    }
    fn detach(&mut self, w: &mut World, i: usize) {
        let clip = self.tiles[i].clip;
        if let Some(&e) = self.enemy_of_clip.get(&clip) {
            self.tiles[i].detached = false;
            self.enemies[e].alive = false;
            self.enemy_of_clip.remove(&clip);
        }
        self.movers.remove(&clip);
        self.pending_mover.remove(&clip);
        w.remove(clip);
        self.tiles[i].clip = NONE;
    }

    /// Called when a tile's frame script reaches `init()`.
    fn on_init(&mut self, w: &mut World, clip: ClipId) {
        if let Some(&e) = self.enemy_of_clip.get(&clip) {
            let (x, y) = (w.get_var(clip, "_x").num() as f32, w.get_var(clip, "_y").num() as f32);
            let ch = &mut self.enemies[e];
            ch.x = x;
            ch.y = y;
            ch.lx = x;
            ch.ly = y;
            match ch.kind {
                EK::Mom | EK::SnowSpider => ch.create_box(w, -1.0, 0.0, 0.0, -40.0),
                EK::Web => ch.create_box(w, -1.0, 10.0, -15.0, 0.0),
                EK::Iceball => ch.create_box(w, -1.0, 5.0, 0.0, 0.0),
                _ => ch.create_box(w, -1.0, 0.0, 0.0, 0.0),
            }
            if ch.kind == EK::ElPix {
                ch.pipeline = vec!["pinku", "orange", "purpu", "speedywood"];
            }
            ch.alive = true;
            if let Some(d) = w.get_var(clip, "dir").num().is_finite().then(|| w.get_var(clip, "dir").num()) {
                ch.newdir = d as i32;
                ch.dir = d as i32;
            }
            return;
        }
        if let Some(k) = self.pending_mover.remove(&clip) {
            self.make_mover(w, clip, k);
        }
    }

    fn make_mover(&mut self, w: &mut World, tile_clip: ClipId, kind: MoverKind) {
        let obstacle = w.child_named(tile_clip, "obstacle").or_else(|| w.child_named(tile_clip, "obstacle1"));
        let platform = w.child_named(tile_clip, "platform").unwrap_or(NONE);
        let Some(ob) = obstacle else { return };
        let level = w.get_var(ob, "_y").num() as f32;
        let (max_angle, max_move, tide) = match kind {
            MoverKind::Wackel => (40.0, 1.5, 0.0),
            MoverKind::Tilting => (20.0, 0.5, 0.3),
            MoverKind::Stamm => (0.0, 0.0, 0.3),
            MoverKind::Cloud => (0.0, 0.0, 0.0),
        };
        let force = {
            let f = w.get_var(ob, "force");
            if f.is_undef() { 1000.0 } else { f.num() as f32 }
        };
        let pivot = w.bounds_in(ob, ob).map(|b| (b.width() / 2.0).trunc()).unwrap_or(0.0);
        let plat_y = if platform != NONE { w.get_var(platform, "_y").num() as f32 } else { 0.0 };
        self.movers.insert(
            ob,
            Mover { kind, obstacle: ob, platform, level, vy: tide, offset: plat_y - level, limit: level + 30.0, angle: 0.0, drift: 0.0, force, max_angle, max_move, pivot, slip: 0.0, glide: 0.0, dir: 1 },
        );
        // collision code reads these off the obstacle clip
        w.set_var(ob, "ease", Value::Bool(matches!(kind, MoverKind::Stamm | MoverKind::Tilting | MoverKind::Cloud)));
        w.set_var(ob, "pause", Value::Bool(false));
    }

    fn movers_process(&mut self, w: &mut World) {
        let keys: Vec<ClipId> = self.movers.keys().copied().collect();
        for k in keys {
            if !w.alive(k) {
                self.movers.remove(&k);
                continue;
            }
            let m = self.movers.get_mut(&k).unwrap();
            let (cur_y, cur_rot) = (w.get_var(k, "_y").num() as f32, w.get_var(k, "_rotation").num() as f32);
            let mut y = cur_y;
            if matches!(m.kind, MoverKind::Cloud | MoverKind::Stamm | MoverKind::Tilting) {
                let (maxv, damp, div) = match m.kind {
                    MoverKind::Cloud => (2.0, 0.5, if y < m.level { 50.0 } else { 100.0 }),
                    MoverKind::Stamm => (1.0, 0.95, if y < m.level { 50.0 } else { 100.0 }),
                    _ => (1.0, 0.95, if y < m.level { 50.0 } else { 100.0 }),
                };
                if y < m.level && m.vy > 0.2 {
                    m.vy *= damp;
                }
                m.vy += (y - m.level) / div;
                m.vy = lerp_clamp(m.vy, -maxv, maxv);
                y -= m.vy;
                if m.kind == MoverKind::Cloud && y > m.limit {
                    y = m.limit;
                }
                w.set_var(k, "_y", Value::Num(y as f64));
                if m.platform != NONE {
                    w.set_var(m.platform, "_y", Value::Num((y + m.offset) as f64));
                }
            }
            if matches!(m.kind, MoverKind::Tilting | MoverKind::Wackel) {
                if cur_rot < 0.0 {
                    m.dir = -1;
                    m.drift += 0.05;
                } else {
                    m.dir = 1;
                    m.drift -= 0.05;
                }
                m.drift *= 0.95;
                m.angle += m.drift;
                let (slip_div, ) = (if m.kind == MoverKind::Wackel { 70.0 } else { 180.0 },);
                m.slip = m.angle / slip_div;
                m.glide = m.angle / 100.0;
                if m.glide < 0.1 && m.glide > -0.01 {
                    m.glide = 0.0;
                }
                m.angle = lerp_clamp(m.angle, -m.max_angle, m.max_angle);
                w.set_var(k, "_rotation", Value::Num(m.angle as f64));
                if m.platform != NONE {
                    w.set_var(m.platform, "_rotation", Value::Num(m.angle as f64));
                }
                w.set_var(k, "slip", Value::Num(m.slip as f64));
                w.set_var(k, "glide", Value::Num(m.glide as f64));
                w.set_var(k, "dir", Value::Num(m.dir as f64));
            }
        }
    }

    // -------------------------------------------------------------- collisions

    fn obstacles(&self, w: &World) -> Vec<ClipId> {
        let mut out = Vec::new();
        let Some(base) = w.clip(self.base) else { return out };
        for (_, &tile) in base.children.iter() {
            let Some(tc) = w.clip(tile) else { continue };
            if let Some(&o) = tc.children.values().find(|k| w.clip(**k).map(|c| c.name == "obstacle").unwrap_or(false)) {
                out.push(o);
            } else {
                let n = w.get_var(tile, "obstacles").num();
                if n.is_finite() {
                    for i in 1..=(n as i32) {
                        if let Some(o) = w.child_named(tile, &format!("obstacle{}", i)) {
                            out.push(o);
                        }
                    }
                }
            }
        }
        out
    }

    fn bounds(&self, w: &World, c: ClipId) -> Rect {
        w.bounds_in(c, self.base).unwrap_or_default()
    }

    /// CollisionUtil.getCollisions + resolveCollisions.
    fn resolve(&mut self, w: &mut World, who: Who) -> Vec<Hit> {
        let ch = match who {
            Who::Hero => &self.hero,
            Who::Enemy(i) => &self.enemies[i],
        };
        let (vy, enemy, weight, pivot) = (ch.vy, ch.enemy, ch.weight, ch.pivot);
        let b = ch.box_rect();
        let box_name = ch.name.clone();
        let on_movable_prev = ch.on_movable;
        let mut cols: Vec<ClipId> = Vec::new();
        for o in self.obstacles(w) {
            let parent = w.clip(o).map(|c| c.parent).unwrap_or(NONE);
            if enemy {
                let pname = w.clip(parent).map(|c| c.name.clone()).unwrap_or_default();
                if box_name == pname || w.get_var(o, "hero").truthy() {
                    continue;
                }
            }
            let ob = self.bounds(w, o);
            if b.x0 <= ob.x1 && b.x1 >= ob.x0 && b.y0 <= ob.y1 && b.y1 >= ob.y0 {
                cols.push(o);
            }
        }
        let mut res: Vec<Hit> = Vec::new();
        let (mut got_move, mut on_top, mut head) = (false, false, false);
        let mut on_movable = on_movable_prev;
        for o in cols {
            let ty = {
                let t = w.get_var(o, "type");
                if t.is_undef() { f64::NAN } else { t.num() }
            };
            if ty.is_nan() {
                continue;
            }
            let ty = ty as i32;
            if w.get_var(o, "enemy").truthy() && !enemy {
                continue;
            }
            let ob = self.bounds(w, o);
            let (mut action, mut dx, mut dy, mut hit) = (0, None, None, false);
            if (80..=99).contains(&ty) {
                res.push(Hit { action: A_PICKUP, obstacle: o, a: None, b: None, flag: false });
                continue;
            }
            if !(0..=79).contains(&ty) {
                continue;
            }
            if ty == O_DEADLY {
                res.push(Hit { action: A_DEADLY, obstacle: o, a: None, b: None, flag: false });
            }
            let dir = w.get_var(o, "dir").num();
            if ty == O_BEVEL {
                if !((b.x0 + pivot) < ob.x0 - 1.0) && !((b.x1 - pivot) > ob.x1 + 1.0) {
                    let pct = if dir == 1.0 { 100.0 * ((b.x1 - pivot) - ob.x0) / (ob.x1 - ob.x0) } else { 100.0 * ((ob.x1 - b.x1) + pivot) / (ob.x1 - ob.x0) };
                    let ramp = ((ob.y1 - ob.y0) * pct) / 100.0;
                    let rel = (b.y1 - vy) - ob.y0;
                    let tol = ((MAX_VEL / 2.0) + TOLERANCE) + GRAVITY + 2.0;
                    if !(rel < ramp - tol) && !(rel > ramp + tol) {
                        dy = Some(ramp + TOLERANCE);
                        if !(vy < 0.0 - (GRAVITY + TOLERANCE)) {
                            action = A_SNAPBOTTOM;
                            if w.get_var(o, "tilting").truthy() {
                                let parent = w.clip(o).map(|c| c.parent).unwrap_or(NONE);
                                let bb = w.bounds_in(o, parent);
                                let _ = bb;
                                let me = match who { Who::Hero => self.hero.box_rect(), Who::Enemy(i) => self.enemies[i].box_rect() };
                                self.mover_impact(w, o, me.x1 - pivot, weight);
                            }
                            if w.get_var(o, "ease").truthy() && on_movable.is_none() {
                                self.mover_push(w, o, vy);
                            }
                            if w.get_var(o, "moving").truthy() {
                                on_movable = Some(o);
                                got_move = true;
                            }
                        }
                    }
                }
            } else {
                let flying_extra = if w.get_var(o, "flying").truthy() { 5.0 } else { 0.0 };
                if !((b.y1 - ob.y0) > (MAX_VEL + GRAVITY + TOLERANCE + flying_extra)) {
                    if w.get_var(o, "drop").truthy() {
                        self.mover_push(w, o, vy);
                    }
                    if !(vy < GRAVITY) && !w.get_var(o, "noTop").truthy() && !head {
                        action = A_SNAPBOTTOM;
                        on_top = true;
                        if w.get_var(o, "ease").truthy() && on_movable.is_none() {
                            self.mover_push(w, o, vy);
                        }
                        if w.get_var(o, "moving").truthy() {
                            on_movable = Some(o);
                            got_move = true;
                            let (lx, x) = (w.get_var(o, "lx"), w.get_var(o, "x"));
                            if !lx.is_undef() {
                                dx = Some((lx.num() - x.num()) as f32);
                            }
                        }
                        if (30..=79).contains(&ty) && vy > 1.0 {
                            hit = true;
                            if ty == 31 || enemy {
                                action = 0;
                            }
                        }
                    }
                }
            }
            if ty == O_LADDER {
                let up_on = !((b.y1 - ob.y0) > (vy + 5.0));
                res.push(Hit { action: A_HITLADDER, obstacle: o, a: Some(if up_on { 1.0 } else { 0.0 }), b: Some(0.0), flag: up_on });
                if !up_on {
                    continue;
                }
            }
            if vy < 1.0 && ty == O_MASSIVE && !((ob.y1 - b.y0) > (MAX_VEL + 2.0)) && !w.get_var(o, "noTop").truthy() && !w.get_var(o, "noBottom").truthy() && action == 0 && !on_top {
                action = A_SNAPTOP;
                head = true;
            }
            if action == 0 && ty == O_MASSIVE && (b.y1 - ob.y0) > 3.0 {
                if !((b.x1 - ob.x0) > (MAX_VEL + 2.0)) {
                    action = A_SNAPLEFT;
                } else if !((ob.x1 - b.x0) > (MAX_VEL + 2.0)) {
                    action = A_SNAPRIGHT;
                }
            }
            if action != 0 {
                res.push(Hit { action, obstacle: o, a: dx, b: dy, flag: false });
            }
            if (30..=79).contains(&ty) {
                res.push(Hit { action: A_HITENEMY, obstacle: o, a: None, b: None, flag: hit });
            }
        }
        // keep standing on a moving platform that we no longer overlap in this frame
        if let Some(m) = on_movable {
            if !got_move && w.alive(m) {
                let ob = self.bounds(w, m);
                let mut piv = pivot;
                if w.get_var(m, "flying").truthy() {
                    piv += pivot;
                }
                if !((b.x0 + piv) < ob.x0 - 1.0) && !((b.x1 - piv) > ob.x1 + 1.0) {
                    let mut dy = 0.0;
                    let dx = {
                        let (lx, x) = (w.get_var(m, "lx"), w.get_var(m, "x"));
                        if lx.is_undef() { 0.0 } else { (lx.num() - x.num()) as f32 }
                    };
                    if w.get_var(m, "type").num() as i32 == O_BEVEL {
                        let dir = w.get_var(m, "dir").num();
                        let pct = if dir == 1.0 { 100.0 * ((b.x1 - pivot) - ob.x0) / (ob.x1 - ob.x0) } else { 100.0 * ((ob.x1 - b.x1) + pivot) / (ob.x1 - ob.x0) };
                        dy = ((ob.y1 - ob.y0) * pct) / 100.0 - TOLERANCE;
                    }
                    res.push(Hit { action: A_SNAPBOTTOM, obstacle: m, a: Some(dx), b: Some(dy), flag: false });
                } else {
                    on_movable = None;
                }
            }
        }
        if matches!(who, Who::Hero) && std::env::var("TRACE_HITS").is_ok() {
            let list: Vec<String> = res.iter().map(|h| {
                let ob = self.bounds(w, h.obstacle);
                format!("a{}:{}({:.0},{:.0},{:.0},{:.0})", h.action, w.get_var(h.obstacle, "type").num(), ob.x0, ob.y0, ob.x1, ob.y1)
            }).collect();
            println!("  hits t={} box=({:.1},{:.1},{:.1},{:.1}) vy={:.2} {:?}", self.tick_count, b.x0, b.y0, b.x1, b.y1, vy, list);
        }
        match who {
            Who::Hero => self.hero.on_movable = on_movable,
            Who::Enemy(i) => self.enemies[i].on_movable = on_movable,
        }
        res
    }

    fn mover_impact(&mut self, _w: &mut World, ob: ClipId, x: f32, weight: f32) {
        if let Some(m) = self.movers.get_mut(&ob) {
            if matches!(m.kind, MoverKind::Tilting | MoverKind::Wackel) {
                m.drift += ((x + m.pivot) / m.force) * weight;
                m.drift = lerp_clamp(m.drift, -m.max_move, m.max_move);
            }
        }
    }

    fn mover_push(&mut self, _w: &mut World, ob: ClipId, vy: f32) {
        if let Some(m) = self.movers.get_mut(&ob) {
            match m.kind {
                MoverKind::Cloud => {
                    if !(m.level + 0.0 > 0.0 && false) {
                        m.vy -= vy;
                    }
                }
                MoverKind::Stamm => m.vy -= vy,
                MoverKind::Tilting => m.vy -= vy,
                MoverKind::Wackel => {}
            }
        }
    }
}

#[derive(Clone, Copy)]
enum Who {
    Hero,
    Enemy(usize),
}

impl Level {
    fn ch(&mut self, who: Who) -> &mut Char {
        match who {
            Who::Hero => &mut self.hero,
            Who::Enemy(i) => &mut self.enemies[i],
        }
    }

    // ------------------------------------------------------------ Char physics

    fn calculate(&mut self, who: Who) {
        let mut sfx: Vec<Sfx> = Vec::new();
        {
            let c = self.ch(who);
            c.mv = M_STAND;
            if c.on_ground && c.r_action_up {
                c.r_action_up = false;
                c.jumps = 1;
                c.jumpstage = 0;
                c.jumpcnt = 0;
            }
            if c.on_ladder {
                c.vx = 0.0;
                c.vy = 0.0;
            } else {
                c.vy += GRAVITY;
            }
            let acc = if c.walks < 50 { WALK_MAX_ACC } else { RUN_MAX_ACC };
            if c.left && (!c.down || c.on_ladder) {
                if c.on_ladder {
                    c.vx = -CLIMB_SPEED;
                } else {
                    if c.vx > -acc {
                        c.vx -= WALK_ACC;
                    }
                    if c.dir == 1 {
                        c.mv = M_FLIP;
                        c.walks = 0;
                    } else {
                        if c.walks > 60 {
                            c.mv = M_RUN;
                            if c.walks == 61 {
                                sfx.push(Sfx::Player("steps"));
                            }
                        } else {
                            c.mv = M_WALK;
                        }
                        c.walks += 1;
                    }
                }
                c.newdir = -1;
            } else if c.right && (!c.down || c.on_ladder) {
                if c.on_ladder {
                    c.vx = CLIMB_SPEED;
                } else {
                    if c.vx < acc {
                        c.vx += WALK_ACC;
                    }
                    if c.dir == -1 {
                        c.mv = M_FLIP;
                        c.walks = 0;
                    } else {
                        if c.walks > 60 {
                            c.mv = M_RUN;
                            if c.walks == 61 {
                                sfx.push(Sfx::Player("steps"));
                            }
                        } else {
                            c.mv = M_WALK;
                        }
                        c.walks += 1;
                    }
                }
                c.newdir = 1;
            } else {
                c.vx *= if c.slides > 0 { FRICTION_SLIDE } else { FRICTION };
                c.walks = 0;
            }
            if c.up {
                c.slides = 0;
                if c.hit_ladder && !c.hit_top {
                    c.on_ladder = true;
                    c.vy = -CLIMB_SPEED;
                } else {
                    c.jumps += 1;
                    if c.jumps < 3 {
                        c.jumpstage = 1;
                    } else if c.jumps < 5 {
                        c.jumpstage = 2;
                    } else if c.jumps < 7 {
                        c.jumpstage = if c.mv == M_RUN { 4 } else { 3 };
                    }
                    if c.jumps == 2 {
                        sfx.push(Sfx::Player("jump"));
                    }
                }
            } else if c.down {
                if c.hit_ladder || c.upon_ladder {
                    c.on_ladder = true;
                    c.vy = CLIMB_SPEED;
                    if c.upon_ladder {
                        c.hit_ladder = true;
                    }
                } else if c.on_ground {
                    c.mv = M_CROUCH;
                    c.box_scale = 0.5;
                    if !c.l_down {
                        sfx.push(Sfx::Player("crouch"));
                    }
                }
            } else {
                c.slides = 0;
                c.r_action_up = true;
            }
            if c.jumpstage > 0 {
                // original: `if (!(this.jumpcnt++ > this.jumpstage))` (post-increment)
                let old = c.jumpcnt;
                c.jumpcnt += 1;
                if !(old > c.jumpstage) {
                    c.vy -= 5.0;
                    c.on_movable = None;
                }
            }
            if c.slides > 0 {
                c.mv = M_SLIDE;
                c.slides += 1;
                if c.slides > 50 {
                    c.slides = 0;
                }
            }
            if c.vy < -TOLERANCE {
                c.mv = M_JUMP;
            } else if c.vy > GRAVITY && c.slides == 0 {
                c.mv = M_FALL;
                c.jumps = 11;
            }
            if c.mv == M_STAND && c.vx.abs() > 0.5 {
                c.mv = M_WALK;
            }
            if c.on_ladder {
                if c.hit_ladder {
                    c.mv = M_CLIMB;
                } else {
                    c.on_ladder = false;
                }
            }
            if c.mv != M_FALL {
                sfx.push(Sfx::PlayerStop("steps"));
            }
            if c.mv != M_CROUCH && c.mv != M_SLIDE {
                c.box_scale = 1.0;
            }
            c.vx = (c.vx * 1000.0).trunc() / 1000.0;
            c.vx = c.vx.clamp(-RUN_MAX_ACC, RUN_MAX_ACC);
            if c.vx < 0.1 && c.vx > -0.1 {
                c.vx = 0.0;
            }
            c.vy = c.vy.clamp(-MAX_VEL, MAX_VEL);
        }
        if matches!(who, Who::Hero) {
            self.sfx.extend(sfx);
        }
    }

    fn adjust(&mut self, w: &mut World, host: &mut LHost, who: Who) {
        let hits = self.resolve(w, who);
        {
            let c = self.ch(who);
            c.on_ground = false;
            c.hit_ladder = false;
            c.upon_ladder = false;
            c.hit_top = false;
        }
        let mut hit_enemy_done = false;
        let b = self.ch(who).box_rect();
        for h in hits {
            if !w.alive(h.obstacle) {
                continue;
            }
            let ob = self.bounds(w, h.obstacle);
            match h.action {
                A_SNAPBOTTOM => {
                    let skip = { let c = self.ch(who); c.upon_ladder && c.down };
                    if skip {
                        continue;
                    }
                    let glide = w.get_var(h.obstacle, "glide");
                    let slip = w.get_var(h.obstacle, "slip");
                    let odir = w.get_var(h.obstacle, "dir");
                    let c = self.ch(who);
                    c.on_ground = true;
                    c.oy = (ob.y0 - b.y1) + TOLERANCE;
                    if (c.mv == M_CROUCH || c.mv == M_SLIDE) && !glide.is_undef() && (glide.num() as f32).abs() > 0.05 {
                        if odir.num() as i32 == c.dir {
                            c.vx += glide.num() as f32;
                        }
                        c.slides = 1;
                    }
                    if !slip.is_undef() && !c.enemy {
                        c.vx += slip.num() as f32;
                    }
                    if let Some(a) = h.a {
                        c.ox += a;
                    }
                    if let Some(bb) = h.b {
                        c.oy += bb;
                    }
                    if c.vy > 0.0 {
                        c.vy = 0.0;
                    }
                    c.ly = (c.y + c.vy) + c.oy;
                }
                A_SNAPTOP => {
                    let c = self.ch(who);
                    c.oy = (ob.y1 - b.y0) + TOLERANCE;
                    c.vy = 0.0;
                    c.ly = (c.y + c.vy) + c.oy;
                    c.hit_top = true;
                }
                A_SNAPLEFT => {
                    let c = self.ch(who);
                    c.ox = (ob.x0 - b.x1) - TOLERANCE;
                    c.vx = 0.0;
                    c.lx = (c.x + c.vx) + c.ox;
                    c.walks = 0;
                    self.bound(who, -1);
                }
                A_SNAPRIGHT => {
                    let c = self.ch(who);
                    c.ox = (ob.x1 - b.x0) + TOLERANCE;
                    c.vx = 0.0;
                    c.lx = (c.x + c.vx) + c.ox;
                    c.walks = 0;
                    self.bound(who, 1);
                }
                A_HITLADDER => {
                    let c = self.ch(who);
                    if h.flag {
                        c.upon_ladder = true;
                    } else {
                        c.hit_ladder = true;
                        c.on_ladder = true;
                    }
                }
                A_HITENEMY => {
                    self.hit_enemy(w, host, who, h.obstacle, h.flag, hit_enemy_done);
                    hit_enemy_done = true;
                }
                A_DEADLY => {
                    if matches!(who, Who::Hero) {
                        self.hero_die(w, host);
                    }
                }
                A_PICKUP => {
                    if matches!(who, Who::Hero) {
                        self.pickup(w, host, h.obstacle);
                    }
                }
                _ => {}
            }
        }
    }

    /// event_boundLeft/Right of the actor classes.
    fn bound(&mut self, who: Who, side: i32) {
        if let Who::Enemy(i) = who {
            let e = &mut self.enemies[i];
            match e.kind {
                EK::Speedy => {
                    e.newdir = side;
                    e.pause = 0;
                }
                EK::Tree => {
                    e.newdir = side;
                    e.pause = 1;
                }
                EK::Mom => {
                    if e.angry > 0 {
                        e.pause = 30;
                        e.angry = 30;
                    } else {
                        e.newdir = side;
                        e.pause = 10;
                    }
                }
                EK::SnowSpider => {
                    if e.angry > 0 {
                        e.pause = 10;
                        e.angry = 10;
                    } else {
                        e.newdir = side;
                        e.pause = 10;
                    }
                }
                EK::Iceball => {
                    e.dir = side;
                    if side == 1 {
                        e.ox = 2.0;
                        e.vx = 0.0;
                    }
                }
                _ => {
                    e.newdir = side;
                    e.pause = 10;
                    e.ox = 2.0 * side as f32;
                    e.vx = 0.0;
                }
            }
        }
    }
    fn position(&mut self, who: Who) {
        let c = self.ch(who);
        c.x += c.vx + c.ox;
        c.y += c.vy + c.oy;
    }

    fn save_states(&mut self, who: Who) {
        let c = self.ch(who);
        c.mv = 0;
        c.ox = 0.0;
        c.oy = 0.0;
        c.lx = c.x;
        c.ly = c.y;
    }

    fn animate(&mut self, w: &mut World, host: &mut LHost, who: Who) {
        let (actor, mv, lock, enemy, vx, vy) = {
            let c = self.ch(who);
            (c.actor, c.mv, c.lockmove, c.enemy, c.vx, c.vy)
        };
        let container = w.child_named(actor, "container");
        if lock < 1 {
            if let Some(ct) = container {
                w.jump(ct, mv.max(1) as u16, false, host);
            }
        } else {
            self.ch(who).lockmove -= 1;
        }
        if mv == M_CLIMB {
            if let Some(inner) = container.and_then(|c| w.child_named(c, "container")) {
                w.set_playing(inner, !(vx == 0.0 && vy == 0.0));
            }
        }
        let c = self.ch(who);
        if c.dir != c.newdir {
            c.lockmove = (vx as i32).abs() + 4;
            c.dir = c.newdir;
            if !enemy {
                w.flip_x(actor);
            } else if let Some(ct) = container {
                w.flip_x(ct);
            }
        }
    }

    // ------------------------------------------------------------------ hero

    fn hero_process(&mut self, w: &mut World, host: &mut LHost, input: &Input) {
        if self.hero_frozen {
            return;
        }
        self.save_states(Who::Hero);
        {
            let lock = self.lockinput;
            let c = &mut self.hero;
            c.l_down = c.down;
            c.up = false;
            c.left = false;
            c.right = false;
            c.down = false;
            if lock == 0 {
                if input.left {
                    c.left = true;
                } else if input.right {
                    c.right = true;
                }
                if input.up {
                    c.up = true;
                } else if input.down {
                    c.down = true;
                }
            }
        }
        self.calculate(Who::Hero);
        self.adjust(w, host, Who::Hero);
        self.position(Who::Hero);
        if self.outcome == Outcome::Dead {
            return;
        }
        self.animate(w, host, Who::Hero);
        if self.lockinput > 0 {
            self.lockinput -= 1;
        }
        if self.untouchable > 0 {
            self.untouchable -= 1;
            if self.untouchable == 0 {
                w.jump(self.hero.actor, 1, false, host);
            }
        }
        self.sox = (self.sox + self.hero.vx / 2.0).clamp(-50.0, 50.0);
        self.soy = (self.soy + self.hero.vy / 10.0).clamp(-50.0, 50.0);
        self.scroll_x = self.hero.lx - (240.0 - self.sox);
        self.scroll_y = self.hero.ly - (self.data.sh - self.soy);
        self.apply_hero_pos(w);
        if self.hero.ly > 3000.0 {
            self.hero_die(w, host);
        }
    }

    fn hero_hit(&mut self, w: &mut World, host: &mut LHost) -> bool {
        self.hero.energy -= 1;
        if self.hero.energy == 0 {
            self.hero_die(w, host);
            true
        } else {
            let e = self.hero.energy;
            if let Some(h) = w.child_named(self.hud_energy, &format!("energy_{}", e)) {
                w.jump_label(h, "lost", true, host);
            }
            self.hero.lockmove = 20;
            self.lockinput = 20;
            self.untouchable = 70;
            w.jump(self.hero.actor, 2, true, host);
            if let Some(ct) = w.child_named(self.hero.actor, "container") {
                w.jump(ct, M_HURT as u16, false, host);
            }
            self.sfx.push(Sfx::Player("hurt"));
            false
        }
    }

    fn hero_die(&mut self, w: &mut World, host: &mut LHost) {
        if self.outcome != Outcome::Playing {
            return;
        }
        if let Some(ct) = w.child_named(self.hero.actor, "container") {
            w.jump(ct, M_DIE as u16, false, host);
        }
        w.jump(self.hero.actor, 1, false, host);
        self.outcome = Outcome::Dead;
        self.hero_frozen = true;
        self.sfx.push(Sfx::MusicStop);
        self.sfx.push(Sfx::Player("hurt"));
        self.sfx.push(Sfx::PlayerStop("steps"));
        self.sfx.push(Sfx::Player("gameover"));
        // everything but the hero stops
        let (base, hero) = (self.base, self.hero.actor);
        w.stop_subtree(base, hero);
        for i in 1..self.energymax {
            if let Some(h) = w.child_named(self.hud_energy, &format!("energy_{}", i)) {
                w.jump_label(h, "lost", true, host);
            }
        }
    }

    fn hit_enemy(&mut self, w: &mut World, host: &mut LHost, who: Who, obstacle: ClipId, hit: bool, hit_done: bool) {
        let ty = w.get_var(obstacle, "type").num() as i32;
        let parent = w.clip(obstacle).map(|c| c.parent).unwrap_or(NONE);
        match who {
            Who::Hero => {
                if ty == 36 {
                    if self.untouchable == 0 && (self.hero.mv == M_JUMP || self.hero.mv == M_FALL) {
                        self.hero.vy -= JUMP_FORCE / 2.0;
                        self.hero_hit(w, host);
                    }
                    return;
                }
                if (hit && ty != 31) || (self.hero.slides > 0 && ty != 31) {
                    self.hit_actor(w, host, parent);
                    if !hit_done {
                        if self.hero.mv != M_SLIDE {
                            if !self.hero.up {
                                self.hero.vy -= JUMP_FORCE / 2.0;
                            } else {
                                self.hero.jumps = 1;
                                self.hero.jumpstage = 0;
                                self.hero.jumpcnt = 0;
                            }
                            self.hero.r_action_up = false;
                        }
                        self.sfx.push(Sfx::Player("hitEnemy"));
                    }
                    match ty {
                        30 => self.attack_pinku = Some(self.hero.x),
                        33 => self.hero.vy -= JUMP_FORCE / 6.0,
                        35 => self.hero.vy -= JUMP_FORCE + 5.0,
                        _ => {}
                    }
                } else if self.untouchable == 0 {
                    self.hero_hit(w, host);
                }
            }
            Who::Enemy(i) => {
                if self.enemies[i].pause > 0 {
                    return;
                }
                let kind = self.enemies[i].kind;
                let my_depth = self.enemies[i].depth;
                let other_depth = w.clip(parent).map(|c| c.depth).unwrap_or(0);
                let other_link = w.get_var(parent, "linkId");
                let mom = matches!(&other_link, Value::Str(s) if s == "pinkumom");
                match kind {
                    EK::Pinku | EK::Stack(_) => {
                        if my_depth > other_depth && !mom {
                            self.enemies[i].pause = 40;
                        }
                    }
                    EK::Speedy | EK::Web => {
                        if my_depth > other_depth && !mom {
                            if self.rand(2) == 1 {
                                let e = &mut self.enemies[i];
                                e.newdir *= -1;
                                e.pause = 40;
                                e.ox = 2.0 * e.newdir as f32;
                                if kind == EK::Web {
                                    e.vx = 0.0;
                                    e.vy = 0.0;
                                }
                            } else {
                                self.enemies[i].pause = 40;
                            }
                        }
                    }
                    EK::Joggy => {
                        let e = &mut self.enemies[i];
                        e.newdir *= -1;
                        e.pause = 10;
                        e.ox = 2.0 * e.newdir as f32;
                        e.vx = 0.0;
                    }
                    _ => {}
                }
            }
        }
    }

    /// `actor.event_hit()` of the enemy that owns `tile_clip`.
    fn hit_actor(&mut self, w: &mut World, host: &mut LHost, tile_clip: ClipId) {
        let Some(&e) = self.enemy_of_clip.get(&tile_clip) else { return };
        if self.enemies[e].kind == EK::ElPix && self.enemies[e].untouchable > 0 {
            return;
        }
        let hx = self.hero.x;
        let en = &mut self.enemies[e];
        en.energy -= 1;
        if en.energy <= 0 {
            self.enemy_die(w, host, e);
            return;
        }
        match self.enemies[e].kind {
            EK::Stack(_) => {
                let energy = self.enemies[e].energy;
                if let Some(c) = w.child_named(tile_clip, "container") {
                    let p = w.path(c, &format!("p{}", energy));
                    w.jump(p, 2, false, host);
                    if energy == 1 {
                        let carry = w.path(c, "carry");
                        w.set_var(carry, "_visible", Value::Bool(false));
                        let walk = w.path(c, "walk");
                        w.set_var(walk, "_visible", Value::Bool(true));
                    }
                }
                let o_old = w.path(tile_clip, &format!("obstacle{}", energy + 1));
                w.set_var(o_old, "type", Value::Num(9999.0));
                w.set_var(o_old, "_visible", Value::Bool(false));
                let o_new = w.path(tile_clip, &format!("obstacle{}", energy));
                w.set_var(o_new, "type", Value::Num(30.0));
            }
            EK::SnowSpider => {
                let en = &mut self.enemies[e];
                en.target = (hx, 0.0);
                en.lockmove = 20;
                en.pause = 20;
                en.angry = 150;
                if let Some(c) = w.child_named(tile_clip, "container") {
                    w.jump(c, M_HURT as u16, false, host);
                }
            }
            EK::ElPix => {
                let energy = self.enemies[e].energy;
                if let Some(h) = w.child_named(self.hud_energy, "boss_energy") {
                    if let Some(b) = w.child_named(h, &format!("b_energy_{}", energy - 1)) {
                        w.jump_label(b, "lost", true, host);
                    }
                }
                {
                    let en = &mut self.enemies[e];
                    en.lockmove = 20;
                    en.untouchable = 70;
                }
                w.set_playing(tile_clip, false);
                let inner = w.path(tile_clip, "container.container");
                w.jump_label(inner, "hurt", true, host);
                let ship = w.path(tile_clip, "container.container.container");
                match energy {
                    5 => w.jump_label(ship, "left_break", true, host),
                    3 => {
                        w.jump_label(ship, "right_break", true, host);
                        self.enemies[e].pipeline.clear();
                    }
                    1 => {
                        w.jump_label(ship, "hit", true, host);
                        let en = &mut self.enemies[e];
                        en.lockmove = 100;
                        en.untouchable = 0;
                        let ob = w.path(tile_clip, "obstacle");
                        w.set_var(ob, "type", Value::Num(88.0));
                        w.set_var(ob, "_xscale", Value::Num(500.0));
                        w.set_var(ob, "_yscale", Value::Num(500.0));
                        let sp = w.clip(ship).map(|c| c.parent).unwrap_or(NONE);
                        w.jump(sp, 1, false, host);
                        self.enemies[e].kind = EK::Eagle; // inert: no more logic
                        self.enemies[e].alive = true;
                        // kill every other enemy
                        for j in 0..self.enemies.len() {
                            if j != e && self.enemies[j].alive {
                                self.enemy_die(w, host, j);
                            }
                        }
                    }
                    _ => {}
                }
            }
            _ => {}
        }
    }

    fn enemy_die(&mut self, w: &mut World, host: &mut LHost, e: usize) {
        let (clip, tile) = (self.enemies[e].actor, self.enemies[e].tile);
        self.enemies[e].alive = false;
        if !w.alive(clip) {
            return;
        }
        if let Some(ct) = w.child_named(clip, "container") {
            w.jump(ct, M_DIE as u16, false, host);
        }
        w.jump_label(clip, "off", false, host);
        w.set_var(clip, "detached", Value::Bool(true));
        if tile < self.tiles.len() {
            self.tiles[tile].detached = true;
        }
    }
    fn pickup(&mut self, w: &mut World, host: &mut LHost, obstacle: ClipId) {
        let ty = w.get_var(obstacle, "type").num() as i32;
        let parent = w.clip(obstacle).map(|c| c.parent).unwrap_or(NONE);
        match ty {
            80 => {
                if self.hero.energy < self.energymax {
                    self.hero.energy += 1;
                    if let Some(h) = w.child_named(self.hud_energy, &format!("energy_{}", self.hero.energy - 1)) {
                        w.jump_label(h, "fill", true, host);
                    }
                }
                self.sfx.push(Sfx::Player("energy"));
                w.jump_label(parent, "kill", true, host);
            }
            82 => {
                self.found_container = true;
                self.got_container = true;
                self.energymax += 1;
                self.hero.energy = self.energymax;
                for i in 0..self.energymax {
                    if let Some(h) = w.child_named(self.hud_energy, &format!("energy_{}", i)) {
                        w.jump_label(h, "fill", true, host);
                    }
                }
                self.sfx.push(Sfx::Player("energy_container"));
                w.jump_label(parent, "kill", true, host);
            }
            81 => {
                if self.crystals < 24 {
                    self.crystals += 1;
                    let txt = format!("{:02}/24", self.crystals);
                    if let Some(t) = w.child_named(self.hud_crystals, "crystals_txt") {
                        w.set_text(t, &txt);
                    }
                    if self.crystals == 24 {
                        self.sfx.push(Sfx::Player("energy_container"));
                        w.jump_label(self.hud_crystals, "full", true, host);
                    } else {
                        w.set_playing(self.hud_crystals, true);
                        self.sfx.push(Sfx::PlayerStop("crystal"));
                        self.sfx.push(Sfx::Player("crystal"));
                    }
                }
                w.jump_label(parent, "kill", true, host);
            }
            89 | 88 => {
                if self.finished_goal {
                    return;
                }
                self.finished_goal = true;
                self.sfx.push(Sfx::Player(if ty == 89 { "finish" } else { "finish_elpix" }));
                if self.crystals == 24 {
                    self.bonus = true;
                }
                self.sfx.push(Sfx::MusicStop);
                if ty == 89 {
                    if w.get_var(parent, "off").truthy() {
                        w.jump_label(parent, "out", false, host);
                    } else {
                        if let Some(c) = w.child_named(parent, "container") {
                            w.set_playing(c, true);
                        }
                        w.jump_label(parent, "kill", true, host);
                    }
                } else {
                    w.set_var(obstacle, "type", Value::Num(-1.0));
                    w.set_var(obstacle, "_visible", Value::Bool(false));
                }
                if let Some(ct) = w.child_named(self.hero.actor, "container") {
                    w.jump(ct, if ty == 89 { 12 } else { 13 }, false, host);
                }
                self.lockinput = 200;
                self.ticks_since_end = 1;
                self.outcome = Outcome::Playing;
            }
            90 => {
                w.set_var(obstacle, "type", Value::Num(-1.0));
                w.set_var(obstacle, "_visible", Value::Bool(false));
                if let Value::Str(s) = w.get_var(parent, "event_ops") {
                    for part in s.split(',') {
                        if let Some(l) = part.strip_prefix("gotoLabel(").and_then(|p| p.strip_suffix(')')) {
                            let playing = s.contains("play()");
                            w.jump_label(parent, l, playing, host);
                        }
                    }
                }
            }
            _ => {}
        }
    }

    // --------------------------------------------------------------- enemies

    fn enemies_process(&mut self, w: &mut World, host: &mut LHost) {
        let hero = (self.hero.x, self.hero.y);
        let attack = self.attack_pinku.take();
        for i in 0..self.enemies.len() {
            if !self.enemies[i].alive || !w.alive(self.enemies[i].actor) {
                continue;
            }
            let who = Who::Enemy(i);
            let kind = self.enemies[i].kind;
            let actor = self.enemies[i].actor;
            match kind {
                EK::Eagle => continue,
                EK::Joggy => {
                    self.enemies[i].throwcount -= 1;
                    if self.enemies[i].throwcount == 0 {
                        self.enemies[i].throwcount = 100;
                        self.throw_iceball(w, host, i);
                    }
                    continue;
                }
                EK::ElPix => {
                    self.elpix_process(w, i);
                    continue;
                }
                EK::Web => {
                    self.web_process(w, host, i, hero);
                    continue;
                }
                _ => {}
            }
            self.save_states(who);
            match kind {
                EK::Mom => {
                    let e = &mut self.enemies[i];
                    if let Some(hx) = attack {
                        if e.angry == 0 {
                            e.pause = 20;
                        }
                        e.target = (hx, 0.0);
                        e.newdir = if hx < e.x { -1 } else { 1 };
                        e.angry = 200;
                        e.next_pause = 210;
                    }
                    if e.next_pause == 0 {
                        e.angry = 0;
                        e.pause = 70;
                        e.next_pause = 100;
                    }
                }
                EK::Runner => {
                    let r = self.rand(60) as i32;
                    let (r20, r2a, r2b) = (self.rand(20) as i32, self.rand(2), self.rand(2));
                    let e = &mut self.enemies[i];
                    if e.next_change == 0 {
                        e.pause = r20 + 5;
                        if r2a == 1 {
                            e.newdir *= -1;
                            e.ox = 2.0 * e.newdir as f32;
                        }
                        e.speed = (e.walkspeed + r2b as f32) - 1.0;
                        e.pause = 20;
                        e.next_change = r + 40;
                    } else {
                        e.next_change -= 1;
                    }
                }
                _ => {}
            }
            {
                let e = &mut self.enemies[i];
                if e.pause == 0 {
                    let speed = match kind {
                        EK::Runner => e.speed,
                        _ => e.walkspeed,
                    };
                    e.vx = speed * e.dir as f32;
                    if kind == EK::Mom || kind == EK::SnowSpider {
                        if kind == EK::Mom {
                            e.next_pause -= 1;
                        }
                        if e.angry > 0 {
                            let run = if kind == EK::Mom { 5.0 } else { 12.0 };
                            e.vx = run * e.dir as f32;
                            e.newdir = if e.target.0 < e.x + e.xoff { -1 } else { 1 };
                            if e.dir != e.newdir {
                                e.pause = 20;
                            }
                        }
                    }
                } else {
                    e.pause -= 1;
                }
                if kind == EK::Mom || kind == EK::SnowSpider {
                    let angry = e.angry > 0;
                    if angry {
                        e.angry -= 1;
                    }
                    let cont = w.path(actor, "container.container");
                    let cont1 = w.path(actor, "container.container1");
                    w.set_var(cont, "_visible", Value::Bool(!angry));
                    w.set_var(cont1, "_visible", Value::Bool(angry));
                }
            }
            self.calculate(who);
            self.adjust(w, host, who);
            self.position(who);
            self.animate(w, host, who);
            let e = &self.enemies[i];
            if kind == EK::Iceball {
                let inner = w.path(actor, "container.container");
                let r = w.get_var(inner, "_rotation").num() + (e.vx * 2.0) as f64;
                w.set_var(inner, "_rotation", Value::Num(r));
            }
            if let Some(c) = w.clip_mut(actor) {
                c.m.tx = e.lx;
                c.m.ty = e.ly;
            }
            if self.enemies[i].ly > 3000.0 {
                self.enemies[i].alive = false;
                if kind == EK::Iceball {
                    self.enemy_of_clip.remove(&actor);
                    w.remove(actor);
                }
            }
        }
    }

    /// SpiderWeb: a flying chaser homing in on the hero in eight directions.
    fn web_process(&mut self, w: &mut World, host: &mut LHost, i: usize, victim: (f32, f32)) {
        let actor = self.enemies[i].actor;
        self.save_states(Who::Enemy(i));
        // hitColBox: overlapping a massive obstacle pushes the spider back
        let b = self.enemies[i].box_rect();
        let mut stuck = false;
        for o in self.obstacles(w) {
            if w.get_var(o, "type").num() as i32 == O_MASSIVE && w.get_var(o, "type").num().is_finite() {
                let ob = self.bounds(w, o);
                if b.x0 <= ob.x1 && b.x1 >= ob.x0 && b.y0 <= ob.y1 && b.y1 >= ob.y0 {
                    stuck = true;
                    break;
                }
            }
        }
        let e = &mut self.enemies[i];
        if stuck {
            e.x = e.lx - (e.dir * 2) as f32;
            e.y = e.ly - (e.vdir * 2) as f32;
            e.changedir = 0;
            e.pause = 60;
        }
        if e.changedir > 0 {
            e.changedir -= 1;
        }
        if e.changedir == 0 {
            e.dir = if victim.0 > e.x + 5.0 { 1 } else if victim.0 < e.x - 5.0 { -1 } else { 0 };
            e.vdir = if victim.1 > e.y + 5.0 { 1 } else if victim.1 < e.y - 5.0 { -1 } else { 0 };
            let rot = match (e.vdir, e.dir) {
                (-1, 0) => 0.0,
                (-1, 1) => 45.0,
                (0, 1) => 90.0,
                (1, 1) => 135.0,
                (1, 0) => 180.0,
                (1, -1) => -135.0,
                (0, -1) => -90.0,
                (-1, -1) => -45.0,
                _ => 0.0,
            };
            let ct = w.path(actor, "container");
            w.set_var(ct, "_rotation", Value::Num(rot));
            e.changedir = 10;
        }
        let ct = w.path(actor, "container");
        if e.pause == 0 {
            e.vx = e.walkspeed * e.dir as f32;
            e.vy = e.walkspeed * e.vdir as f32;
            w.jump(ct, 2, false, host);
        } else {
            w.jump(ct, 1, false, host);
            e.pause -= 1;
            e.vx = 0.0;
            e.vy = 0.0;
        }
        self.position(Who::Enemy(i));
        let e = &self.enemies[i];
        if let Some(c) = w.clip_mut(actor) {
            c.m.tx = e.lx;
            c.m.ty = e.ly;
        }
    }

    fn throw_iceball(&mut self, w: &mut World, host: &mut LHost, i: usize) {
        let actor = self.enemies[i].actor;
        let (ax, ay) = (w.get_var(actor, "_x").num() as f32, w.get_var(actor, "_y").num() as f32);
        self.spawn_counter += 1;
        let depth = 6000 + (self.spawn_counter % 10);
        let name = format!("iceball{}", self.spawn_counter);
        let Some(c) = w.attach_from(self.base, self.base_lib, "iceball", &name, depth, host) else { return };
        if let Some(cl) = w.clip_mut(c) {
            cl.m.tx = ax - 35.0;
            cl.m.ty = ay - 8.0;
            cl.prev_m = cl.m;
        }
        self.spawn_enemy(c, "iceball", usize::MAX);
        let inits = std::mem::take(&mut host.inits);
        for k in inits {
            self.on_init(w, k);
        }
    }

    /// El Pix: a stationary boss driven by its timeline, throwing Pinkus from the ship.
    fn elpix_process(&mut self, w: &mut World, i: usize) {
        let actor = self.enemies[i].actor;
        self.save_states(Who::Enemy(i));
        let e = &mut self.enemies[i];
        e.mv = 1;
        if e.lockmove > 1 {
            e.lockmove -= 1;
            if e.lockmove == 1 {
                w.set_playing(actor, true);
            }
        }
        let ob = w.path(actor, "obstacle");
        let ct = w.path(actor, "container");
        if e.untouchable > 0 {
            w.set_var(ob, "type", Value::Num(-1.0));
            e.untouchable -= 1;
            let old = e.hide_cnt;
            e.hide_cnt -= 1;
            if old == 0 {
                let v = w.clip(ct).map(|c| c.visible).unwrap_or(true);
                w.set_var(ct, "_visible", Value::Bool(!v));
                e.hide_cnt = 2;
            }
            if e.untouchable == 0 {
                w.set_var(ct, "_visible", Value::Bool(true));
                e.hide_cnt = 2;
            }
        } else {
            w.set_var(ob, "type", Value::Num(30.0));
        }
        if let Some(c) = w.clip_mut(actor) {
            c.m.tx = e.lx;
            c.m.ty = e.ly;
        }
    }

    fn scroll_process(&mut self) {
        // Scroll.process: the layers take the follow position, clamped to the level limits
        let (mut x, mut y) = (self.scroll_x, self.scroll_y);
        if x < self.data.lx {
            x = self.data.lx;
        } else if x + SCREEN_W > self.data.width {
            x = self.data.width - SCREEN_W;
        }
        if y < self.data.ly {
            y = self.data.ly;
        } else if y + SCREEN_H > self.data.height {
            y = self.data.height - SCREEN_H;
        }
        self.cam_x = x;
        self.cam_y = y;
    }

    pub fn tick(&mut self, w: &mut World, host: &mut LHost, input: &Input) -> Outcome {
        self.tick_count += 1;
        w.latch();
        if !self.paused {
            // listener order of the original: tiles, game, scroll, hero, actors
            self.tiles_process(w, host);
            for (k, total, reset) in [("coinframe", 105.0, 1.0), ("waterframe", 43.0, 1.0), ("beeframe", 102.0, 2.0), ("cloudframe", 219.0, 2.0)] {
                let old = w.globals.get(k).map(|v| v.num()).unwrap_or(0.0);
                w.globals.insert(k.into(), Value::Num(if old < total { old + 1.0 } else { reset }));
            }
            self.scroll_process();
            let before = if self.noclip_check { Some(self.hero.box_rect()) } else { None };
            self.hero_process(w, host, input);
            if let Some(b0) = before {
                self.detect_noclip(w, b0);
            }
            if self.outcome != Outcome::Dead {
                self.enemies_process(w, host);
                self.movers_process(w);
            }
        }
        w.advance(host);
        let inits = std::mem::take(&mut host.inits);
        for c in inits {
            self.on_init(w, c);
        }
        if self.ticks_since_end > 0 {
            self.ticks_since_end += 1;
        }
        if host.finish {
            host.finish = false;
            self.curtain_done = true;
        }
        self.outcome
    }

    /// Dev check: the hero's box passed from above a solid top to below it without landing.
    fn detect_noclip(&mut self, w: &World, b0: Rect) {
        let b1 = self.hero.box_rect();
        if self.hero.on_ladder {
            return;
        }
        if self.hero.ly > 3000.0 && self.outcome == Outcome::Dead {
            println!("FELL t={} last box {:.1},{:.1}", self.tick_count, b0.x0, b0.y1);
        }
        for o in self.obstacles(w) {
            let ty = w.get_var(o, "type");
            if ty.is_undef() {
                continue;
            }
            let ty = ty.num() as i32;
            if !(ty == O_MASSIVE || ty == 1) || w.get_var(o, "noTop").truthy() || w.get_var(o, "enemy").truthy() {
                continue;
            }
            if ty == 1 && self.hero.vy < 0.0 {
                continue;
            }
            let ob = self.bounds(w, o);
            let overlap_x = b1.x1 - self.hero.pivot > ob.x0 && b1.x0 + self.hero.pivot < ob.x1;
            let embedded = overlap_x && b1.y1 > ob.y0 + 20.0 && b1.y0 < ob.y1 - 5.0 && (ob.y1 - ob.y0) > 25.0;
            if embedded || (overlap_x && b0.y1 <= ob.y0 + 0.5 && b1.y1 > ob.y0 + MAX_VEL + GRAVITY + TOLERANCE) {
                println!(
                    "NOCLIP t={} type={} ob=({:.1},{:.1},{:.1},{:.1}) box {:.1}->{:.1} hero=({:.1},{:.1}) vy={:.2} {}",
                    self.tick_count, ty, ob.x0, ob.y0, ob.x1, ob.y1, b0.y1, b1.y1, self.hero.x, self.hero.y, self.hero.vy,
                    w.clip(o).map(|c| w.clip(c.parent).map(|p| p.name.clone()).unwrap_or_default()).unwrap_or_default()
                );
            }
        }
    }

    /// One-line dump of the hero's physics state (dev tracing).
    pub fn debug_hero(&self) -> String {
        let c = &self.hero;
        format!(
            "x={:7.1} y={:7.1} vx={:6.2} vy={:6.2} ox={:5.1} oy={:6.1} ground={} mv={} jumps={} stage={} cnt={} r_up={} ladder={}/{}/{} box=({:.1},{:.1},{:.1},{:.1})",
            c.x, c.y, c.vx, c.vy, c.ox, c.oy, c.on_ground as u8, c.mv, c.jumps, c.jumpstage, c.jumpcnt, c.r_action_up as u8,
            c.on_ladder as u8, c.hit_ladder as u8, c.upon_ladder as u8,
            c.box_rect().x0, c.box_rect().y0, c.box_rect().x1, c.box_rect().y1
        )
    }

    pub fn hero_pos(&self) -> (f32, f32) {
        (self.hero.lx, self.hero.ly)
    }
    pub fn camera(&self) -> (f32, f32) {
        (self.cam_x, self.cam_y)
    }
    pub fn hero_energy(&self) -> i32 {
        self.hero.energy
    }
    pub fn goal_reached(&self) -> bool {
        self.finished_goal
    }
    pub fn start_curtain_close(&mut self, w: &mut World, host: &mut LHost, fast: bool) {
        w.jump_label(self.curtain, if fast { "close_fast" } else { "close" }, true, host);
        self.paused = true;
        let (base, hero) = (self.base, NONE);
        w.stop_subtree(base, hero);
    }
    pub fn hero_screen_x(&self, _w: &World) -> f32 {
        self.hero.x
    }

    /// Script calls aimed at the level (boss helpers).
    pub fn script_call(&mut self, w: &mut World, host: &mut LHost, from: ClipId, name: &str) {
        match name {
            "showEnergy" => {
                if let Some(h) = w.child_named(self.hud_energy, "boss_energy") {
                    w.set_var(h, "_visible", Value::Bool(true));
                    w.set_playing(h, true);
                }
            }
            "throwPinku" => {
                let Some(&e) = self.enemy_of_clip.get(&from) else { return };
                if self.enemies[e].kind != EK::ElPix {
                    return;
                }
                let pick = {
                    let n = self.enemies[e].pipeline.len().max(1) as u32;
                    self.rand(n) as usize
                };
                let link = if self.enemies[e].pipeline.is_empty() { "pinku" } else { self.enemies[e].pipeline.remove(pick) };
                let ship = w.path(from, "container.container.container");
                let (left_b, right_b) = (w.get_var(ship, "left_break").truthy(), w.get_var(ship, "right_break").truthy());
                let ct = w.path(from, "container");
                let (cx, cy) = (w.get_var(ct, "_x").num() as f32, w.get_var(ct, "_y").num() as f32);
                let (mut px, mut py) = (cx + 150.0 + 160.0, cy + 210.0);
                if !right_b && (cx > 0.0 || left_b) {
                    px = cx + 150.0 + 160.0;
                }
                if !left_b && cx < 0.0 {
                    px = cx + 180.0;
                }
                if left_b && right_b {
                    px = cx + 150.0 + 100.0;
                }
                py = py.max(cy + 210.0);
                self.spawn_counter += 1;
                let depth = 6000 + (self.spawn_counter % 10);
                let name = format!("pinku{}", self.spawn_counter);
                if let Some(c) = w.attach_from(self.base, self.base_lib, link, &name, depth, host) {
                    if let Some(cl) = w.clip_mut(c) {
                        cl.m.tx = px;
                        cl.m.ty = py;
                        cl.prev_m = cl.m;
                    }
                    if cx < 0.0 {
                        w.set_var(c, "dir", Value::Num(1.0));
                    }
                    w.set_var(c, "pause", Value::Num(20.0));
                    self.spawn_enemy(c, link, usize::MAX);
                    let inits = std::mem::take(&mut host.inits);
                    for k in inits {
                        self.on_init(w, k);
                    }
                }
                if self.enemies[e].pipeline.is_empty() {
                    self.enemies[e].pipeline = if !right_b { vec!["pinku", "orange", "purpu", "speedywood"] } else { vec!["beycnake", "scorpion", "spider_run", "beycnake"] };
                }
            }
            _ => {}
        }
    }

    pub fn rand_u32(&mut self, n: u32) -> u32 {
        self.rand(n)
    }
}
