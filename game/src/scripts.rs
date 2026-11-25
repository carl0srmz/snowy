//! Native implementations of the original timeline scripts and script objects
//! (`Sound`, `Ticker`, the movie-level helper functions).
use crate::audio::VoiceId;
use crate::level::LHost;
use crate::movie::*;
use crate::ui::*;
use std::rc::Rc;

pub struct Snd {
    pub bank: Bank,
    pub name: String,
    pub voice: Option<VoiceId>,
    pub vol: f32,
}

pub enum ScriptObj {
    Snd(Snd),
    Ticker(u32),
}

pub enum WaitAction {
    Play,
    RandLabel(&'static str, u32),
    LabelVar(&'static str),
}

pub struct Wait {
    pub clip: ClipId,
    pub owner: ClipId,
    pub ticks: i32,
    pub action: WaitAction,
    /// created during this tick's dispatch: its first enterFrame is next tick
    pub fresh: bool,
}

fn s_of(v: &Value) -> String {
    match v {
        Value::Str(s) => s.clone(),
        Value::Num(n) => format!("{}", n),
        _ => String::new(),
    }
}

impl Ui {
    /// Called after every world step: acts on calls and behaviours that scripts requested.
    pub fn dispatch(&mut self) {
        let calls = std::mem::take(&mut self.host.calls);
        let behaviors = std::mem::take(&mut self.host.behaviors);
        for (from, target, name, args) in calls {
            if target == NONE {
                if let Some((path, method)) = name.split_once('\u{1}') {
                    self.obj_call(from, path, method, &args);
                }
            } else {
                self.handle_call(from, target, &name, &args);
            }
        }
        for (clip, name) in behaviors {
            self.handle_behavior(clip, &name);
        }
        self.step_waits();
        self.step_followers();
    }

    fn lib_name(&self, clip: ClipId) -> String {
        self.world.clip(clip).map(|c| self.world.libs[c.lib as usize].lib.name.clone()).unwrap_or_default()
    }

    fn handle_call(&mut self, from: ClipId, target: ClipId, name: &str, args: &[Value]) {
        match name {
            "getURL" => {
                if let Some(Value::Str(u)) = args.first() {
                    self.open_url(u);
                }
            }
            "setText" => {
                let lib = self.lib_name(from);
                if lib == "data/intro" {
                    self.intro_set_text(from, args);
                } else {
                    // credits / generic: worldmap XML text with letter spacing 0.5
                    if let Some(Value::Clip(c)) = args.first() {
                        let key = args.get(1).map(s_of).unwrap_or_default();
                        let t = self.wm.text(&key);
                        self.set_html_at(*c, &t, Some(0.5));
                    }
                }
            }
            "setDelay" => self.intro_set_delay(args.first().map(|v| v.num()).unwrap_or(0.0)),
            "showWorldmap" => self.intro_show_worldmap(),
            "startWorldmap" => self.start_worldmap(),
            "bonus" => {
                let p = self.paths.media().join("27_SpecialDownloads/SpecialDownloads.zip");
                self.download(&p);
            }
            "stopTicker" => self.lab_stop_tickers(),
            "showEnergy" | "throwPinku" => {
                if let Some(g) = self.game.as_mut() {
                    g.level.script_call(&mut self.world, &mut self.host, from, name);
                }
            }
            "tabHandler" | "setFocus" => {}
            _ => {
                let _ = target;
            }
        }
    }

    // ----------------------------------------------------- script objects

    fn obj_owner(&self, from: ClipId, path: &str) -> (ClipId, String) {
        // "a.b.obj" -> (clip a.b, "obj"); "obj" -> (from, "obj")
        match path.rsplit_once('.') {
            Some((head, last)) => (self.world.path(from, head), last.to_string()),
            None => (from, path.to_string()),
        }
    }

    pub fn new_sound_obj(&mut self, owner: ClipId, name: &str, bank: Bank, sound: &str, vol: f32) {
        self.objs.insert((owner, name.to_string()), ScriptObj::Snd(Snd { bank, name: sound.to_string(), voice: None, vol }));
    }

    fn obj_call(&mut self, from: ClipId, path: &str, method: &str, args: &[Value]) {
        let (owner, name) = self.obj_owner(from, path);
        // objects are registered on the movie root or on the clip that owns the variable
        let mut key = (owner, name.clone());
        if !self.objs.contains_key(&key) {
            let root = self.world.movie_root(from);
            key = (root, name.clone());
            if !self.objs.contains_key(&key) {
                // walk up the parents
                let mut cur = from;
                while cur != NONE {
                    if self.objs.contains_key(&(cur, name.clone())) {
                        key = (cur, name.clone());
                        break;
                    }
                    cur = self.world.clip(cur).map(|c| c.parent).unwrap_or(NONE);
                }
            }
        }
        let Some(obj) = self.objs.get(&key) else { return };
        match obj {
            ScriptObj::Ticker(id) => {
                let id = *id;
                match method {
                    "start" => self.ticker_begin(id),
                    "stop" => self.stop_ticker(id),
                    _ => {}
                }
            }
            ScriptObj::Snd(_) => self.snd_call(&key, method, args),
        }
    }

    pub fn new_ticker(&mut self, text: &str, target: ClipId, vol: f32, done: Option<Handler>) -> u32 {
        self.make_ticker(text, target, vol, done, false)
    }

    pub fn snd_call(&mut self, key: &(ClipId, String), method: &str, args: &[Value]) {
        let (bank, sname, voice, vol) = match self.objs.get(key) {
            Some(ScriptObj::Snd(s)) => (s.bank.clone(), s.name.clone(), s.voice, s.vol),
            _ => return,
        };
        let playing = voice.map(|v| self.audio.is_playing(v)).unwrap_or(false);
        log::debug!(target: "snd", "tick {} {}.{}({:?}) sound={} vol={} playing={}", self.tick_no, key.1, method, args, sname, vol, playing);
        let mut new_voice = voice;
        let mut new_vol = vol;
        match method {
            "attachSound" => {
                if let Some(Value::Str(n)) = args.first() {
                    if let Some(ScriptObj::Snd(s)) = self.objs.get_mut(key) {
                        s.name = n.clone();
                    }
                }
                return;
            }
            "setVolume" => {
                new_vol = args.first().map(|v| v.num() as f32).unwrap_or(100.0);
                if let Some(v) = voice {
                    self.audio.set_volume(v, new_vol / 100.0);
                }
            }
            "start" => {
                if let Some(v) = voice {
                    self.audio.stop(v);
                }
                let loops = args.get(1).map(|v| v.num() as u32).unwrap_or(1).max(1);
                new_voice = self.play_named(&bank, &sname, loops, new_vol / 100.0);
            }
            "stop" => {
                if let Some(v) = voice {
                    self.audio.stop(v);
                }
                new_voice = None;
            }
            "fadeIn" => {
                // SoundFile.fade(1, delay): +2 volume every (delay + 1) frames
                let delay = args.first().map(|v| v.num() as f32).filter(|d| d.is_finite()).unwrap_or(0.0).max(0.0) + 1.0;
                let target = if new_vol <= 0.0 { 100.0 } else { new_vol };
                if let Some(v) = voice {
                    self.audio.stop(v);
                }
                new_voice = self.play_named(&bank, &sname, 999, 0.0);
                if let Some(v) = new_voice {
                    self.audio.fade_to(v, target / 100.0, (target / 2.0) * delay / TICK_HZ, false);
                }
                new_vol = target;
            }
            "fadeOut" => {
                // SoundFile.fade(-1, delay): -2 volume every (delay + 1) frames
                let delay = args.first().map(|v| v.num() as f32).filter(|d| d.is_finite()).unwrap_or(0.0).max(0.0) + 1.0;
                if playing {
                    if let Some(v) = voice {
                        self.audio.fade_to(v, 0.0, (new_vol / 2.0).max(1.0) * delay / TICK_HZ, true);
                    }
                }
            }
            "fadeTo" => {
                let to = args.first().map(|v| v.num() as f32).unwrap_or(100.0);
                if let Some(v) = voice {
                    self.audio.fade_to(v, to / 100.0, (to - new_vol).abs() / TICK_HZ, to <= 0.0);
                } else if to > 0.0 {
                    new_voice = self.play_named(&bank, &sname, 999, 0.0);
                    if let Some(v) = new_voice {
                        self.audio.fade_to(v, to / 100.0, to / TICK_HZ, false);
                    }
                }
                new_vol = to;
            }
            _ => {}
        }
        if let Some(ScriptObj::Snd(s)) = self.objs.get_mut(key) {
            s.voice = new_voice;
            s.vol = new_vol;
        }
    }

    // ------------------------------------------------------------- waits

    fn step_waits(&mut self) {
        let mut due: Vec<(ClipId, WaitAction)> = Vec::new();
        let mut keep = Vec::new();
        let cancelled = std::mem::take(&mut self.world.cancelled_enter);
        for mut w in std::mem::take(&mut self.waits) {
            if cancelled.contains(&w.owner) {
                continue;
            }
            if !self.world.alive(w.clip) {
                continue;
            }
            if w.fresh {
                w.fresh = false;
                keep.push(w);
                continue;
            }
            w.ticks -= 1;
            if w.ticks <= 0 {
                due.push((w.clip, w.action));
            } else {
                keep.push(w);
            }
        }
        self.waits.extend(keep);
        for (clip, a) in due {
            match a {
                WaitAction::Play => self.world.set_playing(clip, true),
                WaitAction::RandLabel(prefix, n) => {
                    let r = (self.tick_no as u32).wrapping_mul(2654435761).rotate_left(7) % n + 1;
                    self.world.jump_label(clip, &format!("{}{}", prefix, r), true, &mut LHost::default());
                }
                WaitAction::LabelVar(prefix) => {
                    let v = self.world.get_var(clip, "nextdir");
                    let d = match &v {
                        Value::Str(s) => s.clone(),
                        Value::Num(n) => format!("{}", n),
                        _ => String::new(),
                    };
                    self.world.jump_label(clip, &format!("{}{}", prefix, d), true, &mut LHost::default());
                }
            }
        }
    }

    fn step_followers(&mut self) {
        let list = std::mem::take(&mut self.followers);
        let mut keep = Vec::new();
        for (clip, kind) in list {
            if !self.world.alive(clip) {
                continue;
            }
            match kind {
                0 => {
                    // mammoth: its obstacle follows the animated container
                    let container = self.world.path(clip, "container");
                    let y = self.world.get_var(container, "_y");
                    let parent = self.world.clip(clip).map(|c| c.parent).unwrap_or(NONE);
                    self.world.set_var(parent, "lasty", y.clone());
                    let gp = self.world.clip(parent).map(|c| c.parent).unwrap_or(NONE);
                    let ob = self.world.path(gp, "obstacle");
                    self.world.set_var(ob, "_y", Value::Num(y.num() - 34.0));
                }
                _ => {
                    // moving platform bookkeeping: x = lx; lx = _x
                    let lx = self.world.get_var(clip, "lx");
                    self.world.set_var(clip, "x", lx);
                    let cur = self.world.get_var(clip, "_x");
                    self.world.set_var(clip, "lx", cur);
                }
            }
            keep.push((clip, kind));
        }
        self.followers.extend(keep);
    }

    /// `cnt = ticks; onEnterFrame = function () { if (cnt-- == 0) action; }` of the original:
    /// the action runs on the (ticks + 1)th enterFrame after the frame that set it up.
    fn wait(&mut self, clip: ClipId, ticks: i32, action: WaitAction) {
        self.world.set_playing(clip, false);
        self.waits.push(Wait { clip, owner: clip, ticks: ticks + 1, action, fresh: true });
    }

    // --------------------------------------------------------- behaviours

    fn handle_behavior(&mut self, clip: ClipId, name: &str) {
        let h = &mut LHost::default();
        match name {
            // worldmap root
            "script:aaa08d1a" => {
                self.world.set_playing(clip, false);
                let t = self.world.path(clip, "tuer_taf");
                self.world.jump_label(t, "taf", false, h);
                if !self.debug {
                    let b = self.world.path(clip, "cookie_button");
                    self.world.set_var(b, "_visible", Value::Bool(false));
                }
            }
            // impressum / credits / generic text initialisers are done up front
            "script:d3fe0179" => {
                self.world.set_playing(clip, false);
                let sp = self.world.path(clip, "sperre");
                self.clear_handlers(sp);
            }
            "script:06c00972" | "script:aa062886" | "script:26d8fb7b" | "script:cbd700e3" => {}
            // random-phase animations
            "script:0f4a9cb6" => self.rand_goto(clip, 40, 2),
            "script:0f60e254" => self.rand_goto(clip, 70, 3),
            "script:41857009" => self.rand_goto(clip, 45, 2),
            "script:5aa223fc" => self.rand_goto(clip, 45, 3),
            "script:197caed6" => {
                let px = self.world.clip(clip).and_then(|c| self.world.clip(c.parent)).map(|p| p.m.tx).unwrap_or(0.0);
                let r = self.rand(70) as f32 + 2.0;
                self.world.set_var(clip, "_x", Value::Num((px - r) as f64));
                let f = self.rand(60) + 10;
                self.world.jump(clip, f as u16, true, h);
            }
            "script:6cd51260" => {
                let px = self.world.clip(clip).and_then(|c| self.world.clip(c.parent)).map(|p| p.m.tx).unwrap_or(0.0);
                let r = self.rand(70) as f32 + 2.0;
                self.world.set_var(clip, "_x", Value::Num((px - r) as f64));
                let f = self.rand(80) + 50;
                self.world.jump(clip, f as u16, true, h);
            }
            // platform helpers
            "script:9e7d5adb" => self.followers.push((clip, 0)),
            "script:0b45e7b9" => {
                self.world.set_var(clip, "type", Value::Num(1.0));
                self.world.set_var(clip, "moving", Value::Bool(true));
                self.world.set_var(clip, "flying", Value::Bool(true));
                self.followers.push((clip, 1));
            }
            // boss attack scheduling: wait DELAY ticks, then pick an attack animation
            "script:f631e737" => {
                let d = self.delay_of(clip);
                self.wait(clip, d, WaitAction::RandLabel("attack_right_", 2));
            }
            "script:12bc3ec6" => {
                let d = self.delay_of(clip);
                self.wait(clip, d, WaitAction::RandLabel("attack_left_", 2));
            }
            "script:93854700" => {
                let d = self.delay_of(clip);
                self.wait(clip, d, WaitAction::RandLabel("attack_down_", 3));
            }
            "script:52ffade3" => {
                let d = self.delay_of(clip);
                self.wait(clip, d, WaitAction::LabelVar("bomb_"));
            }
            "script:255cbc33" => {
                // boss spawn position: drop in on the side away from the hero
                let gp = self.world.clip(clip).map(|c| c.parent).and_then(|p| self.world.clip(p)).map(|p| p.parent).unwrap_or(NONE);
                let hero_x = self.game.as_ref().map(|g| g.level.hero_screen_x(&self.world)).unwrap_or(0.0);
                self.world.set_var(gp, "_y", Value::Num(-2.0));
                self.world.set_var(gp, "_x", Value::Num(if hero_x > 240.0 { -100.0 } else { 100.0 }));
            }
            // credits
            "script:e0dd95da" => {
                let sch = self.world.path(clip, "schwabbel");
                self.world.jump_label(sch, "talk", true, h);
                self.credits_text(clip, "text_txt", "mainmap_credits_01a_schwabbel");
                self.wait(clip, 170, WaitAction::Play);
            }
            "script:ef844e34" => {
                self.credits_text(clip, "text_txt", "mainmap_credits_01b_schwabbel");
                self.wait(clip, 170, WaitAction::Play);
            }
            // lab, story page
            "script:fb21b8d7" => {
                let f = self.world.clip(clip).map(|c| c.frame).unwrap_or(1);
                self.world.jump(clip, if f == 1 { 2 } else { 1 }, false, h);
                self.story_page(clip);
            }
            "script:f46aa506" => {
                if self.world.get_var(clip, "init").is_undef() {
                    self.world.jump_label(clip, "over", true, h);
                }
                let i = self.world.path(clip, "icon");
                self.world.jump(i, 2, false, h);
                for p in ["pfeile.pfeil1", "pfeile.pfeil2"] {
                    let c = self.world.path(clip, p);
                    self.world.set_var(c, "_visible", Value::Bool(true));
                }
            }
            "script:d3956e71" => self.lab_exit_door(clip),
            "script:25386a95" | "script:f0252911" => self.lab_download_tab(clip, name),
            // intro
            "script:231d9748" => self.intro_setup_sounds(clip),
            "script:9ffb38bb" => self.intro_root_init(clip),
            "script:25973afa" | "script:625d5346" => self.intro_text_init(clip, name),
            "script:2b20c89e" => self.schwabbel_start(clip),
            other => {
                if other.starts_with("script:") {
                    log::debug!("unimplemented script behaviour {}", other);
                }
            }
        }
    }

    fn delay_of(&self, clip: ClipId) -> i32 {
        let v = self.world.get_var(clip, "DELAY");
        if v.is_undef() {
            let mut cur = clip;
            while cur != NONE {
                let d = self.world.get_var(cur, "DELAY");
                if !d.is_undef() {
                    return d.num() as i32;
                }
                cur = self.world.clip(cur).map(|c| c.parent).unwrap_or(NONE);
            }
            30
        } else {
            v.num() as i32
        }
    }

    pub fn rand(&mut self, n: u32) -> u32 {
        self.rng ^= self.rng << 13;
        self.rng ^= self.rng >> 17;
        self.rng ^= self.rng << 5;
        self.rng % n.max(1)
    }

    fn rand_goto(&mut self, clip: ClipId, n: u32, k: u32) {
        let f = self.rand(n) + k;
        self.world.jump(clip, f as u16, true, &mut LHost::default());
    }

    fn credits_text(&mut self, clip: ClipId, field: &str, key: &str) {
        let c = self.world.path(clip, field);
        let t = self.wm.text(key);
        self.set_html_at(c, &t, Some(0.5));
    }

    /// closeGame's speech: `speech.start()` on the Schwabbel report clip.
    fn schwabbel_start(&mut self, clip: ClipId) {
        self.world.set_playing(clip, false);
        let speech = self.objs.get(&(clip, "speech".to_string())).map(|o| if let ScriptObj::Ticker(i) = o { *i } else { 0 });
        if let Some(id) = speech {
            self.ticker_begin(id);
        }
        let sch = self.world.path(clip, "schwabbel");
        self.world.set_playing(sch, true);
        if !self.world.get_var(clip, "speech2").is_undef() {
            self.wait(clip, 238, WaitAction::Play);
        }
    }

    fn story_page(&mut self, story: ClipId) {
        let f = self.world.clip(story).map(|c| c.frame).unwrap_or(1);
        let key = if f == 1 { "story1" } else { "story2" };
        let t = self.world.get_var(story, key);
        let txt = self.world.path(story, "story_txt");
        if let Value::Str(s) = t {
            self.set_html_at(txt, &s, None);
        }
    }

    // ------------------------------------------------------------ feedback

    pub fn init_feedback(&mut self) {
        let wm = self.wm.clone();
        let ls = Some(0.5);
        self.set_text("feedback.feedback_txt", &wm.text("mainmap_buttons_04_feedback"), ls);
        self.set_html("feedback.head_txt", &wm.text("mainmap_feedback_01_head"), ls);
        self.set_text("feedback.name_txt", &wm.text("mainmap_feedback_02_name"), ls);
        self.set_html("feedback.hinweis_txt", &wm.text("mainmap_feedback_03_hinweis"), ls);
        self.set_text("feedback.send_txt", &wm.text("mainmap_feedback_04_send"), ls);
        self.set_text("feedback.email_txt", &wm.text("mainmap_feedback_05_email"), ls);
        self.set_text("feedback.message_txt", "", ls);
        self.on("feedback.send_bt", Evt::Press, |u| u.check_feedback());
    }

    /// The original posted to a web service; offline we validate, thank the user and store it locally.
    fn check_feedback(&mut self) {
        let wm = self.wm.clone();
        let name = self.field_text("feedback.name_txt");
        let email = self.field_text("feedback.email_txt");
        let msg = self.field_text("feedback.message_txt");
        let mut bad = false;
        if name == wm.text("mainmap_feedback_02_name") {
            self.goto_frame("feedback.error_name", 2, true);
            bad = true;
        }
        if msg.is_empty() {
            self.goto_frame("feedback.error_message", 2, true);
            bad = true;
        }
        let valid_email = email.contains('@') && email.rsplit('@').next().map(|d| d.contains('.')).unwrap_or(false);
        if email != wm.text("mainmap_feedback_05_email") && !valid_email {
            self.goto_frame("feedback.error_email", 2, true);
            bad = true;
        }
        if !bad {
            let dir = crate::save::data_dir();
            let _ = std::fs::create_dir_all(&dir);
            let line = format!("name: {}\nemail: {}\nmessage: {}\n---\n", name, email, msg);
            use std::io::Write;
            if let Ok(mut f) = std::fs::OpenOptions::new().create(true).append(true).open(dir.join("feedback.txt")) {
                let _ = f.write_all(line.as_bytes());
            }
            self.set_html("feedback.message_txt", &wm.text("mainmap_feedback_06_danke"), Some(0.5));
            self.goto_frame("feedback", 2, true);
        }
    }

    fn field_text(&self, path: &str) -> String {
        let c = self.clip(path);
        self.world.text_field(c).map(|t| t.text()).unwrap_or_default()
    }

    // ------------------------------------------------------------- credits

    pub fn load_credits(&mut self) {
        self.lounge_fade_to(0.0);
        self.preloader_fade(true);
        let container = self.clip("credits.container");
        if let Err(e) = self.load_movie(container, "data/credits") {
            log::error!("credits: {e:#}");
            return;
        }
        self.credits_loaded = true;
        self.after(6, |u| u.initialize_credits());
    }

    fn initialize_credits(&mut self) {
        self.show_topic(Some("credits"), 0);
        let container = self.clip("credits.container");
        let bank = load_bank(&self.assets, "data/sounds/credits");
        self.credits_voice = self.play_named(&bank, "track", 999, 0.0);
        self.credits_vol = 0.0;
        self.credits_fade_to(100.0);
        self.preloader_fade(false);
        self.world.jump(container, 2, false, &mut LHost::default());
        // credits.container.bonus -> special downloads
        self.on("credits.container.bonus_bt", Evt::Press, |u| {
            let p = u.paths.media().join("27_SpecialDownloads/SpecialDownloads.zip");
            u.download(&p);
        });
    }

    pub fn ticker_begin(&mut self, id: u32) {
        let b = self.effects_bank.clone();
        let vol = self.tickers.iter().find(|t| t.id == id).map(|t| t.vol).unwrap_or(1.0);
        let voice = self.play_named(&b, "piep2", 999, vol);
        if let Some(t) = self.tickers.iter_mut().find(|t| t.id == id) {
            t.started = true;
            t.pos = 0;
            t.voice = voice;
        }
    }

    pub fn _unused_rc(_: Rc<()>) {}
}
