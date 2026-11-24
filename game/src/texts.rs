//! Localised text files (`data/text/<lang>/*.xml`) and the other small XML config files.
use std::collections::HashMap;
use std::path::{Path, PathBuf};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Lang {
    En,
    De,
    Fr,
    Nl,
}

impl Lang {
    /// Folder under data/text (the repository ships English as `ger` and German as `ger2`).
    pub fn folder(self) -> &'static str {
        match self {
            Lang::En => "ger",
            Lang::De => "ger2",
            Lang::Fr => "fra",
            Lang::Nl => "ned",
        }
    }
    /// The original's language code (used in media file names such as `*_ger.flv`).
    pub fn code(self) -> &'static str {
        match self {
            Lang::En => "eng",
            Lang::De => "ger",
            Lang::Fr => "fra",
            Lang::Nl => "ned",
        }
    }
    pub fn parse(s: &str) -> Option<Lang> {
        let s = s.to_lowercase();
        Some(match &s[..s.len().min(3)] {
            "en" | "eng" => Lang::En,
            "de" | "ger" | "deu" => Lang::De,
            "fr" | "fra" => Lang::Fr,
            "nl" | "ned" | "dut" | "nld" => Lang::Nl,
            _ => return None,
        })
    }
    pub fn detect() -> Lang {
        for k in ["SNOWDRIFT_LANG", "LC_ALL", "LC_MESSAGES", "LANG"] {
            if let Ok(v) = std::env::var(k) {
                if let Some(l) = Lang::parse(&v) {
                    return l;
                }
            }
        }
        Lang::En
    }
}

/// name -> text of every element carrying a `name` attribute (XMLUtil.getValueByName).
#[derive(Default, Clone)]
pub struct XmlValues {
    pub map: HashMap<String, String>,
    pub raw: String,
}

impl XmlValues {
    pub fn load(path: &Path) -> XmlValues {
        match std::fs::read_to_string(path) {
            Ok(t) => XmlValues::parse(&t),
            Err(_) => XmlValues::default(),
        }
    }

    pub fn parse(t: &str) -> XmlValues {
        let mut map = HashMap::new();
        if let Ok(doc) = roxmltree::Document::parse(t) {
            for n in doc.descendants().filter(|n| n.is_element()) {
                if let Some(name) = n.attribute("name") {
                    let text: String = n.children().filter(|c| c.is_text()).map(|c| c.text().unwrap_or("")).collect();
                    map.entry(name.to_string()).or_insert(text);
                }
            }
        }
        XmlValues { map, raw: t.to_string() }
    }

    pub fn get(&self, name: &str) -> Option<&str> {
        self.map.get(name).map(|s| s.as_str())
    }

    pub fn text(&self, name: &str) -> String {
        self.get(name).unwrap_or("").to_string()
    }
}

pub struct Paths {
    pub repo: PathBuf,
    pub lang: Lang,
}

impl Paths {
    pub fn data(&self) -> PathBuf {
        self.repo.join("data")
    }
    pub fn text(&self, file: &str) -> XmlValues {
        XmlValues::load(&self.data().join("text").join(self.lang.folder()).join(file))
    }
    pub fn media(&self) -> PathBuf {
        self.data().join("K8dD6H3hDJ3DF")
    }
}
