//! The animated introduction (`intro.swf`) and its movie-level helper functions.
use crate::level::LHost;
use crate::movie::*;
use crate::scripts::{Wait, WaitAction};
use crate::texts::XmlValues;
use crate::ui::*;
use anyhow::Result;
use std::rc::Rc;

#[derive(Default)]
pub struct IntroState {
    pub xml: XmlValues,
    pub active: bool,
    pub ticker: Option<u32>,
}

impl Ui {
    pub fn show_intro_screen(&mut self) -> Result<()> {
        self.intro_state = IntroState { xml: self.paths.text("intro.xml"), active: true, ticker: None };
        self.set_visible("worldmap", false);
        self.stop_all_tickers();
        self.audio.stop_all();
        self.lounge_voice = None;
        self.load_movie(self.layer_intro, "data/intro")?;
        self.world.set_playing(self.layer_intro, true);
        self.dispatch();
        Ok(())
    }

    fn intro_root(&self) -> ClipId {
        self.layer_intro
    }

    pub fn intro_setup_sounds(&mut self, clip: ClipId) {
        let root = self.world.movie_root(clip);
        let bank = load_bank(&self.assets, "data/sounds/intro");
        for (name, snd, vol) in [
            ("piep1", "piep1", 80.0),
            ("piep2", "piep2", 80.0),
            ("piep3", "piep3", 80.0),
            ("piep4", "piep4", 80.0),
            ("bing", "bing", 80.0),
            ("eyepling", "eyepling", 200.0),
            ("loop1", "loop1", 100.0),
            ("worldmap", "loop2", 100.0),
            ("titletheme", "title", 100.0),
        ] {
            self.new_sound_obj(root, name, bank.clone(), snd, vol);
        }
        let lounge = self.lounge.clone();
        self.new_sound_obj(root, "loop2", lounge, "track", 100.0);
    }

    pub fn intro_root_init(&mut self, _clip: ClipId) {}

    pub fn intro_text_init(&mut self, clip: ClipId, name: &str) {
        let (field, key, ls) = if name == "script:25973afa" { ("skip_txt", "05_buttons_02_skipintro", 2.0) } else { ("off_01_ort", "00_off_01_ort", 1.0) };
        if name == "script:25973afa" {
            self.world.set_playing(clip, false);
        }
        let t = self.intro_state.xml.text(key);
        let c = self.world.path(clip, field);
        self.set_text_at(c, &t, Some(ls));
    }

    /// `_root.setText(txt, key, align, piepNum, size, showButton)` of the intro movie.
    pub fn intro_set_text(&mut self, from: ClipId, args: &[Value]) {
        let Some(Value::Clip(txt)) = args.first() else { return };
        let key = match args.get(1) {
            Some(Value::Str(s)) => s.clone(),
            _ => return,
        };
        let piep = args.get(3).map(|v| v.num()).filter(|n| n.is_finite()).unwrap_or(1.0) as i32;
        let size = args.get(4).map(|v| v.num()).filter(|n| n.is_finite()).unwrap_or(20.0) as f32;
        let show_button = args.get(5).map(|v| v.truthy()).unwrap_or(false);
        let text = self.intro_state.xml.text(&key);
        log::debug!(target: "snd", "tick {} setText({}, piep{})", self.tick_no, key, piep);
        let txt = *txt;
        if let Some(t) = self.world.text_field_mut(txt) {
            t.set_text("");
            t.auto_size = true;
            t.set_format(Some(size), Some(2.0));
        }
        let root = self.world.movie_root(from);
        let done: Option<Handler> = if show_button {
            Some(Rc::new(move |u: &mut Ui| {
                let b = u.world.path(root, "stage.b_weiter");
                u.world.set_var(b, "_visible", Value::Bool(true));
            }))
        } else {
            None
        };
        if let Some(old) = self.intro_state.ticker.take() {
            self.stop_ticker(old);
        }
        let id = self.make_ticker_with_sound(&text, txt, 0.8, done, root, &format!("piep{}", piep));
        self.intro_state.ticker = Some(id);
    }

    /// A ticker whose speech sound is one of the intro's `piepN` objects.
    fn make_ticker_with_sound(&mut self, text: &str, target: ClipId, vol: f32, done: Option<Handler>, root: ClipId, snd: &str) -> u32 {
        let id = self.make_ticker(text, target, vol, done, false);
        let key = (root, snd.to_string());
        let bank = match self.objs.get(&key) {
            Some(crate::scripts::ScriptObj::Snd(s)) => Some((s.bank.clone(), s.name.clone())),
            _ => None,
        };
        let voice = bank.and_then(|(b, n)| self.play_named(&b, &n, 999, vol));
        if let Some(t) = self.tickers.iter_mut().find(|t| t.id == id) {
            t.started = true;
            t.pos = 0;
            t.voice = voice;
        }
        id
    }

    /// `_root.setDelay(sec)`: advance the scene after a pause unless the player presses "continue".
    pub fn intro_set_delay(&mut self, sec: f64) {
        let root = self.intro_root();
        let b = self.world.path(root, "stage.b_weiter");
        let scene = self.world.path(root, "stage.szene");
        if scene == NONE {
            return;
        }
        // b_weiter.counter = sec * 34; onEnterFrame: if (--counter == 0) scene.play()
        // (assigning onEnterFrame replaces a pending delay; a non-integer count never reaches 0)
        self.waits.retain(|w| w.owner != b);
        let n = sec * 34.0;
        if n.fract() != 0.0 || n < 1.0 {
            return;
        }
        log::debug!(target: "snd", "tick {} setDelay({})", self.tick_no, sec);
        self.waits.push(Wait { clip: scene, owner: b, ticks: n as i32, action: WaitAction::Play, fresh: true });
    }

    pub fn intro_show_worldmap(&mut self) {
        let root = self.intro_root();
        for n in ["piep1", "piep2", "piep3", "piep4", "loop1", "loop2", "titletheme"] {
            let key = (root, n.to_string());
            self.snd_call(&key, "fadeOut", &[]);
        }
        self.world.jump_label(root, "worldmap", true, &mut LHost::default());
    }

    pub fn intro_tick(&mut self) {}
}
