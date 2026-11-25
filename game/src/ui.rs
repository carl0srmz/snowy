//! The application controller: a Rust port of the original `Control`, `Worldmap`, `Ticker`
//! and `SoundFile` classes. It owns the renderer, audio, display tree and save data.
use crate::assets::{self, GpuLib};
use crate::audio::{Audio, VoiceId};
use crate::gfx::{Renderer, TexId};
use crate::level::{self, LHost, Level, LevelData, Outcome, Sfx};
use crate::movie::*;
use crate::save::Save;
use crate::texts::*;
use anyhow::Result;
use snow_fmt::{btn_cond, Rect};
use std::collections::HashMap;
use std::path::{Path, PathBuf};
use std::rc::Rc;
use std::sync::Arc;

pub const STAGE_W: f32 = 900.0;
pub const STAGE_H: f32 = 578.0;
pub const TICK_HZ: f32 = 34.0;

pub type Handler = Rc<dyn Fn(&mut Ui)>;

#[derive(Clone, Copy, PartialEq, Eq, Hash, Debug)]
pub enum Evt {
    Press,
    Release,
    RollOver,
    RollOut,
}

/// name -> wav file for the sound exports of one converted sound library.
#[derive(Clone, Default)]
pub struct Bank {
    pub files: HashMap<String, PathBuf>,
}

pub fn load_bank(assets: &Path, lib: &str) -> Bank {
    let dir = assets.join(lib);
    let mut files = HashMap::new();
    if let Ok(l) = snow_fmt::Library::load(&dir.join("lib.bin")) {
        for (name, id) in &l.exports {
            if let Some(m) = l.sounds.iter().find(|m| m.id == *id) {
                files.insert(name.clone(), dir.join("sounds").join(&m.file));
            }
        }
    }
    Bank { files }
}

#[derive(Default, Clone)]
pub struct GameOver {
    pub door: i32,
    pub goal: bool,
    pub bonus: bool,
    pub container: bool,
}

pub struct GameSession {
    pub level: Level,
    pub number: u32,
    pub gameover_ticks: i32,
    pub finish_ticks: i32,
    pub closing: Option<bool>,
    pub player: Bank,
    pub effects: Bank,
    pub music: Bank,
    pub music_voice: Option<VoiceId>,
    pub start_voice: Option<VoiceId>,
    pub steps_voice: Option<VoiceId>,
    pub screen: ClipId,
}

pub struct Ticker {
    pub id: u32,
    text: Vec<char>,
    target: ClipId,
    pub pos: usize,
    pub voice: Option<VoiceId>,
    pub vol: f32,
    done: Option<Handler>,
    pub started: bool,
}

pub struct Ui {
    pub rd: Renderer,
    pub audio: Audio,
    pub world: World,
    pub host: LHost,
    pub libs: HashMap<String, Arc<GpuLib>>,
    pub assets: PathBuf,
    pub paths: Paths,
    pub save: Save,
    pub debug: bool,
    pub quit: bool,
    pub layer_main: ClipId,
    pub layer_intro: ClipId,
    pub layer_pre: ClipId,
    pub main: ClipId,
    pub handlers: HashMap<(ClipId, Evt), Handler>,
    pub hover: ClipId,
    pub pressed: ClipId,
    pub mouse: (f32, f32),
    pub wm: XmlValues,
    pub help: XmlValues,
    pub gamelevel: XmlValues,
    pub content: XmlValues,
    pub gameinfo: XmlValues,
    pub topic: String,
    pub last_topic: String,
    pub game: Option<GameSession>,
    pub over: GameOver,
    pub game_reset: bool,
    pub timers: Vec<(u64, Handler)>,
    pub tickers: Vec<Ticker>,
    next_ticker: u32,
    pub tick_no: u64,
    pub lounge: Bank,
    pub effects_bank: Bank,
    pub lounge_voice: Option<VoiceId>,
    pub lounge_vol: f32,
    pub credits_voice: Option<VoiceId>,
    pub credits_vol: f32,
    pub musicvol: f32,
    pub last_game: i32,
    pub schwabbel_ticker: Option<u32>,
    pub lab: Option<crate::lab::Lab>,
    pub intro_state: crate::intro::IntroState,
    pub credits_loaded: bool,
    pub cursor_hand: bool,
    pub key_events: Vec<String>,
    pub objs: HashMap<(ClipId, String), crate::scripts::ScriptObj>,
    pub waits: Vec<crate::scripts::Wait>,
    pub followers: Vec<(ClipId, u8)>,
    pub rng: u32,
    pub last_download: Option<PathBuf>,
}

impl Ui {
    pub fn new(rd: Renderer, audio: Audio, assets: PathBuf, repo: PathBuf, lang: Lang, debug: bool) -> Result<Ui> {
        let mut ui = Ui {
            rd,
            audio,
            world: World::new(),
            host: LHost::default(),
            libs: HashMap::new(),
            paths: Paths { repo, lang },
            save: Save::load(),
            debug,
            quit: false,
            layer_main: NONE,
            layer_intro: NONE,
            layer_pre: NONE,
            main: NONE,
            handlers: HashMap::new(),
            hover: NONE,
            pressed: NONE,
            mouse: (-1.0, -1.0),
            wm: XmlValues::default(),
            help: XmlValues::default(),
            gamelevel: XmlValues::default(),
            content: XmlValues::default(),
            gameinfo: XmlValues::default(),
            topic: "worldmap".into(),
            last_topic: "worldmap".into(),
            game: None,
            over: GameOver::default(),
            game_reset: true,
            timers: Vec::new(),
            tickers: Vec::new(),
            next_ticker: 1,
            tick_no: 0,
            lounge: Bank::default(),
            effects_bank: Bank::default(),
            lounge_voice: None,
            lounge_vol: 0.0,
            credits_voice: None,
            credits_vol: 0.0,
            musicvol: 100.0,
            last_game: -1,
            schwabbel_ticker: None,
            lab: None,
            intro_state: Default::default(),
            credits_loaded: false,
            cursor_hand: false,
            key_events: Vec::new(),
            objs: HashMap::new(),
            waits: Vec::new(),
            followers: Vec::new(),
            rng: 0x2545_f491,
            last_download: None,
            assets,
        };
        ui.boot()?;
        Ok(ui)
    }

    pub fn lib(&mut self, name: &str) -> Result<Arc<GpuLib>> {
        if let Some(l) = self.libs.get(name) {
            return Ok(l.clone());
        }
        let mut v = assets::load_libraries(&mut self.rd, &self.assets, &[name], 0)?;
        let l = Arc::new(v.remove(0));
        self.libs.insert(name.to_string(), l.clone());
        Ok(l)
    }

    /// Loads a library into the world and returns its index there.
    pub fn world_lib(&mut self, name: &str) -> Result<u32> {
        let l = self.lib(name)?;
        if let Some(i) = self.world.libs.iter().position(|x| Arc::ptr_eq(x, &l)) {
            return Ok(i as u32);
        }
        Ok(self.world.add_lib_arc(l))
    }

    /// Loads a movie into an (empty) clip, like `loadMovie`.
    pub fn load_movie(&mut self, clip: ClipId, lib: &str) -> Result<()> {
        let id = self.world_lib(lib)?;
        self.world.load_into(clip, id);
        self.world.start_movie(clip, &mut self.host);
        Ok(())
    }

    // ------------------------------------------------------------------ boot

    fn boot(&mut self) -> Result<()> {
        let root = self.world.root;
        self.layer_main = self.world.create_empty(root, "layer_3", 3);
        self.layer_intro = self.world.create_empty(root, "layer_4", 4);
        self.layer_pre = self.world.create_empty(root, "layer_5", 5);
        self.load_movie(self.layer_pre, "data/preloader")?;
        self.load_movie(self.layer_main, "data/worldmap")?;
        self.main = self.layer_main;
        self.wm = self.paths.text("mainmap.xml");
        self.help = self.paths.text("help.xml");
        self.gamelevel = self.paths.text("gamelevel.xml");
        self.content = XmlValues::load(&self.paths.data().join("content.xml"));
        self.lounge = load_bank(&self.assets, "data/sounds/lounge");
        self.effects_bank = load_bank(&self.assets, "data/sounds/worldmap");
        self.musicvol = 100.0;
        let first_visit = !self.save.intro;
        self.init_worldmap();
        // Control.start
        self.world.set_playing(self.layer_pre, true);
        if first_visit {
            self.show_intro_screen()?;
        } else {
            self.start_worldmap();
        }
        Ok(())
    }

    pub fn start_worldmap(&mut self) {
        self.audio.stop_all();
        self.lounge_voice = None;
        self.credits_voice = None;
        self.intro_state = Default::default();
        let li = self.layer_intro;
        self.world.clear_children(li);
        if let Some(c) = self.world.clip_mut(li) {
            c.kind = Kind::Sprite;
            c.cid = ROOT_CID - 1;
        }
        let wmap = self.world.path(self.main, "worldmap");
        if let Some(c) = self.world.clip_mut(wmap) {
            c.visible = true;
        }
        self.lounge_start(true);
    }

    // ----------------------------------------------------------------- sound

    pub fn play_named(&mut self, bank: &Bank, name: &str, loops: u32, vol: f32) -> Option<VoiceId> {
        let path = bank.files.get(name)?.clone();
        let pcm = self.audio.load(&path).ok()?;
        Some(self.audio.play(&pcm, 0.0, loops, vol * self.audio.master))
    }

    pub fn sfx_world(&mut self, name: &str, vol: f32) {
        let b = self.effects_bank.clone();
        self.play_named(&b, name, 1, vol);
    }

    /// SoundFile.fadeTo: +-1 volume point per frame.
    fn fade_secs(from: f32, to: f32) -> f32 {
        ((to - from).abs() / TICK_HZ).max(0.03)
    }

    pub fn lounge_start(&mut self, fade_in: bool) {
        if self.lounge_voice.map(|v| self.audio.is_playing(v)).unwrap_or(false) {
            self.lounge_fade_to(100.0);
            return;
        }
        let b = self.lounge.clone();
        // s_lounge.fadeIn() = SoundFile.fade(1): restart at 0, +2 volume per frame up to the
        // sound's volume (100 when it was 0)
        let end = if self.lounge_vol <= 0.0 { 100.0 } else { self.lounge_vol };
        self.lounge_voice = self.play_named(&b, "track", 999, if fade_in { 0.0 } else { end / 100.0 });
        if fade_in {
            if let Some(v) = self.lounge_voice {
                self.audio.fade_to(v, end / 100.0, (end / 2.0) / TICK_HZ, false);
            }
        }
        self.lounge_vol = end;
    }

    pub fn lounge_fade_to(&mut self, vol: f32) {
        if let Some(v) = self.lounge_voice {
            self.audio.fade_to(v, vol / 100.0, Self::fade_secs(self.lounge_vol, vol), false);
        }
        self.lounge_vol = vol;
    }

    pub fn credits_fade_to(&mut self, vol: f32) {
        if let Some(v) = self.credits_voice {
            self.audio.fade_to(v, vol / 100.0, Self::fade_secs(self.credits_vol, vol), vol <= 0.0);
        }
        self.credits_vol = vol;
    }

    // ---------------------------------------------------------------- helpers

    pub fn clip(&self, path: &str) -> ClipId {
        self.world.path(self.main, path)
    }

    pub fn set_visible(&mut self, path: &str, v: bool) {
        let c = self.clip(path);
        if let Some(c) = self.world.clip_mut(c) {
            c.visible = v;
        }
    }

    pub fn set_text_at(&mut self, id: ClipId, text: &str, ls: Option<f32>) {
        if let Some(t) = self.world.text_field_mut(id) {
            t.set_text(text);
            if let Some(l) = ls {
                t.set_letter_spacing(l);
            }
        }
    }

    pub fn set_html_at(&mut self, id: ClipId, html: &str, ls: Option<f32>) {
        if let Some(t) = self.world.text_field_mut(id) {
            if let Some(l) = ls {
                t.letter_spacing = Some(l);
            }
            t.set_html(html);
        }
    }

    pub fn set_text(&mut self, path: &str, text: &str, ls: Option<f32>) {
        let c = self.clip(path);
        self.set_text_at(c, text, ls);
    }

    pub fn set_html(&mut self, path: &str, html: &str, ls: Option<f32>) {
        let c = self.clip(path);
        self.set_html_at(c, html, ls);
    }

    pub fn goto_label(&mut self, path: &str, label: &str, play: bool) {
        let c = self.clip(path);
        self.world.jump_label(c, label, play, &mut self.host);
    }

    pub fn goto_frame(&mut self, path: &str, frame: u16, play: bool) {
        let c = self.clip(path);
        self.world.jump(c, frame, play, &mut self.host);
    }

    /// `clip.onPress = ...` and friends.
    pub fn on(&mut self, path: &str, evt: Evt, f: impl Fn(&mut Ui) + 'static) {
        let c = self.clip(path);
        self.on_clip(c, evt, f);
    }

    pub fn on_clip(&mut self, c: ClipId, evt: Evt, f: impl Fn(&mut Ui) + 'static) {
        if c == NONE {
            return;
        }
        if let Some(cl) = self.world.clip_mut(c) {
            if matches!(cl.kind, Kind::Sprite) {
                cl.interactive = true;
            }
        }
        self.handlers.insert((c, evt), Rc::new(f));
    }

    pub fn clear_handlers(&mut self, c: ClipId) {
        self.handlers.retain(|k, _| k.0 != c);
    }

    pub fn after(&mut self, ticks: u64, f: impl Fn(&mut Ui) + 'static) {
        self.timers.push((self.tick_no + ticks, Rc::new(f)));
    }

    // ------------------------------------------------------------ worldmap

    fn init_worldmap(&mut self) {
        let ls = Some(0.5);
        let wm = self.wm.clone();
        self.set_text("worldmap.lab_txt", &wm.text("mainmap_buttons_03_labor"), ls);
        self.set_text("worldmap.help_txt", &wm.text("mainmap_buttons_02_help"), ls);
        self.set_text("worldmap.intro_txt", &wm.text("mainmap_buttons_01_intro"), ls);
        self.set_text("worldmap.feedback_txt", &wm.text("mainmap_buttons_04_feedback"), ls);
        self.set_text("worldmap.credits_txt", &wm.text("mainmap_buttons_06_credits"), ls);
        self.set_text("credits.credits_txt", &wm.text("mainmap_buttons_06_credits"), None);
        self.set_html("worldmap.hinweis_txt", &wm.text("mainmap_info_01_date"), None);
        self.set_text("copyright_txt", &wm.text("mainmap_footer_02_copyright"), ls);
        self.set_text("impressum_txt", &wm.text("mainmap_footer_01_impressum"), Some(1.0));
        self.set_text("impressum.title_txt", &wm.text("mainmap_footer_01_impressum"), ls);
        let imp = XmlValues::load(&self.paths.data().join("text").join(self.paths.lang.folder()).join("impressum.xml")).text("impressum");
        self.set_html("impressum.impressum_txt", &imp.replace("\r\n", "\r"), None);
        self.set_text("help.help_txt", &wm.text("mainmap_buttons_02_help"), ls);
        let h = self.help.clone();
        self.set_html("help.story.story_txt", &h.text("help_story_02_copy1"), None);
        let story = self.clip("help.story");
        if let Some(c) = self.world.clip_mut(story) {
            c.vars.insert("story1".into(), Value::Str(h.text("help_story_02_copy1")));
            c.vars.insert("story2".into(), Value::Str(h.text("help_story_03_copy2")));
        }
        self.set_html("help.kristall_txt", &h.text("help_legende_02_kristall"), None);
        self.set_html("help.tuer_txt", &h.text("help_legende_03_tuer"), None);
        self.set_html("help.tueroffen_txt", &h.text("help_legende_05_tueroffen"), None);
        self.set_html("help.tuerkristall_txt", &h.text("help_legende_04_tuerkristall"), None);
        self.set_html("help.labor_txt", &h.text("help_legende_06_labor"), None);
        let hint = format!("{}<br />{}", h.text("help_anzeige_01_headline"), h.text("help_anzeige_02_copy"));
        self.set_html("help.hinweis_txt", &hint, None);
        self.init_feedback();
        self.init_buttons();
        self.upixo_visited();
        self.set_visible("worldmap", true);
        self.set_date();
        self.prepare_doors();
        if !self.debug {
            self.set_visible("cookie_button", false);
        }
    }

    fn upixo_visited(&mut self) {
        self.save.visited();
    }

    fn set_date(&mut self) {
        let secs = std::time::SystemTime::now().duration_since(std::time::UNIX_EPOCH).map(|d| d.as_secs() as i64).unwrap_or(0);
        let z = secs.div_euclid(86400) + 719468;
        let era = z.div_euclid(146097);
        let doe = z.rem_euclid(146097);
        let yoe = (doe - doe / 1460 + doe / 36524 - doe / 146096) / 365;
        let y = yoe + era * 400;
        let doy = doe - (365 * yoe + yoe / 4 - yoe / 100);
        let mp = (5 * doy + 2) / 153;
        let d = doy - (153 * mp + 2) / 5 + 1;
        let m = if mp < 10 { mp + 3 } else { mp - 9 };
        let y = if m <= 2 { y + 1 } else { y };
        self.set_text("worldmap.date_txt", &format!("{:02}.{:02}.{}", d, m, y), Some(0.5));
    }

    fn init_buttons(&mut self) {
        self.on("worldmap.lab_bt", Evt::Press, |u| u.show_topic(Some("lab"), 0));
        self.on("worldmap.help_bt", Evt::Press, |u| u.show_topic(Some("help"), 0));
        self.on("worldmap.intro_bt", Evt::Press, |u| u.intro_button());
        self.on("worldmap.feedback_bt", Evt::Press, |u| u.show_topic(Some("feedback"), 0));
        self.on("worldmap.credits_bt", Evt::Press, |u| u.load_credits());
        self.on("impressum_bt", Evt::Press, |u| u.show_impressum(true));
        self.on("credits.close_bt", Evt::Press, |u| u.show_topic(Some("worldmap"), 0));
        self.on("game.close_bt", Evt::Press, |u| u.show_topic(Some("worldmap"), 0));
        self.on("game.report.lab_bt", Evt::Press, |u| u.show_topic(Some("lab"), 0));
        self.on("game.report.worldmap_bt", Evt::Press, |u| u.show_topic(Some("worldmap"), 0));
        self.on("help.close_bt", Evt::Press, |u| u.show_topic(Some("worldmap"), 0));
        self.on("feedback.close_bt", Evt::Press, |u| u.show_topic(Some("worldmap"), 0));
        self.on("impressum.close_bt", Evt::Press, |u| u.show_impressum(false));
        self.on("impressum.close1_bt", Evt::Press, |u| u.show_impressum(false));
        self.on("cookie_button", Evt::Press, |u| {
            u.save.test_unlock(23, true);
            u.prepare_doors();
        });
        self.on("game.sound_switch.instance494", Evt::Press, |u| {
            // the sound switch toggles music volume between 100 and 25
            let on = u.musicvol > 50.0;
            u.musicvol = if on { 25.0 } else { 100.0 };
            let sw = u.clip("game.sound_switch");
            u.world.jump(sw, if on { 2 } else { 1 }, false, &mut LHost::default());
            u.apply_music_volume();
        });
    }

    fn apply_music_volume(&mut self) {
        let v = self.musicvol / 100.0;
        if let Some(g) = &self.game {
            for id in [g.music_voice, g.start_voice].into_iter().flatten() {
                self.audio.set_volume(id, v);
            }
        }
    }

    pub fn prepare_doors(&mut self) {
        let day = 24usize;
        let ready = self.save.ready_for_elpix();
        for n in 1..=25usize {
            let door = self.clip(&format!("worldmap.tuer_{}", n));
            if door == NONE {
                continue;
            }
            let button = self.world.path(door, "button");
            self.clear_handlers(button);
            if let Some(c) = self.world.clip_mut(door) {
                c.visible = true;
                c.vars.insert("level".into(), Value::Str(format!("level_{}", n)));
                c.vars.insert("num".into(), Value::Num(n as f64));
            }
            self.world.jump(door, n as u16, false, &mut self.host);
            let bg = self.world.path(door, "bg");
            let black = self.world.path(door, "black");
            let crystal = self.world.path(door, "crystal");
            self.world.set_var(bg, "_visible", Value::Bool(false));
            let door_state = self.save.doors[n - 1];
            if door_state.is_none() {
                self.world.set_var(crystal, "_visible", Value::Bool(false));
            }
            if n <= day || (n == 25 && ready) {
                let tuer = self.world.path(door, "tuer");
                if let Some(bonus) = door_state {
                    self.world.set_var(bg, "_visible", Value::Bool(true));
                    self.world.set_var(black, "_visible", Value::Bool(false));
                    self.world.set_var(crystal, "_visible", Value::Bool(true));
                    if bonus {
                        self.world.jump(crystal, 2, false, &mut self.host);
                    }
                } else {
                    self.on_clip(button, Evt::RollOver, move |u| {
                        let t = u.world.path(door, "tuer");
                        u.world.jump_label(t, "open", true, &mut LHost::default());
                    });
                    self.on_clip(button, Evt::RollOut, move |u| {
                        let t = u.world.path(door, "tuer");
                        u.world.jump_label(t, "close", true, &mut LHost::default());
                    });
                }
                let _ = tuer;
                self.on_clip(button, Evt::Press, move |u| {
                    u.sfx_world("over", 0.3);
                    u.show_topic(Some("game"), n as u32);
                    let t = u.world.path(door, "tuer");
                    u.world.jump_label(t, "close", true, &mut LHost::default());
                });
            }
        }
        if !ready {
            self.set_visible("worldmap.tuer_25", false);
        }
        self.set_visible("worldmap.credits_bt", true);
        self.set_visible("worldmap.credits_txt", true);
    }

    pub fn show_impressum(&mut self, show: bool) {
        self.set_visible("impressum", show);
    }

    pub fn intro_button(&mut self) {
        self.lounge_fade_to(0.0);
        self.set_visible("worldmap", false);
        self.save.show_intro_again();
        let _ = self.show_intro_screen();
    }

    // -------------------------------------------------------------- topics

    pub fn show_topic(&mut self, newtopic: Option<&str>, num: u32) {
        self.stop_all_tickers();
        let sch = self.clip("game.report.schwabbel");
        if let Some(c) = self.world.clip_mut(sch) {
            c.vars.remove("speech");
            c.vars.remove("speech2");
        }
        let art = self.clip("game.artwork");
        self.clear_image_clip(art);
        self.credits_fade_to(0.0);
        let newtopic = newtopic.map(|s| s.to_string()).unwrap_or_else(|| self.last_topic.clone());
        if self.topic == "game" && !self.game_reset {
            self.reset_game();
        }
        if newtopic == "worldmap" {
            self.lounge_fade_to(100.0);
        }
        if newtopic == "lab" {
            self.load_lab();
        } else {
            self.last_topic = self.topic.clone();
            let cur = self.topic.clone();
            self.set_visible(&cur, false);
            self.topic = newtopic.clone();
            self.set_visible(&newtopic, true);
        }
        if newtopic == "game" {
            self.load_game(num, false);
        } else if newtopic == "feedback" {
            self.init_feedback();
        }
    }

    /// The preloader overlay fades in/out around loads.
    pub fn preloader_fade(&mut self, fade_in: bool) {
        let p = self.clip("preloader");
        self.world.set_var(p, "_visible", Value::Bool(true));
        self.world.jump_label(p, if fade_in { "fadein" } else { "fadeout" }, true, &mut self.host);
    }

    pub fn clear_image_clip(&mut self, c: ClipId) {
        if let Some(t) = self.world.clear_image(c) {
            self.rd.destroy_texture(t);
        }
    }

    pub fn load_image_into(&mut self, clip: ClipId, path: &Path) -> bool {
        match image::open(path) {
            Ok(img) => {
                let img = img.to_rgba8();
                let tex = self.rd.create_texture(img.width(), img.height(), img.as_raw());
                if let Some(old) = self.world.set_image(clip, tex, img.width(), img.height()) {
                    self.rd.destroy_texture(old);
                }
                true
            }
            Err(e) => {
                log::warn!("image {}: {e}", path.display());
                false
            }
        }
    }

    // ---------------------------------------------------------------- game

    pub fn load_game(&mut self, level: u32, restart: bool) {
        self.lounge_fade_to(0.0);
        let report = self.clip("game.report");
        self.world.set_var(report, "_visible", Value::Bool(false));
        let name = self.content.text(&level.to_string());
        let art_path = self.paths.media().join(&name).join(format!("{}.jpg", name));
        let world_png = match level {
            1..=6 => "world_lake.png",
            7..=12 => "world_forest.png",
            13..=18 => "world_mountains.png",
            _ => "world_cave.png",
        };
        self.preloader_fade(true);
        if !restart {
            self.gameinfo = self.paths.text(&format!("{}.xml", name));
            let art = self.clip("game.artwork");
            self.load_image_into(art, &art_path);
            let bild = self.clip("game.bildchen");
            let p = self.paths.data().join("levels").join(world_png);
            self.load_image_into(bild, &p);
        }
        self.after(6, move |u| u.initialize_game(level));
    }

    fn initialize_game(&mut self, level: u32) {
        self.preloader_fade(false);
        self.game_reset = false;
        let door = level as i32 - 1;
        self.over = GameOver { door, goal: false, bonus: false, container: false };
        let n = level as usize;
        let ln = format!("LEVEL {:02}", level);
        self.set_text("game.level_txt", &ln, None);
        let navi = self.gameinfo.text("navi").replace("<br />", " ");
        self.set_text("game.game_txt", &navi, Some(0.5));
        let tipp = self.gamelevel.text("gamelevel_tipp_01");
        self.set_html("game.tipp_txt", &tipp, Some(0.7));
        let wm = self.wm.clone();
        self.set_html("game.report.lab_txt", &wm.text("mainmap_buttons_03_labor"), None);
        self.set_text("game.report.worldmap_txt", &wm.text("mainmap_buttons_05_mainmap"), None);
        let _ = n;
        if let Err(e) = self.start_level(level) {
            log::error!("cannot start level {level}: {e:#}");
            self.show_topic(Some("worldmap"), 0);
        }
    }

    fn start_level(&mut self, n: u32) -> Result<()> {
        let xml = std::fs::read_to_string(self.paths.data().join(format!("levels/level_{}.xml", n)))?;
        let data = LevelData::parse(&xml)?;
        let src = data.layer_source.trim_end_matches(".swf").to_string();
        let gamebase = self.world_lib("data/gamebase")?;
        let lvl = self.world_lib(&format!("data/levels/{}", src))?;
        let bg = self.world_lib(&format!("data/levels/backgrounds/{}", data.background))?;
        let container = self.clip("game.container");
        self.world.clear_children(container);
        self.world.set_mask(container, Some(Rect { x0: 0.0, y0: 0.0, x1: 480.0, y1: 360.0 }));
        let screen = self.world.create_empty(container, "gamestart", 1);
        self.world.load_into(screen, gamebase);
        self.world.start_movie(screen, &mut self.host);
        let music_name = data.music.clone();
        let effects_name = data.effects.clone();
        let world_no = ((n.max(1) - 1) / 6 + 1).min(4);
        let level_complete = self.save.doors.get(n as usize - 1).copied().flatten().is_some();
        let mut lv = Level::new(&mut self.world, screen, lvl, Some(bg), data, &mut self.host, self.save.container, world_no, level_complete)?;
        lv.complete_576 = self.save.complete_576(Some(n as usize - 1));
        let sounds_xml = XmlValues::load(&self.paths.data().join("sounds/sounds.xml"));
        let music_swf = sounds_xml.text(&music_name);
        let music = load_bank(&self.assets, &format!("data/sounds/{}", music_swf.trim_end_matches(".swf")));
        let player = load_bank(&self.assets, "data/sounds/player");
        let effects = load_bank(&self.assets, &format!("data/sounds/{}", effects_name));
        self.game = Some(GameSession {
            level: lv,
            number: n,
            gameover_ticks: 0,
            finish_ticks: 0,
            closing: None,
            player,
            effects,
            music,
            music_voice: None,
            start_voice: None,
            steps_voice: None,
            screen,
        });
        Ok(())
    }

    pub fn reset_game(&mut self) {
        if let Some(g) = self.game.take() {
            for id in [g.music_voice, g.start_voice, g.steps_voice].into_iter().flatten() {
                self.audio.stop(id);
            }
        }
        let container = self.clip("game.container");
        self.world.clear_children(container);
        self.game_reset = true;
    }

    /// gameOver.cancel
    fn restart_game(&mut self, level: u32) {
        self.reset_game();
        self.load_game(level, true);
    }

    /// gameOver.finish when the door was already completed.
    fn replay_game(&mut self) {
        self.save_cookie();
        self.reset_game();
        self.show_topic(Some("worldmap"), 0);
        self.prepare_doors();
    }

    fn save_cookie(&mut self) {
        if self.over.door >= 0 {
            self.save.played(self.over.door as usize, self.over.bonus, self.over.container);
        }
    }

    /// gameOver.finish when the door was completed for the first time.
    fn close_game(&mut self) {
        let door = self.over.door;
        if door != 24 {
            self.lounge_fade_to(100.0);
            let title = self.gameinfo.text("title");
            let text = self.gamelevel.text("gamelevel_finished_01_headline").replace("<games_name>", &title);
            let target = self.clip("game.report.schwabbel.report_txt");
            self.set_html_at(target, "", None);
            let report = self.clip("game.report");
            self.world.set_var(report, "_visible", Value::Bool(true));
            let t = self.start_ticker(&text, target, 1.0, Some(Rc::new(|u: &mut Ui| u.stop_schwabbel())));
            self.schwabbel_ticker = Some(t);
            let sch = self.clip("game.report.schwabbel");
            self.world.jump_label(sch, "start", true, &mut LHost::default());
        }
        self.last_game = door;
        if self.over.goal {
            self.save_cookie();
        }
        let ready = self.save.ready_for_elpix();
        let sch = self.clip("game.report.schwabbel");
        if ready {
            let t = self.gamelevel.text("gamelevel_24finished_01_elpix");
            if let Some(c) = self.world.clip_mut(sch) {
                c.vars.insert("speech2".into(), Value::Str(t));
            }
        }
        self.set_visible("worldmap", false);
        self.reset_game_keep_ui();
        if door == 24 {
            self.load_credits();
        }
        self.prepare_doors();
    }

    fn reset_game_keep_ui(&mut self) {
        self.reset_game();
        self.game_reset = true;
    }

    fn stop_schwabbel(&mut self) {
        let s = self.clip("game.report.schwabbel.schwabbel");
        self.world.jump(s, 1, false, &mut LHost::default());
    }

    // -------------------------------------------------------------- tickers

    pub fn start_ticker(&mut self, text: &str, target: ClipId, vol: f32, done: Option<Handler>) -> u32 {
        self.make_ticker(text, target, vol, done, true)
    }

    pub fn make_ticker(&mut self, text: &str, target: ClipId, vol: f32, done: Option<Handler>, start: bool) -> u32 {
        let text: String = text.replace("<BR />", "\n").replace("<br />", "\n");
        let id = self.next_ticker;
        self.next_ticker += 1;
        self.tickers.push(Ticker { id, text: text.chars().collect(), target, pos: 0, voice: None, vol, done, started: false });
        if start {
            self.ticker_begin(id);
        }
        id
    }

    pub fn stop_ticker(&mut self, id: u32) {
        if let Some(i) = self.tickers.iter().position(|t| t.id == id) {
            let t = self.tickers.remove(i);
            if let Some(v) = t.voice {
                self.audio.stop(v);
            }
        }
    }

    pub fn stop_all_tickers(&mut self) {
        for t in std::mem::take(&mut self.tickers) {
            if let Some(v) = t.voice {
                self.audio.stop(v);
            }
        }
    }

    fn step_tickers(&mut self) {
        let mut finished: Vec<(u32, Option<Handler>)> = Vec::new();
        for i in 0..self.tickers.len() {
            if !self.tickers[i].started {
                continue;
            }
            // utils.Ticker.process: c = text.charAt(pointer++); "\\" skips two; done when pointer == length
            let (target, ch, done_now) = {
                let t = &mut self.tickers[i];
                let old = t.pos;
                t.pos += 1;
                let mut ch = t.text.get(old).copied();
                if ch == Some('\\') {
                    t.pos += 2;
                    ch = t.text.get(t.pos).copied();
                }
                (t.target, ch, t.pos == t.text.len())
            };
            if let Some(v) = self.tickers[i].voice {
                let vol = if ch == Some(' ') { 0.0 } else { self.tickers[i].vol };
                self.audio.set_volume(v, vol);
            }
            if let Some(c) = ch {
                let mut s = String::new();
                if let Some(t) = self.world.text_field(target) {
                    s = t.text();
                }
                s.push(c);
                self.set_text_at(target, &s, None);
            }
            if done_now {
                let t = &mut self.tickers[i];
                finished.push((t.id, t.done.take()));
            }
        }
        for (id, cb) in finished {
            self.stop_ticker(id);
            if let Some(cb) = cb {
                cb(self);
            }
        }
    }

    // --------------------------------------------------------------- input

    pub fn mouse_moved(&mut self, x: f32, y: f32) {
        self.mouse = (x, y);
        let root = self.world.root;
        let new = self.world.pick(root, (x, y)).unwrap_or(NONE);
        if new != self.hover {
            let old = self.hover;
            self.hover = new;
            if old != NONE && self.world.alive(old) {
                self.world.set_button_state(old, BtnState::Up);
                self.world.button_actions(old, btn_cond::OVER_UP_TO_IDLE, &mut self.host);
                self.fire(old, Evt::RollOut);
            }
            if new != NONE {
                let st = if self.pressed == new { BtnState::Down } else { BtnState::Over };
                self.world.set_button_state(new, st);
                self.world.button_actions(new, btn_cond::IDLE_TO_OVER_UP, &mut self.host);
                self.fire(new, Evt::RollOver);
            }
        }
        self.cursor_hand = self.hover != NONE && (self.handlers.keys().any(|k| k.0 == self.hover) || self.world.clip(self.hover).map(|c| matches!(c.kind, Kind::Button { .. })).unwrap_or(false));
    }

    pub fn mouse_pressed(&mut self) {
        self.mouse_moved(self.mouse.0, self.mouse.1);
        let h = self.hover;
        if h != NONE {
            self.pressed = h;
            self.world.set_button_state(h, BtnState::Down);
            self.world.button_actions(h, btn_cond::OVER_UP_TO_OVER_DOWN, &mut self.host);
            self.fire(h, Evt::Press);
        }
    }

    pub fn mouse_released(&mut self) {
        let p = self.pressed;
        self.pressed = NONE;
        if p != NONE && self.world.alive(p) {
            if self.hover == p {
                self.world.set_button_state(p, BtnState::Over);
                self.world.button_actions(p, btn_cond::OVER_DOWN_TO_OVER_UP, &mut self.host);
                self.fire(p, Evt::Release);
            } else {
                self.world.set_button_state(p, BtnState::Up);
            }
        }
    }

    pub fn wheel(&mut self, dy: i32) {
        // scrollable text fields (impressum, long info texts)
        let imp = self.clip("impressum.impressum_txt");
        let visible = self.world.clip(self.clip("impressum")).map(|c| c.visible).unwrap_or(false);
        if visible {
            let max = self.world.text_field(imp).map(|t| t.max_scroll(&self.world)).unwrap_or(1);
            if let Some(t) = self.world.text_field_mut(imp) {
                let s = (t.scroll as i32 - dy * 3).clamp(1, max as i32);
                t.scroll = s as u32;
                t.invalidate();
            }
        }
        self.lab_wheel(dy);
    }

    fn fire(&mut self, c: ClipId, e: Evt) {
        // a movie clip with a handler captures the mouse for its whole area (including child buttons)
        let mut cur = c;
        while cur != NONE {
            if let Some(h) = self.handlers.get(&(cur, e)).cloned() {
                h(self);
                return;
            }
            cur = match self.world.clip(cur) {
                Some(cl) => {
                    if cur != c && !cl.interactive {
                        cl.parent
                    } else if cur == c {
                        cl.parent
                    } else {
                        cl.parent
                    }
                }
                None => NONE,
            };
            if let Some(cl) = self.world.clip(cur) {
                if !cl.interactive {
                    // only interactive movie clips capture events from their children
                    let mut up = cl.parent;
                    while up != NONE && !self.world.clip(up).map(|u| u.interactive).unwrap_or(false) {
                        up = self.world.clip(up).map(|u| u.parent).unwrap_or(NONE);
                    }
                    cur = up;
                }
            }
        }
    }

    // ---------------------------------------------------------------- tick

    pub fn tick(&mut self, input: &level::Input) {
        self.tick_no += 1;
        // timers
        let now = self.tick_no;
        let due: Vec<Handler> = {
            let mut d = Vec::new();
            self.timers.retain(|(t, h)| {
                if *t <= now {
                    d.push(h.clone());
                    false
                } else {
                    true
                }
            });
            d
        };
        for h in due {
            h(self);
        }
        if let Some(g) = self.game.as_mut() {
            g.level.tick(&mut self.world, &mut self.host, input);
        } else {
            self.world.latch();
            self.world.advance(&mut self.host);
        }
        self.host.inits.clear();
        self.host.finish = false;
        self.step_tickers();
        self.dispatch();
        self.game_flow();
        self.drain_sound_events();
        self.step_audio_events();
        self.lab_tick();
        self.intro_tick();
    }

    fn game_flow(&mut self) {
        let Some(g) = self.game.as_mut() else { return };
        let sfx = std::mem::take(&mut g.level.sfx);
        let (outcome, goal) = (g.level.outcome, g.level.goal_reached());
        for fx in sfx {
            self.handle_sfx(fx);
        }
        let Some(g) = self.game.as_mut() else { return };
        if outcome == Outcome::Dead && g.gameover_ticks > 0 {
            g.gameover_ticks -= 1;
            if g.gameover_ticks == 0 {
                g.level.start_curtain_close(&mut self.world, &mut self.host, true);
                g.closing = Some(true);
            }
        }
        if goal && g.finish_ticks > 0 && g.closing.is_none() {
            g.finish_ticks -= 1;
            if g.finish_ticks == 0 {
                g.level.start_curtain_close(&mut self.world, &mut self.host, false);
                g.closing = Some(false);
            }
        }
        if g.level.curtain_done {
            let (number, won) = (g.number, g.level.goal_reached());
            let (bonus, container) = (g.level.bonus, g.level.got_container);
            self.over.goal = won;
            self.over.bonus = bonus;
            self.over.container = container;
            let cancel = !won;
            if cancel {
                self.restart_game(number);
            } else if self.save.doors.get(number as usize - 1).copied().flatten().is_none() {
                self.close_game();
            } else {
                self.replay_game();
            }
        }
    }

    fn handle_sfx(&mut self, fx: Sfx) {
        let Some(g) = self.game.as_mut() else { return };
        let (player, effects, music) = (g.player.clone(), g.effects.clone(), g.music.clone());
        let number = g.number;
        let mv = self.musicvol / 100.0;
        // length of a sound in ticks (its real decoded duration, whatever its sample rate)
        let rate = self.audio.rate;
        let lens: Vec<(String, i32)> = ["gameover", "finish", "finish_elpix"]
            .iter()
            .map(|n| {
                let t = player.files.get(*n).cloned().and_then(|p| self.audio.load(&p).ok()).map(|pcm| (pcm.seconds(rate) * TICK_HZ) as i32 + 4).unwrap_or(100).max(30);
                (n.to_string(), t)
            })
            .collect();
        let tick_len = |_: &Bank, name: &str| -> i32 { lens.iter().find(|l| l.0 == name).map(|l| l.1).unwrap_or(100) };
        match fx {
            Sfx::Player(n) => {
                if n == "steps" {
                    let playing = self.game.as_ref().and_then(|g| g.steps_voice).map(|v| self.audio.is_playing(v)).unwrap_or(false);
                    if !playing {
                        let v = self.play_named(&player, n, 999, 1.0);
                        if let Some(g) = self.game.as_mut() {
                            g.steps_voice = v;
                        }
                    }
                    return;
                }
                let vol = match n {
                    "jump" => 0.5,
                    "hitEnemy" => 0.7,
                    "hurt" => 0.5,
                    _ => 1.0,
                };
                self.play_named(&player, n, 1, vol);
                if let Some(g) = self.game.as_mut() {
                    if n == "gameover" {
                        g.gameover_ticks = tick_len(&player, n);
                    } else if n == "finish" || n == "finish_elpix" {
                        g.finish_ticks = tick_len(&player, n);
                    }
                }
            }
            Sfx::PlayerStop(n) => {
                if n == "steps" {
                    if let Some(v) = self.game.as_mut().and_then(|g| g.steps_voice.take()) {
                        self.audio.stop(v);
                    }
                }
            }
            Sfx::Effect(n) => {
                self.play_named(&effects, n, 1, 0.3);
            }
            Sfx::MusicStart => {
                if number == 25 {
                    let v = self.play_named(&music, "track", 999, mv);
                    if let Some(g) = self.game.as_mut() {
                        g.music_voice = v;
                    }
                } else {
                    let v = self.play_named(&effects, "start", 1, mv);
                    let none = v.is_none();
                    let mv_voice = if none { self.play_named(&music, "track", 999, mv) } else { None };
                    if let Some(g) = self.game.as_mut() {
                        g.start_voice = v;
                        g.music_voice = mv_voice;
                    }
                }
            }
            Sfx::MusicStop => {
                let ids: Vec<VoiceId> = self.game.as_mut().map(|g| [g.music_voice.take(), g.start_voice.take()].into_iter().flatten().collect()).unwrap_or_default();
                for v in ids {
                    self.audio.stop(v);
                }
            }
        }
    }

    fn step_audio_events(&mut self) {
        for done in self.audio.take_finished() {
            let mut start_music = false;
            if let Some(g) = self.game.as_mut() {
                if Some(done) == g.start_voice {
                    g.start_voice = None;
                    start_music = g.music_voice.is_none() && !g.level.paused && g.level.outcome == Outcome::Playing && !g.level.goal_reached();
                }
            }
            if start_music {
                let music = self.game.as_ref().map(|g| g.music.clone()).unwrap();
                let mv = self.musicvol / 100.0;
                let v = self.play_named(&music, "track", 999, mv);
                if let Some(g) = self.game.as_mut() {
                    g.music_voice = v;
                }
            }
        }
    }

    /// Timeline `StartSound` tags (sounds embedded in movies).
    fn drain_sound_events(&mut self) {
        for ev in std::mem::take(&mut self.world.sound_events) {
            if ev.start.stop {
                continue;
            }
            let lib = self.world.libs[ev.lib as usize].clone();
            if let Some(m) = lib.lib.sounds.iter().find(|m| m.id == ev.start.id) {
                let path = lib.dir.join("sounds").join(&m.file);
                if let Ok(pcm) = self.audio.load(&path) {
                    self.audio.play(&pcm, 0.0, ev.start.loops.max(1) as u32, 1.0);
                }
            }
        }
    }

    pub fn open_url(&self, url: &str) {
        log::info!("open {url}");
        let (cmd, args): (&str, Vec<&str>) = if cfg!(target_os = "macos") {
            ("open", vec![url])
        } else if cfg!(target_os = "windows") {
            ("cmd", vec!["/C", "start", "", url])
        } else {
            ("xdg-open", vec![url])
        };
        let _ = std::process::Command::new(cmd).args(args).stdin(std::process::Stdio::null()).stdout(std::process::Stdio::null()).stderr(std::process::Stdio::null()).spawn();
    }

    /// Copies a bundled download (zip) into the user's Downloads folder and reveals it.
    pub fn download(&mut self, path: &Path) {
        let name = path.file_name().map(|n| n.to_owned()).unwrap_or_default();
        let dl = if cfg!(target_os = "windows") {
            std::env::var_os("USERPROFILE").map(|h| PathBuf::from(h).join("Downloads"))
        } else {
            std::env::var_os("HOME").map(|h| PathBuf::from(h).join("Downloads"))
        }
        .filter(|p| p.exists())
        .unwrap_or_else(|| std::env::current_dir().unwrap_or_default());
        let dest = dl.join(&name);
        match std::fs::copy(path, &dest) {
            Ok(_) => {
                log::info!("saved {}", dest.display());
                self.last_download = Some(dest);
            }
            Err(e) => log::warn!("download {}: {e}", path.display()),
        }
    }
}

pub fn _unused(_: TexId) {}
