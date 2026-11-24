//! Lowers the original AVM1 timeline scripts into the closed `Op` set.
//!
//! Scripts are decompiled to pseudo-ActionScript first (see `decomp`), normalised, and
//! then pattern matched. Anything that is not a plain statement ends up as a named
//! `Behavior` (implemented natively in the game) or as `Unknown` for diagnostics.
use regex::Regex;
use snow_fmt::{Op, Val};
use std::collections::HashMap;
use std::sync::OnceLock;

pub fn lower(data: &[u8], version: u8) -> Vec<Op> {
    let text = crate::decomp::decompile_tag(data, version, &[], HashMap::new(), 0);
    lower_text(&text)
}

/// Stable id for a script that is implemented natively (`script:xxxxxxxx`).
pub fn script_id(text: &str) -> String {
    let flat = text.split_whitespace().collect::<Vec<_>>().join(" ");
    format!("script:{:08x}", fnv(&flat))
}

struct Res {
    set: Regex,
    call: Regex,
    goto_frame: Regex,
    goto_label: Regex,
}

fn res() -> &'static Res {
    static R: OnceLock<Res> = OnceLock::new();
    R.get_or_init(|| Res {
        set: Regex::new(r#"^((?:[A-Za-z_][A-Za-z_0-9]*\.)*)([A-Za-z_][A-Za-z_0-9]*) = (true|false|null|undefined|-?[0-9]+(?:\.[0-9]+)?|"[^"]*"|[A-Za-z_][A-Za-z_0-9]*(?:\.[A-Za-z_][A-Za-z_0-9]*)*);$"#).unwrap(),
        call: Regex::new(r#"^((?:[A-Za-z_][A-Za-z_0-9]*\.)*)([A-Za-z_][A-Za-z_0-9]*)\(((?:(?:true|false|null|undefined|-?[0-9]+(?:\.[0-9]+)?|"[^"]*"|[A-Za-z_][A-Za-z_0-9]*(?:\.[A-Za-z_][A-Za-z_0-9]*)*)(?:, )?)*)\);$"#).unwrap(),
        goto_frame: Regex::new(r"^gotoFrame\((\d+)\);$").unwrap(),
        goto_label: Regex::new(r#"^gotoLabel\("([^"]*)"\);$"#).unwrap(),
    })
}

fn parse_val(s: &str) -> Val {
    match s {
        "true" => Val::Bool(true),
        "false" => Val::Bool(false),
        "null" => Val::Null,
        "undefined" => Val::Undefined,
        _ if s.starts_with('"') => Val::Str(s[1..s.len() - 1].to_string()),
        _ => match s.parse::<f64>() {
            Ok(n) => Val::Num(n),
            Err(_) => Val::Path(s.to_string()),
        },
    }
}

fn split_args(s: &str) -> Vec<String> {
    let mut out = Vec::new();
    let mut cur = String::new();
    let mut in_str = false;
    for ch in s.chars() {
        if ch == '"' {
            in_str = !in_str;
        }
        if ch == ',' && !in_str {
            out.push(cur.trim().to_string());
            cur.clear();
        } else {
            cur.push(ch);
        }
    }
    if !cur.trim().is_empty() {
        out.push(cur.trim().to_string());
    }
    out
}

fn fnv(s: &str) -> u32 {
    let mut h = 0x811c9dc5u32;
    for b in s.bytes() {
        h ^= b as u32;
        h = h.wrapping_mul(16777619);
    }
    h
}

fn norm_target(t: &str) -> String {
    let t = t.trim_end_matches('.');
    let t = t.strip_prefix("this.").unwrap_or(t);
    if t == "this" { String::new() } else { t.to_string() }
}

/// Removes a `name = function (...) { ... };` block (balanced braces) and returns its body.
fn take_closure(text: &mut String, head: &str) -> Option<String> {
    let start = text.find(head)?;
    let open = start + text[start..].find('{')?;
    let mut depth = 0;
    let mut end = open;
    for (i, c) in text[open..].char_indices() {
        if c == '{' {
            depth += 1;
        } else if c == '}' {
            depth -= 1;
            if depth == 0 {
                end = open + i;
                break;
            }
        }
    }
    let body = text[open + 1..end].to_string();
    let mut cut_end = end + 1;
    if text[cut_end..].starts_with(';') {
        cut_end += 1;
    }
    text.replace_range(start..cut_end, "");
    Some(body)
}

fn closure_summary(body: &str) -> String {
    body.lines()
        .map(|l| l.trim())
        .filter(|l| !l.is_empty())
        .map(|l| l.trim_end_matches(';').replace('"', "").replace("this.", ""))
        .collect::<Vec<_>>()
        .join(",")
}

pub fn lower_text(text: &str) -> Vec<Op> {
    let mut t = text.to_string();
    let mut ops: Vec<Op> = Vec::new();

    // closures the game implements natively
    let _ = take_closure(&mut t, "resume = function");
    if let Some(b) = take_closure(&mut t, "actor.die = function") {
        ops.push(Op::Behavior(format!("die:{}", closure_summary(&b))));
        t = t.replace("actor = new Object();", "");
    }
    if let Some(b) = take_closure(&mut t, "event = function") {
        ops.push(Op::Behavior(format!("event:{}", closure_summary(&b))));
    }
    // editor-only switches: the shipped game always runs with _root.editor unset
    let editor_else = Regex::new(r"if \(_root\.editor\) \{\n\s*stop\(\);\n\s*\} else \{\n((?s).*?)\n\s*\}").unwrap();
    t = editor_else.replace_all(&t, "$1").to_string();
    let editor = Regex::new(r"if \(_root\.editor\) \{\n\s*stop\(\);\n\s*\}").unwrap();
    t = editor.replace_all(&t, "").to_string();
    // trace output is dropped
    let trace = Regex::new(r"(?m)^\s*trace\(.*\);\s*$").unwrap();
    t = trace.replace_all(&t, "").to_string();

    // well-known templates
    let auto = Regex::new(r#"if \(!!!\(this\._name\.indexOf\("instance"\) == -1\)\) \{\n\s*this\._name = "(\w+)";\n\s*\}"#).unwrap();
    if let Some(c) = auto.captures(&t) {
        ops.push(Op::Behavior(format!("autoname:{}", &c[1])));
        t = auto.replace_all(&t, "").to_string();
    }
    let defoff = Regex::new(r"if \(offset == undefined\) \{\n\s*offset = (\d+);\n\s*\}").unwrap();
    if let Some(c) = defoff.captures(&t) {
        ops.push(Op::Behavior(format!("default_offset:{}", &c[1])));
        t = defoff.replace_all(&t, "").to_string();
    }
    let skin = Regex::new(r"(?m)^\s*mx\.skins\..*$").unwrap();
    t = skin.replace_all(&t, "").to_string();
    let sync = Regex::new(r"_root\.(coin|water|bee|cloud)frame").unwrap();
    if t.contains("init == undefined") && sync.is_match(&t) {
        let which = sync.captures(&t).unwrap()[1].to_string();
        let plus = if t.contains("var frame") { "+1" } else { "" };
        return vec![Op::Behavior(format!("sync:{}{}", which, plus))];
    }

    let r = res();
    let mut unknown = false;
    for line in t.lines() {
        let l = line.trim();
        if l.is_empty() {
            continue;
        }
        if l == "stop();" {
            ops.push(Op::Stop);
        } else if l == "play();" {
            ops.push(Op::Play);
        } else if l == "nextFrame();" {
            ops.push(Op::NextFrame);
        } else if l == "prevFrame();" {
            ops.push(Op::PrevFrame);
        } else if let Some(c) = r.goto_frame.captures(l) {
            ops.push(Op::GotoFrame(c[1].parse::<u16>().unwrap_or(0) + 1));
        } else if let Some(c) = r.goto_label.captures(l) {
            ops.push(Op::GotoLabel(c[1].to_string()));
        } else if let Some(c) = r.set.captures(l) {
            ops.push(Op::Set { target: norm_target(&c[1]), name: c[2].to_string(), val: parse_val(&c[3]) });
        } else if let Some(c) = r.call.captures(l) {
            let args = split_args(&c[3]).iter().map(|a| parse_val(a)).collect();
            ops.push(Op::Call { target: norm_target(&c[1]), name: c[2].to_string(), args });
        } else {
            unknown = true;
        }
    }
    if unknown {
        // Known multi-line behaviours are named; the rest is kept for diagnostics.
        let flat = t.split_whitespace().collect::<Vec<_>>().join(" ");
        let _ = flat;
        let body = t.trim().to_string();
        let mut out = ops;
        out.push(Op::Unknown(body));
        return out;
    }
    ops
}
