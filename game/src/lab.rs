//! The laboratory: promo info, screenshots, videos and downloads for every game found.
//! A port of the original `Lab` class onto the converted `lab.swf` clips.
use crate::level::LHost;
use crate::movie::*;
use crate::scripts::ScriptObj;
use crate::texts::XmlValues;
use crate::ui::*;
use crate::video::VideoPlayer;
use std::rc::Rc;

pub struct Content {
    pub name: String,
    pub info: XmlValues,
    pub media: XmlValues,
    pub platform: String,
}

pub struct Lab {
    pub content: Vec<Content>,
    pub xml: XmlValues,
    pub game: usize,
    pub root: ClipId,
    pub video: Option<VideoPlayer>,
    pub video_clip: ClipId,
    pub shots: Vec<ClipId>,
    pub cur_shot: usize,
    pub tickers: Vec<u32>,
    pub schwabbel: Option<u32>,
    pub loaded: bool,
    pub pending_content: Vec<Content>,
}

const MAX_GAMES: usize = 24;
const MAX_SHOTS: usize = 10;

impl Ui {
    /// Worldmap.loadLab
    pub fn load_lab(&mut self) {
        self.preloader_fade(true);
        let lab_clip = self.clip("lab");
        let loaded = self.lab.as_ref().map(|l| l.loaded).unwrap_or(false);
        if !loaded {
            if let Err(e) = self.load_movie(lab_clip, "data/lab") {
                log::error!("lab: {e:#}");
                self.preloader_fade(false);
                return;
            }
        }
        let xml = self.paths.text("labor.xml");
        let mut content = Vec::new();
        for lvl in self.save.lab.clone() {
            let name = self.content.text(&(lvl + 1).to_string());
            if name.is_empty() || name == "25_ElPix" {
                continue;
            }
            let info = self.paths.text(&format!("{}.xml", name));
            let media = XmlValues::load(&self.paths.media().join(&name).join("media.xml"));
            let platform = media.text("platform");
            content.push(Content { name, info, media, platform });
        }
        let old = self.lab.take();
        let mut lab = Lab {
            content: Vec::new(),
            xml,
            game: 0,
            root: NONE,
            video: None,
            video_clip: NONE,
            shots: Vec::new(),
            cur_shot: 1,
            tickers: Vec::new(),
            schwabbel: None,
            loaded: true,
            pending_content: content,
        };
        if let Some(mut o) = old {
            if let Some(v) = o.video.as_mut() {
                v.stop(&self.audio, &mut self.rd);
            }
        }
        lab.root = NONE;
        self.lab = Some(lab);
        self.after(6, |u| u.initialize_lab());
    }

    fn lab_clip(&self, path: &str) -> ClipId {
        let root = self.lab.as_ref().map(|l| l.root).unwrap_or(NONE);
        self.world.path(root, path)
    }

    fn initialize_lab(&mut self) {
        let root = self.clip("lab.lab");
        if let Some(l) = self.lab.as_mut() {
            l.content = std::mem::take(&mut l.pending_content);
            l.root = root;
        }
        self.on("lab.lab.blase.exit_button", Evt::Press, |u| u.close_lab(true));
        self.last_topic = self.topic.clone();
        let cur = self.topic.clone();
        self.set_visible(&cur, false);
        self.topic = "lab".into();
        self.set_visible("lab", true);
        self.preloader_fade(false);
        self.lounge_fade_to(30.0);
        self.lab_initialize();
    }

    pub fn close_lab(&mut self, to_worldmap: bool) {
        self.lab_reset();
        self.lounge_fade_to(100.0);
        if to_worldmap {
            self.show_topic(Some("worldmap"), 0);
        } else {
            self.show_topic(None, 0);
        }
    }

    fn lab_reset(&mut self) {
        self.control_video("stop");
        self.lab_stop_tickers();
        if let Some(l) = self.lab.as_mut() {
            if let Some(s) = l.schwabbel.take() {
                self.stop_ticker(s);
            }
        }
        let lab = self.lab_clip("");
        self.world.set_playing(lab, true);
    }

    pub fn lab_stop_tickers(&mut self) {
        let ids: Vec<u32> = self.lab.as_mut().map(|l| std::mem::take(&mut l.tickers)).unwrap_or_default();
        for id in ids {
            self.stop_ticker(id);
        }
    }

    fn lab_text(&self, key: &str) -> String {
        self.lab.as_ref().map(|l| l.xml.text(key)).unwrap_or_default()
    }

    fn lab_initialize(&mut self) {
        let n = self.lab.as_ref().map(|l| l.content.len()).unwrap_or(0);
        if let Some(l) = self.lab.as_mut() {
            l.game = 0;
        }
        for i in 0..MAX_GAMES {
            let slot = self.lab_clip(&format!("navi.games.{}", i));
            let button = self.world.path(slot, "button");
            let title = self.world.path(slot, "titel.title_txt");
            let icon = self.world.path(slot, "titel.icon");
            self.clear_handlers(button);
            if i < n {
                let navi = self.lab.as_ref().unwrap().content[i].info.text("navi");
                self.world.set_var(button, "_visible", Value::Bool(true));
                self.on_clip(button, Evt::Press, move |u| u.lab_show_game(i));
                self.set_html_at(title, &navi, None);
                self.world.set_var(icon, "_visible", Value::Bool(true));
            } else {
                self.world.set_var(button, "_visible", Value::Bool(false));
                self.set_text_at(title, "", None);
                self.world.set_var(icon, "_visible", Value::Bool(false));
            }
        }
        let (up, down) = (self.lab_clip("navi.scroll_up.button"), self.lab_clip("navi.scroll_down.button"));
        if n >= 15 {
            self.on_clip(up, Evt::Press, |u| u.lab_scroll(true));
            self.on_clip(down, Evt::Press, |u| u.lab_scroll(false));
        } else {
            for p in ["navi.scroll_up.button", "navi.scroll_up.pfeil", "navi.scroll_down.button", "navi.scroll_down.pfeil"] {
                let c = self.lab_clip(p);
                self.world.set_var(c, "_visible", Value::Bool(false));
            }
        }
        for (pane, key, kind) in [("info", "labor_main_01_info", "info"), ("screenshots", "labor_main_02_screenshot", "screenshots"), ("video", "labor_main_03_video", "video")] {
            let t = self.lab_text(key);
            let tf = self.lab_clip(&format!("{}.movie.title_txt", pane));
            self.set_text_at(tf, &t, Some(1.0));
            let b = self.lab_clip(&format!("{}.movie.button", pane));
            self.clear_handlers(b);
            self.on_clip(b, Evt::Press, move |u| u.lab_show_player(kind));
        }
        // Chubby's greeting
        let greeting = if n == 24 {
            self.lab_text("labor_greeting_03_elpix")
        } else {
            format!("{}<br />{}", self.lab_text("labor_greeting_01_headline"), self.lab_text("labor_greeting_02_copy").replace("<games_number>", &n.to_string()))
        };
        let target = self.lab_clip("blase.blase.text_txt");
        let done: Option<Handler> = if n > 0 { Some(Rc::new(|u: &mut Ui| u.lab_start_downloads())) } else { None };
        let tid = self.new_ticker(&greeting, target, 1.0, done);
        if let Some(l) = self.lab.as_mut() {
            l.schwabbel = Some(tid);
        }
        self.set_html_at(target, "", None);
        let blase = self.lab_clip("blase");
        self.objs.insert((blase, "ticker".into()), ScriptObj::Ticker(tid));
        let mut h = LHost::default();
        self.world.jump(blase, 2, true, &mut h);
        self.lab_init_downloads();
        let shown = n > 0;
        for p in ["downloads", "info.movie", "video.movie", "screenshots.movie"] {
            let c = self.lab_clip(p);
            self.world.set_var(c, "_visible", Value::Bool(shown));
        }
        self.lab_update_video_tab();
        self.dispatch();
    }

    fn lab_update_video_tab(&mut self) {
        let has_video = self.lab.as_ref().and_then(|l| l.content.get(l.game)).map(|c| c.media.get("video").is_some()).unwrap_or(false);
        let m = self.lab_clip("video.movie");
        self.world.set_var(m, "_visible", Value::Bool(has_video));
    }

    fn lab_scroll(&mut self, up: bool) {
        let n = self.lab.as_ref().map(|l| l.content.len()).unwrap_or(0) as f32;
        let games = self.lab_clip("navi.games");
        let y = self.world.get_var(games, "_y").num() as f32;
        let step = 30.0;
        let top = -446.4 - step;
        let bottom = (top - ((n - 14.0) * step)) + step;
        if up && y < top {
            self.world.set_var(games, "_y", Value::Num((y + step) as f64));
        } else if !up && !(y < bottom) {
            self.world.set_var(games, "_y", Value::Num((y - step) as f64));
        }
    }

    pub fn lab_wheel(&mut self, dy: i32) {
        if self.topic == "lab" && self.lab.as_ref().map(|l| l.content.len() >= 15).unwrap_or(false) {
            self.lab_scroll(dy > 0);
        }
    }

    fn lab_show_game(&mut self, i: usize) {
        self.control_video("stop");
        if let Some(l) = self.lab.as_mut() {
            l.game = i;
        }
        self.lab_show_player("info");
        self.lab_init_downloads();
        self.lab_update_video_tab();
    }

    fn lab_show_player(&mut self, kind: &'static str) {
        self.control_video("stop");
        if let Some(b) = self.effects_bank.files.get("wusch").cloned() {
            if let Ok(p) = self.audio.load(&b) {
                self.audio.play(&p, 0.0, 1, 0.5 * self.audio.master);
            }
        }
        for p in ["screenshots", "info", "video"] {
            let c = self.lab_clip(&format!("player.player.{}", p));
            self.world.set_var(c, "_visible", Value::Bool(false));
        }
        // the pane carries an invisible full-area button that would swallow the tab clicks
        let blocker = self.lab_clip("player.player.button");
        self.world.set_var(blocker, "_visible", Value::Bool(false));
        let outer = self.lab_clip("player");
        let mut h = LHost::default();
        self.world.jump_label(outer, "on", true, &mut h);
        let pane = self.lab_clip(&format!("player.player.{}", kind));
        self.world.set_var(pane, "_visible", Value::Bool(true));
        let (info_title, body, art) = {
            let l = self.lab.as_ref().unwrap();
            let Some(c) = l.content.get(l.game) else { return };
            let navi = c.info.text("navi").replace("<br />", " ");
            let art = self.paths.media().join(&c.name).join(c.media.text("artwork"));
            (navi, c.info.text("body"), art)
        };
        match kind {
            "info" => {
                let t = self.world.path(pane, "title_txt");
                self.set_html_at(t, &format!("INFO: <font color=\"#000000\">{}</font>", info_title), None);
                let b = self.world.path(pane, "body_txt");
                self.set_html_at(b, &body, None);
                let c = self.world.path(pane, "container");
                self.load_image_into(c, &art);
            }
            "screenshots" => self.lab_init_screenshots(pane, &info_title),
            _ => self.lab_init_video(pane, &info_title),
        }
    }

    fn lab_init_screenshots(&mut self, pane: ClipId, title: &str) {
        let t = self.world.path(pane, "title_txt");
        self.set_html_at(t, &format!("SCREENSHOTS: <font color=\"#000000\">{}</font>", title), None);
        let (platform, names, dir) = {
            let l = self.lab.as_ref().unwrap();
            let c = &l.content[l.game];
            let fmt = c.media.get("ss_format").map(|s| s.to_string()).unwrap_or_else(|| c.platform.clone());
            let names: Vec<String> = (1..=MAX_SHOTS).filter_map(|i| c.media.get(&i.to_string()).map(|s| s.to_string())).collect();
            (fmt, names, self.paths.media().join(&c.name))
        };
        let ds = platform == "ds";
        for (n, vis) in [("container_ds", ds), ("navi_ds", ds), ("container_wii", !ds), ("navi_wii", !ds)] {
            let c = self.world.path(pane, n);
            self.world.set_var(c, "_visible", Value::Bool(vis));
        }
        let container = self.world.path(pane, if ds { "container_ds" } else { "container_wii" });
        let navi = self.world.path(pane, if ds { "navi_ds" } else { "navi_wii" });
        // drop the previous set
        let old: Vec<ClipId> = self.lab.as_mut().map(|l| std::mem::take(&mut l.shots)).unwrap_or_default();
        for o in old {
            self.clear_image_clip(o);
            self.world.remove(o);
        }
        self.world.clear_children(container);
        let mut clips = Vec::new();
        for (i, n) in names.iter().enumerate() {
            let c = self.world.create_empty(container, &format!("shot {}", i + 1), i as i32 + 1);
            self.load_image_into(c, &dir.join(n));
            if i != 0 {
                self.world.set_var(c, "_visible", Value::Bool(false));
            }
            clips.push(c);
        }
        let count = clips.len();
        if let Some(l) = self.lab.as_mut() {
            l.shots = clips;
            l.cur_shot = 1;
        }
        let disp = self.world.path(navi, "display_txt");
        self.set_text_at(disp, &format!("1 / {}", count), None);
        for (which, fwd) in [("prev", false), ("next", true)] {
            let b = self.world.path(navi, &format!("{}.button", which));
            let m = self.world.path(navi, which);
            self.clear_handlers(b);
            self.on_clip(b, Evt::Press, move |u| u.lab_show_shot(fwd, m, disp));
        }
    }

    fn lab_show_shot(&mut self, fwd: bool, mc: ClipId, disp: ClipId) {
        let (n, cur) = {
            let l = self.lab.as_ref().unwrap();
            (l.shots.len(), l.cur_shot)
        };
        if n == 0 {
            return;
        }
        let old = self.lab.as_ref().unwrap().shots[cur - 1];
        self.world.set_var(old, "_visible", Value::Bool(false));
        let new = if fwd { if cur + 1 > n { 1 } else { cur + 1 } } else if cur <= 1 { n } else { cur - 1 };
        let c = self.lab.as_ref().unwrap().shots[new - 1];
        self.world.set_var(c, "_visible", Value::Bool(true));
        self.lab.as_mut().unwrap().cur_shot = new;
        let mut h = LHost::default();
        self.world.jump_label(mc, "press", false, &mut h);
        self.set_text_at(disp, &format!("{} / {}", new, n), None);
    }

    fn lab_init_video(&mut self, pane: ClipId, title: &str) {
        let (path, lang_code) = {
            let l = self.lab.as_ref().unwrap();
            let c = &l.content[l.game];
            let mut f = c.media.text("video");
            if !f.contains(".flv") {
                f = format!("{}_{}.flv", f, self.paths.lang.code());
            }
            (self.paths.media().join(&c.name).join(f), self.paths.lang.code())
        };
        let _ = lang_code;
        let t = self.world.path(pane, "title_txt");
        self.set_html_at(t, &format!("VIDEO: <font color=\"#000000\">{}</font>", title), None);
        let close = self.world.path(pane, "close_button");
        self.clear_handlers(close);
        self.on_clip(close, Evt::Press, |u| u.control_video("stop"));
        let pp = self.world.path(pane, "play_pause");
        self.clear_handlers(pp);
        self.on_clip(pp, Evt::Press, |u| {
            let paused = u.lab.as_ref().and_then(|l| l.video.as_ref()).map(|v| v.paused).unwrap_or(false);
            u.control_video(if paused { "play" } else { "pause" });
        });
        let container = self.world.path(pane, "container");
        let mut vp = match VideoPlayer::open(&path, &mut self.rd, &mut self.audio) {
            Some(v) => v,
            None => {
                log::warn!("cannot open video {}", path.display());
                return;
            }
        };
        // the video object keeps its authored size
        let (cw, ch) = {
            let c = self.world.clip(container).unwrap();
            match self.world.libs[c.lib as usize].lib.chars.get(&c.cid) {
                Some(snow_fmt::Char::Video { width, height }) => (*width as f32, *height as f32),
                _ => (vp.w as f32, vp.h as f32),
            }
        };
        self.world.set_image(container, vp.tex, vp.w, vp.h);
        if let Some(c) = self.world.clip_mut(container) {
            // the video object keeps its authored size; the stream is scaled to fit it
            c.m.a *= cw / vp.w as f32;
            c.m.d *= ch / vp.h as f32;
            c.visible = true;
        }
        vp.paused = false;
        let mut h = LHost::default();
        self.world.jump_label(pp, "on_play", false, &mut h);
        self.lounge_fade_to(0.0);
        if let Some(l) = self.lab.as_mut() {
            l.video = Some(vp);
            l.video_clip = container;
        }
    }

    pub fn control_video(&mut self, action: &str) {
        let Some(l) = self.lab.as_mut() else { return };
        let pp = l.root;
        match action {
            "pause" | "play" => {
                if let Some(v) = l.video.as_mut() {
                    v.set_paused(&self.audio, action == "pause");
                }
                let pp = self.world.path(pp, "player.player.video.play_pause");
                let mut h = LHost::default();
                self.world.jump_label(pp, if action == "pause" { "on_pause" } else { "on_play" }, false, &mut h);
            }
            "stop" => {
                if let Some(mut v) = l.video.take() {
                    v.stop(&self.audio, &mut self.rd);
                    let vc = l.video_clip;
                    if self.world.alive(vc) {
                        self.world.clear_image(vc);
                        self.world.set_var(vc, "_visible", Value::Bool(false));
                    }
                    self.lounge_fade_to(30.0);
                }
            }
            _ => {}
        }
    }

    pub fn lab_tick(&mut self) {
        let mut restart = None;
        if let Some(l) = self.lab.as_mut() {
            if let Some(v) = l.video.as_mut() {
                v.update(&mut self.rd, &self.audio);
                // progress marker
                let t = v.position();
                let d = v.duration.max(1.0);
                let ended = v.ended;
                let root = l.root;
                let ptr = self.world.path(root, "player.player.video.slider.pointer");
                self.world.set_var(ptr, "_x", Value::Num((t / d * 100.0 * 3.18) as f64));
                if ended || t >= d {
                    restart = Some(v.path.clone());
                }
            }
        }
        if let Some(_p) = restart {
            // the original rewinds and keeps playing
            let pane = self.lab_clip("player.player.video");
            let title = self.lab.as_ref().and_then(|l| l.content.get(l.game)).map(|c| c.info.text("navi").replace("<br />", " ")).unwrap_or_default();
            self.control_video("stop");
            self.lab_init_video(pane, &title);
        }
    }

    // ---------------------------------------------------------- downloads

    fn lab_init_downloads(&mut self) {
        let Some(l) = self.lab.as_ref() else { return };
        let Some(c) = l.content.get(l.game) else { return };
        let (media, name) = (c.media.clone(), c.name.clone());
        let dl = self.lab_clip("downloads");
        let tx = self.world.path(dl, "text_txt");
        self.lab_stop_tickers();
        let hello = format!("{}<br /><br />{}", self.lab_text("labor_downloads_01_headline"), self.lab_text("labor_downloads_02_copy"));
        let specs = [
            ("", "ticker_hello", hello),
            ("wallpapers", "ticker_wp1", self.lab_text("labor_downloads_03_wallpaper1")),
            ("wallpapers", "ticker_wp2", self.lab_text("labor_downloads_04_wallpaper2")),
            ("handy", "ticker_handy", self.lab_text("labor_downloads_05_mp3")),
            ("icons", "ticker_icons", self.lab_text("labor_downloads_06_icon")),
        ];
        let mut ids = Vec::new();
        for (owner, var, text) in specs {
            let o = if owner.is_empty() { dl } else { self.world.path(dl, owner) };
            let id = self.new_ticker(&text, tx, 0.7, None);
            self.objs.insert((o, var.to_string()), ScriptObj::Ticker(id));
            ids.push(id);
        }
        if let Some(l) = self.lab.as_mut() {
            l.tickers = ids;
        }
        let wtxt = self.world.path(dl, "wallpapers.wallpapers_txt");
        let t = self.lab_text("labor_downloads_03_wallpaper");
        self.set_html_at(wtxt, &t, None);
        let suffix = if media.get("wallpaper_language") == Some("true") { format!("_{}.zip", self.paths.lang.code()) } else { ".zip".to_string() };
        let dir = self.paths.media().join(&name);
        for (btn, key) in [("wp_1", "800x600"), ("wp_2", "1024x768"), ("wp_3", "1280x1024")] {
            let b = self.world.path(dl, &format!("wallpapers.{}", btn));
            let file = dir.join(format!("{}{}", media.text(key), suffix));
            self.clear_handlers(b);
            self.on_clip(b, Evt::Press, move |u| u.download(&file));
        }
        for (owner, key) in [("handy", "handy"), ("icons", "icons")] {
            if let Some(f) = media.get(key) {
                let b = self.world.path(dl, &format!("{}.button", owner));
                let file = dir.join(f);
                self.clear_handlers(b);
                self.on_clip(b, Evt::Press, move |u| u.download(&file));
            }
        }
        // the 576 download is a reward for collecting every crystal
        let door = None;
        if self.save.complete_576(door) {
            let d = self.world.path(dl, "download_576");
            self.world.set_var(d, "_visible", Value::Bool(true));
            let b = self.world.path(d, "button");
            let file = self.paths.media().join("26_576/MIS_Downloads.zip");
            self.clear_handlers(b);
            self.on_clip(b, Evt::Press, move |u| u.download(&file));
        }
    }

    fn lab_start_downloads(&mut self) {
        let dl = self.lab_clip("downloads");
        let mut h = LHost::default();
        self.world.jump_label(dl, "start", true, &mut h);
    }

    /// Download tab scripts: reset the neighbouring tabs and start this tab's speech.
    pub fn lab_download_tab(&mut self, clip: ClipId, name: &str) {
        let h = &mut LHost::default();
        self.world.set_var(clip, "init", Value::Bool(true));
        self.lab_stop_tickers_keep();
        let parent = self.world.clip(clip).map(|c| c.parent).unwrap_or(NONE);
        let txt = self.world.path(parent, "text_txt");
        self.set_html_at(txt, "", None);
        self.world.jump_label(parent, "blase", false, h);
        let wp = self.world.path(parent, "wallpapers");
        if wp == NONE || self.world.get_var(wp, "active").truthy() {
            self.world.jump_label(wp, "empty", false, h);
        }
        self.world.set_var(wp, "init", Value::Undef);
        let (other, ticker) = if name == "script:25386a95" { ("icons", "ticker_handy") } else { ("handy", "ticker_icons") };
        let o = self.world.path(parent, other);
        self.world.set_var(o, "init", Value::Undef);
        let key = (clip, ticker.to_string());
        if let Some(ScriptObj::Ticker(id)) = self.objs.get(&key) {
            let id = *id;
            self.ticker_begin(id);
        }
        self.world.set_playing(clip, false);
    }

    fn lab_stop_tickers_keep(&mut self) {
        // stopTicker(): every speech ticker but the greeting
        let ids: Vec<u32> = self.lab.as_ref().map(|l| l.tickers.clone()).unwrap_or_default();
        for id in ids {
            self.stop_ticker(id);
        }
    }

    pub fn lab_exit_door(&mut self, clip: ClipId) {
        let door = self.world.path(clip, "door");
        let mut h = LHost::default();
        self.world.jump_label(door, "close", true, &mut h);
        let btn = self.world.path(clip, "exit_button");
        self.on_clip(btn, Evt::RollOver, move |u| {
            let d = u.world.path(clip, "door");
            u.world.jump_label(d, "open", true, &mut LHost::default());
        });
        self.on_clip(btn, Evt::RollOut, move |u| {
            let d = u.world.path(clip, "door");
            u.world.jump_label(d, "close", true, &mut LHost::default());
        });
    }
}
