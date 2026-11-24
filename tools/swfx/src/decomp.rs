//! A small AVM1 -> pseudo-ActionScript decompiler. It exists so the original
//! game rules (physics, collision, enemy AI, ...) can be read and then
//! re-implemented by hand in Rust; nothing here ships in the game itself.
use std::collections::HashMap;
use swf::avm1::read::Reader;
use swf::avm1::types::{Action, FunctionFlags, Value};
use swf::SwfStr;

fn s(x: &SwfStr) -> String {
    x.to_string_lossy(swf::UTF_8)
}

#[derive(Clone, Debug)]
struct Ex {
    s: String,
    lit: Option<String>,
    simple: bool,
}

impl Ex {
    fn simple(s: impl Into<String>) -> Ex {
        Ex { s: s.into(), lit: None, simple: true }
    }
    fn compound(s: impl Into<String>) -> Ex {
        Ex { s: s.into(), lit: None, simple: false }
    }
    fn paren(&self) -> String {
        if self.simple { self.s.clone() } else { format!("({})", self.s) }
    }
}

struct Ins<'a> {
    pos: usize,
    end: usize,
    a: Action<'a>,
}

struct Dec<'a> {
    ins: Vec<Ins<'a>>,
    idx_of: HashMap<usize, usize>,
    pool: Vec<String>,
    regs: HashMap<u8, String>,
    version: u8,
    loops: HashMap<usize, usize>, // start idx -> end idx (the backward branch)
    out: String,
    failed: bool,
}

fn is_ident(x: &str) -> bool {
    let mut c = x.chars();
    match c.next() {
        Some(f) if f.is_alphabetic() || f == '_' || f == '$' => {}
        _ => return false,
    }
    c.all(|c| c.is_alphanumeric() || c == '_' || c == '$')
}

fn quote(x: &str) -> String {
    format!("\"{}\"", x.replace('\\', "\\\\").replace('"', "\\\"").replace('\n', "\\n").replace('\r', "\\r"))
}

fn fmt_num(d: f64) -> String {
    if d.fract() == 0.0 && d.abs() < 1e15 {
        format!("{}", d as i64)
    } else {
        format!("{}", d)
    }
}

fn neg(e: &Ex) -> String {
    // strip a leading `!` if the expression is exactly a negation
    if let Some(rest) = e.s.strip_prefix('!') {
        if e.simple || rest.starts_with('(') {
            let r = rest.trim();
            if r.starts_with('(') && r.ends_with(')') && balanced(&r[1..r.len() - 1]) {
                return r[1..r.len() - 1].to_string();
            }
            if is_simple_chain(r) {
                return r.to_string();
            }
        }
    }
    if e.simple { format!("!{}", e.s) } else { format!("!({})", e.s) }
}

fn is_simple_chain(r: &str) -> bool {
    !r.contains(' ')
}

fn balanced(x: &str) -> bool {
    let mut d = 0i32;
    for c in x.chars() {
        if c == '(' { d += 1 }
        if c == ')' { d -= 1; if d < 0 { return false } }
    }
    d == 0
}

fn prop_name(i: i64) -> &'static str {
    [
        "_x", "_y", "_xscale", "_yscale", "_currentframe", "_totalframes", "_alpha", "_visible", "_width", "_height",
        "_rotation", "_target", "_framesloaded", "_name", "_droptarget", "_url", "_highquality", "_focusrect",
        "_soundbuftime", "_quality", "_xmouse", "_ymouse",
    ]
    .get(i as usize)
    .copied()
    .unwrap_or("_prop?")
}

pub fn decompile_tag(data: &[u8], version: u8, pool: &[String], regs: HashMap<u8, String>, ind: usize) -> String {
    let mut d = Dec::new(data, version, pool.to_vec(), regs);
    let mut st = Vec::new();
    let n = d.ins.len();
    d.run(0, n, &mut st, &[], ind);
    d.out
}

impl<'a> Dec<'a> {
    fn new(data: &'a [u8], version: u8, pool: Vec<String>, regs: HashMap<u8, String>) -> Dec<'a> {
        let mut r = Reader::new(data, version);
        let mut ins = Vec::new();
        loop {
            let pos = r.get_ref().as_ptr() as usize - data.as_ptr() as usize;
            match r.read_action() {
                Ok(Action::End) => break,
                Ok(a) => {
                    let end = r.get_ref().as_ptr() as usize - data.as_ptr() as usize;
                    ins.push(Ins { pos, end, a });
                }
                Err(_) => break,
            }
            if r.get_ref().is_empty() {
                break;
            }
        }
        let idx_of = ins.iter().enumerate().map(|(i, x)| (x.pos, i)).collect();
        let mut d = Dec { ins, idx_of, pool, regs, version, loops: HashMap::new(), out: String::new(), failed: false };
        d.find_loops();
        d
    }

    fn target(&self, i: usize) -> Option<usize> {
        let ins = &self.ins[i];
        let off = match &ins.a {
            Action::Jump(j) => j.offset,
            Action::If(j) => j.offset,
            _ => return None,
        };
        let tpos = (ins.end as isize + off as isize) as usize;
        match self.idx_of.get(&tpos) {
            Some(i) => Some(*i),
            None => Some(self.ins.len()), // jump to end
        }
    }

    fn find_loops(&mut self) {
        for i in 0..self.ins.len() {
            if matches!(self.ins[i].a, Action::Jump(_) | Action::If(_)) {
                if let Some(t) = self.target(i) {
                    if t <= i {
                        let e = self.loops.entry(t).or_insert(i);
                        if i > *e {
                            *e = i;
                        }
                    }
                }
            }
        }
    }

    fn pop(&mut self, st: &mut Vec<Ex>) -> Ex {
        match st.pop() {
            Some(e) => e,
            None => {
                self.failed = true;
                Ex::simple("<stack?>")
            }
        }
    }

    fn line(&mut self, ind: usize, text: &str) {
        for l in text.lines() {
            for _ in 0..ind {
                self.out.push_str("    ");
            }
            self.out.push_str(l);
            self.out.push('\n');
        }
    }

    fn member(&self, obj: &Ex, name: &Ex) -> String {
        match &name.lit {
            Some(n) if is_ident(n) => format!("{}.{}", obj.paren(), n),
            _ => format!("{}[{}]", obj.paren(), name.s),
        }
    }

    fn push_value(&self, v: &Value) -> Ex {
        match v {
            Value::Undefined => Ex::simple("undefined"),
            Value::Null => Ex::simple("null"),
            Value::Bool(b) => Ex::simple(b.to_string()),
            Value::Int(i) => Ex::simple(i.to_string()),
            Value::Float(f) => Ex::simple(fmt_num(*f as f64)),
            Value::Double(f) => Ex::simple(fmt_num(*f)),
            Value::Str(x) => {
                let t = s(x);
                Ex { s: quote(&t), lit: Some(t), simple: true }
            }
            Value::ConstantPool(i) => {
                let t = self.pool.get(*i as usize).cloned().unwrap_or_else(|| format!("<pool{}>", i));
                Ex { s: quote(&t), lit: Some(t), simple: true }
            }
            Value::Register(r) => Ex::simple(self.regs.get(r).cloned().unwrap_or_else(|| format!("$r{}", r))),
        }
    }

    fn args(&mut self, st: &mut Vec<Ex>) -> Vec<String> {
        let n = self.pop(st);
        let n: usize = n.s.parse().unwrap_or(0);
        let mut v = Vec::new();
        for _ in 0..n {
            v.push(self.pop(st).s);
        }
        v
    }

    fn func(&mut self, name: &str, params: Vec<(String, Option<u8>)>, flags: Option<FunctionFlags>, body: &[u8], ind: usize) -> Ex {
        let mut regs: HashMap<u8, String> = HashMap::new();
        if let Some(f) = flags {
            let mut r = 1u8;
            let order = [
                (FunctionFlags::PRELOAD_THIS, "this"),
                (FunctionFlags::PRELOAD_ARGUMENTS, "arguments"),
                (FunctionFlags::PRELOAD_SUPER, "super"),
                (FunctionFlags::PRELOAD_ROOT, "_root"),
                (FunctionFlags::PRELOAD_PARENT, "_parent"),
                (FunctionFlags::PRELOAD_GLOBAL, "_global"),
            ];
            for (fl, nm) in order {
                if f.contains(fl) {
                    regs.insert(r, nm.to_string());
                    r += 1;
                }
            }
        }
        for (n, r) in &params {
            if let Some(r) = r {
                regs.insert(*r, n.clone());
            }
        }
        let inner = decompile_tag(body, self.version, &self.pool, regs, ind + 1);
        let mut t = String::new();
        t.push_str(&format!("function {}({}) {{\n", name, params.iter().map(|p| p.0.clone()).collect::<Vec<_>>().join(", ")));
        t.push_str(&inner);
        for _ in 0..ind {
            t.push_str("    ");
        }
        t.push('}');
        Ex::compound(t)
    }

    fn sub_expr(&mut self, lo: usize, hi: usize, st: &[Ex], ctrl: &[(usize, usize)]) -> Option<Ex> {
        let saved_out = std::mem::take(&mut self.out);
        let saved_failed = self.failed;
        self.failed = false;
        let mut tmp: Vec<Ex> = Vec::new();
        let _ = st;
        self.run(lo, hi, &mut tmp, ctrl, 0);
        let ok = !self.failed && self.out.trim().is_empty() && tmp.len() == 1;
        self.out = saved_out;
        self.failed = saved_failed;
        if ok { tmp.pop() } else { None }
    }

    fn run(&mut self, lo: usize, hi: usize, st: &mut Vec<Ex>, ctrl: &[(usize, usize)], ind: usize) {
        let mut i = lo;
        while i < hi {
            // loop start?
            if let Some(&end) = self.loops.get(&i) {
                let is_current = ctrl.last().map(|c| c.0 == i).unwrap_or(false);
                if !is_current && end < self.ins.len() {
                    i = self.emit_loop(i, end, st, ctrl, ind);
                    continue;
                }
            }
            let a = unsafe { &*(&self.ins[i].a as *const Action) };
            match a {
                Action::ConstantPool(cp) => {
                    self.pool = cp.strings.iter().map(|x| s(x)).collect();
                }
                Action::Push(p) => {
                    for v in &p.values {
                        let e = self.push_value(v);
                        st.push(e);
                    }
                }
                Action::PushDuplicate => {
                    let t = st.last().cloned().unwrap_or_else(|| Ex::simple("<stack?>"));
                    st.push(t);
                }
                Action::Pop => {
                    let e = self.pop(st);
                    let bare_reg = e.s.starts_with("$r") && e.s[2..].chars().all(|c| c.is_ascii_digit());
                    if !is_ident(&e.s) && e.lit.is_none() && !bare_reg {
                        self.line(ind, &format!("{};", strip(&e.s)));
                    }
                }
                Action::StackSwap => {
                    let a = self.pop(st);
                    let b = self.pop(st);
                    st.push(a);
                    st.push(b);
                }
                Action::StoreRegister(r) => {
                    let top = self.pop(st);
                    let name = self.regs.get(&r.register).cloned().unwrap_or_else(|| format!("$r{}", r.register));
                    self.regs.entry(r.register).or_insert_with(|| name.clone());
                    if top.s != name {
                        self.line(ind, &format!("{} = {};", name, strip(&top.s)));
                    }
                    st.push(Ex::simple(name));
                }
                Action::GetVariable => {
                    let n = self.pop(st);
                    st.push(match &n.lit {
                        Some(l) if is_ident(l) || l.contains('.') || l.contains(':') || l.starts_with('/') => Ex::simple(l.clone()),
                        _ => Ex::simple(format!("eval({})", n.s)),
                    });
                }
                Action::SetVariable => {
                    let v = self.pop(st);
                    let n = self.pop(st);
                    let l = n.lit.clone().unwrap_or_else(|| format!("eval({})", n.s));
                    self.line(ind, &format!("{} = {};", l, strip(&v.s)));
                }
                Action::DefineLocal => {
                    let v = self.pop(st);
                    let n = self.pop(st);
                    let l = n.lit.clone().unwrap_or(n.s.clone());
                    self.line(ind, &format!("var {} = {};", l, strip(&v.s)));
                }
                Action::DefineLocal2 => {
                    let n = self.pop(st);
                    let l = n.lit.clone().unwrap_or(n.s.clone());
                    self.line(ind, &format!("var {};", l));
                }
                Action::GetMember => {
                    let n = self.pop(st);
                    let o = self.pop(st);
                    let m = self.member(&o, &n);
                    st.push(Ex::simple(m));
                }
                Action::SetMember => {
                    let v = self.pop(st);
                    let n = self.pop(st);
                    let o = self.pop(st);
                    let m = self.member(&o, &n);
                    self.line(ind, &format!("{} = {};", m, strip(&v.s)));
                }
                Action::GetProperty => {
                    let idx = self.pop(st);
                    let t = self.pop(st);
                    let nm = prop_name(idx.s.parse::<f64>().unwrap_or(-1.0) as i64);
                    let tt = if t.s == "\"\"" || t.s == "this" { String::new() } else { format!("{}.", t.paren()) };
                    st.push(Ex::simple(format!("{}{}", tt, nm)));
                }
                Action::SetProperty => {
                    let v = self.pop(st);
                    let idx = self.pop(st);
                    let t = self.pop(st);
                    let nm = prop_name(idx.s.parse::<f64>().unwrap_or(-1.0) as i64);
                    let tt = if t.s == "\"\"" { String::new() } else { format!("{}.", t.paren()) };
                    self.line(ind, &format!("{}{} = {};", tt, nm, strip(&v.s)));
                }
                Action::CallFunction => {
                    let n = self.pop(st);
                    let args = self.args(st);
                    let nm = n.lit.clone().unwrap_or(format!("eval({})", n.s));
                    st.push(Ex::simple(format!("{}({})", nm, args.join(", "))));
                }
                Action::CallMethod => {
                    let n = self.pop(st);
                    let o = self.pop(st);
                    let args = self.args(st);
                    let call = match &n.lit {
                        Some(l) if l.is_empty() => format!("{}({})", o.paren(), args.join(", ")),
                        _ if n.s == "undefined" => format!("{}({})", o.paren(), args.join(", ")),
                        _ => format!("{}({})", self.member(&o, &n), args.join(", ")),
                    };
                    st.push(Ex::simple(call));
                }
                Action::NewObject => {
                    let n = self.pop(st);
                    let args = self.args(st);
                    st.push(Ex::simple(format!("new {}({})", n.lit.clone().unwrap_or(n.s.clone()), args.join(", "))));
                }
                Action::NewMethod => {
                    let n = self.pop(st);
                    let o = self.pop(st);
                    let args = self.args(st);
                    st.push(Ex::simple(format!("new {}({})", self.member(&o, &n), args.join(", "))));
                }
                Action::InitArray => {
                    let args = self.args(st);
                    st.push(Ex::simple(format!("[{}]", args.join(", "))));
                }
                Action::InitObject => {
                    let n = self.pop(st);
                    let n: usize = n.s.parse().unwrap_or(0);
                    let mut parts = Vec::new();
                    for _ in 0..n {
                        let v = self.pop(st);
                        let k = self.pop(st);
                        parts.push(format!("{}: {}", k.lit.clone().unwrap_or(k.s.clone()), v.s));
                    }
                    st.push(Ex::simple(format!("{{{}}}", parts.join(", "))));
                }
                Action::DefineFunction(f) => {
                    let params = f.params.iter().map(|p| (s(p), None)).collect();
                    let e = self.func(&s(f.name), params, None, f.actions, ind);
                    if f.name.is_empty() {
                        st.push(e);
                    } else {
                        self.line(ind, &e.s);
                    }
                }
                Action::DefineFunction2(f) => {
                    let params = f.params.iter().map(|p| (s(p.name), p.register_index.map(|r| r.get()))).collect();
                    let e = self.func(&s(f.name), params, Some(f.flags), f.actions, ind);
                    if f.name.is_empty() {
                        st.push(e);
                    } else {
                        self.line(ind, &e.s);
                    }
                }
                Action::Return => {
                    let v = self.pop(st);
                    if v.s == "undefined" {
                        self.line(ind, "return;");
                    } else {
                        self.line(ind, &format!("return {};", strip(&v.s)));
                    }
                }
                Action::Throw => {
                    let v = self.pop(st);
                    self.line(ind, &format!("throw {};", v.s));
                }
                Action::Trace => {
                    let v = self.pop(st);
                    self.line(ind, &format!("trace({});", v.s));
                }
                Action::Delete | Action::Delete2 => {
                    if matches!(a, Action::Delete) {
                        let n = self.pop(st);
                        let o = self.pop(st);
                        st.push(Ex::simple(format!("delete {}", self.member(&o, &n))));
                    } else {
                        let n = self.pop(st);
                        st.push(Ex::simple(format!("delete {}", n.lit.clone().unwrap_or(n.s.clone()))));
                    }
                }
                Action::Enumerate | Action::Enumerate2 => {
                    let n = self.pop(st);
                    let nm = if matches!(a, Action::Enumerate) { n.lit.clone().unwrap_or(n.s.clone()) } else { n.s.clone() };
                    st.push(Ex::simple("null"));
                    st.push(Ex::simple(format!("/*enumerate*/ {}", nm)));
                }
                Action::If(_) => {
                    i = self.emit_if(i, hi, st, ctrl, ind);
                    continue;
                }
                Action::Jump(_) => {
                    let t = self.target(i).unwrap_or(0);
                    if let Some(&(ls, lb)) = ctrl.last() {
                        if t == lb {
                            self.line(ind, "break;");
                        } else if t == ls {
                            if i + 1 != lb || self.loops.get(&ls) != Some(&i) {
                                self.line(ind, "continue;");
                            }
                        } else {
                            self.line(ind, &format!("goto L{:04x};", self.ins.get(t).map(|x| x.pos).unwrap_or(0)));
                        }
                    } else {
                        self.line(ind, &format!("goto L{:04x};", self.ins.get(t).map(|x| x.pos).unwrap_or(0)));
                    }
                }
                Action::With(w) => {
                    let o = self.pop(st);
                    let inner = decompile_tag(w.actions, self.version, &self.pool, self.regs.clone(), ind + 1);
                    self.line(ind, &format!("with ({}) {{", o.s));
                    self.out.push_str(&inner);
                    self.line(ind, "}");
                }
                Action::Try(t) => {
                    self.line(ind, "try {");
                    let b = decompile_tag(t.try_body, self.version, &self.pool, self.regs.clone(), ind + 1);
                    self.out.push_str(&b);
                    if let Some((v, body)) = &t.catch_body {
                        self.line(ind, &format!("}} catch ({:?}) {{", v));
                        let b = decompile_tag(body, self.version, &self.pool, self.regs.clone(), ind + 1);
                        self.out.push_str(&b);
                    }
                    if let Some(body) = &t.finally_body {
                        self.line(ind, "} finally {");
                        let b = decompile_tag(body, self.version, &self.pool, self.regs.clone(), ind + 1);
                        self.out.push_str(&b);
                    }
                    self.line(ind, "}");
                }
                Action::Play => self.line(ind, "play();"),
                Action::Stop => self.line(ind, "stop();"),
                Action::NextFrame => self.line(ind, "nextFrame();"),
                Action::PreviousFrame => self.line(ind, "prevFrame();"),
                Action::StopSounds => self.line(ind, "stopAllSounds();"),
                Action::GotoFrame(g) => self.line(ind, &format!("gotoFrame({});", g.frame)),
                Action::GotoLabel(l) => self.line(ind, &format!("gotoLabel({});", quote(&s(l.label)))),
                Action::GotoFrame2(g) => {
                    let f = self.pop(st);
                    self.line(ind, &format!("{}({});", if g.set_playing { "gotoAndPlay" } else { "gotoAndStop" }, f.s));
                }
                Action::SetTarget(t) => self.line(ind, &format!("setTarget({});", quote(&s(t.target)))),
                Action::SetTarget2 => {
                    let t = self.pop(st);
                    self.line(ind, &format!("setTarget({});", t.s));
                }
                Action::GetUrl(g) => self.line(ind, &format!("getURL({}, {});", quote(&s(g.url)), quote(&s(g.target)))),
                Action::GetUrl2(g) => {
                    let t = self.pop(st);
                    let u = self.pop(st);
                    self.line(ind, &format!("getURL2({}, {}, {:?});", u.s, t.s, g));
                }
                Action::Call => {
                    let f = self.pop(st);
                    self.line(ind, &format!("callFrame({});", f.s));
                }
                Action::CloneSprite => {
                    let d = self.pop(st);
                    let n = self.pop(st);
                    let t = self.pop(st);
                    self.line(ind, &format!("duplicateMovieClip({}, {}, {});", t.s, n.s, d.s));
                }
                Action::RemoveSprite => {
                    let t = self.pop(st);
                    self.line(ind, &format!("removeMovieClip({});", t.s));
                }
                Action::StartDrag => {
                    let t = self.pop(st);
                    let l = self.pop(st);
                    self.line(ind, &format!("startDrag({}, lock={});", t.s, l.s));
                }
                Action::EndDrag => self.line(ind, "stopDrag();"),
                Action::GetTime => st.push(Ex::simple("getTimer()")),
                Action::RandomNumber => {
                    let v = self.pop(st);
                    st.push(Ex::simple(format!("random({})", v.s)));
                }
                Action::Not => {
                    let v = self.pop(st);
                    st.push(Ex { s: format!("!{}", v.paren()), lit: None, simple: true });
                }
                Action::Increment => {
                    let v = self.pop(st);
                    st.push(Ex::compound(format!("{} + 1", v.paren())));
                }
                Action::Decrement => {
                    let v = self.pop(st);
                    st.push(Ex::compound(format!("{} - 1", v.paren())));
                }
                Action::TypeOf => {
                    let v = self.pop(st);
                    st.push(Ex::simple(format!("typeof {}", v.paren())));
                }
                Action::ToInteger => un(self, st, "int"),
                Action::ToNumber => un(self, st, "Number"),
                Action::ToString => un(self, st, "String"),
                Action::StringLength => un(self, st, "length"),
                Action::TargetPath => un(self, st, "targetPath"),
                Action::CharToAscii => un(self, st, "ord"),
                Action::AsciiToChar => un(self, st, "chr"),
                Action::StringExtract => {
                    let c = self.pop(st);
                    let i2 = self.pop(st);
                    let sv = self.pop(st);
                    st.push(Ex::simple(format!("substring({}, {}, {})", sv.s, i2.s, c.s)));
                }
                Action::Add | Action::Add2 => bin(self, st, "+"),
                Action::Subtract => bin(self, st, "-"),
                Action::Multiply => bin(self, st, "*"),
                Action::Divide => bin(self, st, "/"),
                Action::Modulo => bin(self, st, "%"),
                Action::BitAnd => bin(self, st, "&"),
                Action::BitOr => bin(self, st, "|"),
                Action::BitXor => bin(self, st, "^"),
                Action::BitLShift => bin(self, st, "<<"),
                Action::BitRShift => bin(self, st, ">>"),
                Action::BitURShift => bin(self, st, ">>>"),
                Action::Less | Action::Less2 => bin(self, st, "<"),
                Action::Greater => bin(self, st, ">"),
                Action::Equals | Action::Equals2 => bin(self, st, "=="),
                Action::StrictEquals => bin(self, st, "==="),
                Action::StringAdd => bin(self, st, "+"),
                Action::StringEquals => bin(self, st, "=="),
                Action::StringLess => bin(self, st, "<"),
                Action::StringGreater => bin(self, st, ">"),
                Action::And => bin(self, st, "&&"),
                Action::Or => bin(self, st, "||"),
                Action::InstanceOf => bin(self, st, "instanceof"),
                Action::CastOp => {
                    let o = self.pop(st);
                    let c = self.pop(st);
                    st.push(Ex::simple(format!("{}({})", c.s, o.s)));
                }
                Action::Extends => {
                    let sup = self.pop(st);
                    let sub = self.pop(st);
                    self.line(ind, &format!("{}.extends({});", sub.s, sup.s));
                }
                Action::ImplementsOp => {
                    let _ = self.pop(st);
                }
                other => {
                    self.line(ind, &format!("/* {:?} */", other));
                }
            }
            i += 1;
        }
    }

    /// Emits a loop whose body spans [start, end] where `end` is the backward branch.
    fn emit_loop(&mut self, start: usize, end: usize, st: &mut Vec<Ex>, ctrl: &[(usize, usize)], ind: usize) -> usize {
        let brk = end + 1;
        let mut c2 = ctrl.to_vec();
        c2.push((start, brk));
        // do { } while (cond): the closing instruction is a backward If
        if matches!(self.ins[end].a, Action::If(_)) {
            self.line(ind, "do {");
            self.run(start, end, st, &c2, ind + 1);
            let c = self.pop(st);
            self.line(ind, &format!("}} while ({});", strip(&c.s)));
            return brk;
        }
        // while (cond) { }: find the first If that targets brk with a clean header
        let mut header = None;
        for k in start..end {
            if matches!(self.ins[k].a, Action::If(_)) {
                if self.target(k) == Some(brk) {
                    header = Some(k);
                }
                break;
            }
            if matches!(self.ins[k].a, Action::Jump(_)) {
                break;
            }
        }
        if let Some(k) = header {
            let saved_out = std::mem::take(&mut self.out);
            let saved_failed = self.failed;
            self.failed = false;
            let mut tmp = Vec::new();
            self.run(start, k, &mut tmp, &c2, 0);
            let clean = !self.failed && self.out.trim().is_empty() && tmp.len() == 1;
            self.out = saved_out;
            self.failed = saved_failed;
            if clean {
                let c = tmp.pop().unwrap();
                self.line(ind, &format!("while ({}) {{", strip(&neg(&c))));
                self.run(k + 1, end, st, &c2, ind + 1);
                self.line(ind, "}");
                return brk;
            }
        }
        self.line(ind, "while (true) {");
        self.run(start, end + 1, st, &c2, ind + 1);
        self.line(ind, "}");
        brk
    }

    /// Handles an `If` at index i (jump when the popped condition is true).
    fn emit_if(&mut self, i: usize, hi: usize, st: &mut Vec<Ex>, ctrl: &[(usize, usize)], ind: usize) -> usize {
        let t = self.target(i).unwrap_or(self.ins.len());
        // short-circuit logical operators: PushDuplicate [Not] If ; Pop ; <rhs>
        let prev_dup = i >= 1 && matches!(self.ins[i - 1].a, Action::PushDuplicate);
        let prev_not_dup = i >= 2 && matches!(self.ins[i - 1].a, Action::Not) && matches!(self.ins[i - 2].a, Action::PushDuplicate);
        if t > i && (prev_dup || prev_not_dup) && matches!(self.ins.get(i + 1).map(|x| &x.a), Some(Action::Pop)) {
            let _cond = self.pop(st);
            let a = self.pop(st);
            if let Some(b) = self.sub_expr(i + 2, t, st, ctrl) {
                let op = if prev_not_dup { "&&" } else { "||" };
                st.push(Ex::compound(format!("{} {} {}", a.paren(), op, b.paren())));
                return t;
            }
            st.push(a);
        }
        if t > i && t <= hi {
            // ternary?
            if t >= 2 {
                if let Action::Jump(_) = self.ins[t - 1].a {
                    let u = self.target(t - 1).unwrap_or(0);
                    if u > t && u <= hi + 1 {
                        let then_e = self.sub_expr(i + 1, t - 1, st, ctrl);
                        let else_e = self.sub_expr(t, u, st, ctrl);
                        if let (Some(a), Some(b)) = (then_e, else_e) {
                            let c = self.pop(st);
                            st.push(Ex::compound(format!("{} ? {} : {}", paren_if(&neg(&c)), a.paren(), b.paren())));
                            return u;
                        }
                    }
                }
            }
        }
        let c = self.pop(st);
        // loop control flow
        if let Some(&(ls, lb)) = ctrl.last() {
            if t == lb {
                self.line(ind, &format!("if ({}) break;", strip(&c.s)));
                return i + 1;
            }
            if t == ls {
                self.line(ind, &format!("if ({}) continue;", strip(&c.s)));
                return i + 1;
            }
        }
        if t <= i {
            // backward if that is not a recognised loop closer
            self.line(ind, &format!("if ({}) goto L{:04x};", strip(&c.s), self.ins.get(t).map(|x| x.pos).unwrap_or(0)));
            return i + 1;
        }
        // if / else
        let mut else_end = None;
        if t >= 1 && t - 1 > i {
            if let Action::Jump(_) = self.ins[t - 1].a {
                let u = self.target(t - 1).unwrap_or(0);
                let is_loop_jump = ctrl.last().map(|&(ls, lb)| u == ls || u == lb).unwrap_or(false);
                if u > t && !is_loop_jump {
                    else_end = Some(u);
                }
            }
        }
        let cond = strip(&neg(&c));
        match else_end {
            Some(u) => {
                self.line(ind, &format!("if ({}) {{", cond));
                self.run(i + 1, t - 1, st, ctrl, ind + 1);
                self.line(ind, "} else {");
                self.run(t, u.min(self.ins.len()), st, ctrl, ind + 1);
                self.line(ind, "}");
                u
            }
            None => {
                self.line(ind, &format!("if ({}) {{", cond));
                self.run(i + 1, t.min(self.ins.len()), st, ctrl, ind + 1);
                self.line(ind, "}");
                t
            }
        }
    }
}

fn paren_if(x: &str) -> String {
    if x.contains(' ') { format!("({})", x) } else { x.to_string() }
}

fn strip(x: &str) -> String {
    let t = x.trim();
    if t.starts_with('(') && t.ends_with(')') && balanced(&t[1..t.len() - 1]) {
        t[1..t.len() - 1].to_string()
    } else {
        t.to_string()
    }
}

fn un(d: &mut Dec, st: &mut Vec<Ex>, f: &str) {
    let v = d.pop(st);
    st.push(Ex::simple(format!("{}({})", f, v.s)));
}

fn bin(d: &mut Dec, st: &mut Vec<Ex>, op: &str) {
    let b = d.pop(st);
    let a = d.pop(st);
    st.push(Ex::compound(format!("{} {} {}", a.paren(), op, b.paren())));
}
