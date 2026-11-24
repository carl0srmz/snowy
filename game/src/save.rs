//! Persistent progress (the original's Flash SharedObject "upixo").
use serde::{Deserialize, Serialize};
use std::path::PathBuf;

#[derive(Serialize, Deserialize, Clone, Debug)]
pub struct Save {
    pub intro: bool,
    pub visits: u32,
    pub container: [bool; 4],
    /// per door: None = not played, Some(bonus_crystals_collected)
    pub doors: Vec<Option<bool>>,
    /// level numbers (0-based) whose files were found, in discovery order
    pub lab: Vec<u32>,
    #[serde(skip)]
    path: Option<PathBuf>,
}

impl Default for Save {
    fn default() -> Self {
        Save { intro: false, visits: 0, container: [false; 4], doors: vec![None; 25], lab: Vec::new(), path: None }
    }
}

pub fn data_dir() -> PathBuf {
    if let Some(d) = std::env::var_os("SNOWDRIFT_DATA") {
        return PathBuf::from(d);
    }
    if let Some(d) = std::env::var_os("XDG_DATA_HOME") {
        return PathBuf::from(d).join("snowdrift");
    }
    if let Some(d) = std::env::var_os("APPDATA") {
        return PathBuf::from(d).join("snowdrift");
    }
    let home = std::env::var_os("HOME").map(PathBuf::from).unwrap_or_else(|| PathBuf::from("."));
    if cfg!(target_os = "macos") {
        home.join("Library/Application Support/snowdrift")
    } else {
        home.join(".local/share/snowdrift")
    }
}

impl Save {
    pub fn load() -> Save {
        let path = data_dir().join("save.json");
        let mut s: Save = std::fs::read_to_string(&path).ok().and_then(|t| serde_json::from_str(&t).ok()).unwrap_or_default();
        s.doors.resize(25, None);
        s.path = Some(path);
        s
    }

    pub fn flush(&self) {
        if let Some(p) = &self.path {
            if let Some(d) = p.parent() {
                let _ = std::fs::create_dir_all(d);
            }
            if let Ok(t) = serde_json::to_string_pretty(self) {
                let _ = std::fs::write(p, t);
            }
        }
    }

    pub fn visited(&mut self) {
        self.visits += 1;
        self.intro = true;
        self.flush();
    }

    pub fn show_intro_again(&mut self) {
        self.intro = false;
        self.flush();
    }

    /// Upixo.played(door, bonus, container)
    pub fn played(&mut self, door: usize, bonus: bool, container: bool) {
        if self.doors[door].is_none() || (self.doors[door] == Some(false) && bonus) {
            self.doors[door] = Some(bonus);
        }
        if !self.lab.contains(&(door as u32)) && door < 24 {
            self.lab.push(door as u32);
        }
        if container {
            let w = match door + 1 {
                1..=6 => 0,
                7..=12 => 1,
                13..=18 => 2,
                _ => 3,
            };
            self.container[w] = true;
        }
        self.flush();
    }

    pub fn check_container(&self, day: usize) -> bool {
        match day {
            1..=6 => self.container[0],
            7..=12 => self.container[1],
            13..=18 => self.container[2],
            19..=24 => self.container[3],
            _ => false,
        }
    }

    pub fn ready_for_elpix(&self) -> bool {
        (0..24).all(|i| self.doors[i].is_some())
    }

    /// `is576`: every door except `level` (0-based) was completed with all 24 crystals.
    pub fn complete_576(&self, level: Option<usize>) -> bool {
        (0..24).all(|i| self.doors[i] == Some(true) || Some(i) == level)
    }

    /// Debug/test unlock: the original's cookie button (`upixo.test(23, true)`).
    pub fn test_unlock(&mut self, days: usize, bonus: bool) {
        for i in 0..25 {
            self.doors[i] = if i < days { Some(bonus) } else { None };
        }
        self.lab = (0..days as u32).collect();
        self.container = [true; 4];
        self.flush();
    }
}
