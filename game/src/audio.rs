//! Audio: a small real-time mixer on an SDL2 audio callback.
//! Sounds are PCM WAV files produced by the converter; they are resampled once at load time.
use anyhow::{anyhow, Result};
use std::collections::HashMap;
use std::path::{Path, PathBuf};
use std::sync::{Arc, Mutex};

pub struct Pcm {
    /// stereo frames at the device rate
    pub frames: Vec<[f32; 2]>,
}

impl Pcm {
    pub fn seconds(&self, rate: u32) -> f32 {
        self.frames.len() as f32 / rate as f32
    }
}

struct Voice {
    id: u64,
    pcm: Arc<Pcm>,
    pos: usize,
    /// remaining plays after the current one (u32::MAX = forever)
    loops: u32,
    vol: f32,
    target: f32,
    step: f32,
    stop_at_zero: bool,
    paused: bool,
}

#[derive(Default)]
struct Mixer {
    voices: Vec<Voice>,
    finished: Vec<u64>,
    next_id: u64,
}

struct Callback {
    mixer: Arc<Mutex<Mixer>>,
}

impl sdl2::audio::AudioCallback for Callback {
    type Channel = f32;
    fn callback(&mut self, out: &mut [f32]) {
        out.fill(0.0);
        let mut m = self.mixer.lock().unwrap();
        let mut done: Vec<u64> = Vec::new();
        for v in m.voices.iter_mut() {
            if v.paused {
                continue;
            }
            let frames = v.pcm.frames.len();
            if frames == 0 {
                done.push(v.id);
                continue;
            }
            for o in out.chunks_exact_mut(2) {
                if v.vol != v.target {
                    v.vol = if v.vol < v.target { (v.vol + v.step).min(v.target) } else { (v.vol - v.step).max(v.target) };
                }
                if v.pos >= frames {
                    if v.loops == 0 {
                        done.push(v.id);
                        break;
                    }
                    if v.loops != u32::MAX {
                        v.loops -= 1;
                    }
                    v.pos = 0;
                }
                let s = v.pcm.frames[v.pos];
                o[0] += s[0] * v.vol;
                o[1] += s[1] * v.vol;
                v.pos += 1;
            }
            if v.stop_at_zero && v.vol <= 0.0 {
                done.push(v.id);
            }
        }
        if !done.is_empty() {
            let mut fin = Vec::new();
            m.voices.retain(|v| {
                let d = done.contains(&v.id);
                if d {
                    fin.push(v.id);
                }
                !d
            });
            m.finished.extend(fin);
        }
        for s in out.iter_mut() {
            *s = s.clamp(-1.0, 1.0);
        }
    }
}

pub struct Audio {
    mixer: Arc<Mutex<Mixer>>,
    _device: Option<sdl2::audio::AudioDevice<Callback>>,
    pub rate: u32,
    cache: HashMap<PathBuf, Arc<Pcm>>,
    pub master: f32,
}

#[derive(Clone, Copy, PartialEq, Eq, Debug, Hash)]
pub struct VoiceId(pub u64);

fn parse_wav(bytes: &[u8]) -> Result<(u32, u16, Vec<f32>)> {
    if bytes.len() < 44 || &bytes[0..4] != b"RIFF" {
        return Err(anyhow!("not a wav"));
    }
    let (mut rate, mut ch, mut data) = (44100u32, 1u16, &bytes[0..0]);
    let mut i = 12;
    while i + 8 <= bytes.len() {
        let id = &bytes[i..i + 4];
        let len = u32::from_le_bytes([bytes[i + 4], bytes[i + 5], bytes[i + 6], bytes[i + 7]]) as usize;
        let body = &bytes[(i + 8).min(bytes.len())..(i + 8 + len).min(bytes.len())];
        if id == b"fmt " && body.len() >= 16 {
            ch = u16::from_le_bytes([body[2], body[3]]);
            rate = u32::from_le_bytes([body[4], body[5], body[6], body[7]]);
        } else if id == b"data" {
            data = body;
        }
        i += 8 + len + (len & 1);
    }
    let samples = data.chunks_exact(2).map(|b| i16::from_le_bytes([b[0], b[1]]) as f32 / 32768.0).collect();
    Ok((rate, ch, samples))
}

impl Audio {
    pub fn new(sdl: Option<&sdl2::Sdl>) -> Audio {
        let mixer = Arc::new(Mutex::new(Mixer::default()));
        let mut rate = 44100;
        let mut device = None;
        if let Some(sdl) = sdl {
            if let Ok(a) = sdl.audio() {
                let spec = sdl2::audio::AudioSpecDesired { freq: Some(44100), channels: Some(2), samples: Some(512) };
                match a.open_playback(None, &spec, |s| {
                    rate = s.freq as u32;
                    Callback { mixer: mixer.clone() }
                }) {
                    Ok(d) => {
                        d.resume();
                        device = Some(d);
                    }
                    Err(e) => log::warn!("audio disabled: {e}"),
                }
            }
        }
        Audio { mixer, _device: device, rate, cache: HashMap::new(), master: 1.0 }
    }

    pub fn load(&mut self, path: &Path) -> Result<Arc<Pcm>> {
        if let Some(p) = self.cache.get(path) {
            return Ok(p.clone());
        }
        let bytes = std::fs::read(path).map_err(|e| anyhow!("{}: {e}", path.display()))?;
        let (rate, ch, samples) = parse_wav(&bytes)?;
        let mut mono_or_stereo: Vec<[f32; 2]> = if ch >= 2 {
            samples.chunks_exact(ch as usize).map(|c| [c[0], c[1]]).collect()
        } else {
            samples.iter().map(|s| [*s, *s]).collect()
        };
        if rate != self.rate && !mono_or_stereo.is_empty() {
            mono_or_stereo = resample(&mono_or_stereo, rate, self.rate);
        }
        let pcm = Arc::new(Pcm { frames: mono_or_stereo });
        self.cache.insert(path.to_path_buf(), pcm.clone());
        Ok(pcm)
    }

    /// `loops`: number of times to play (Flash `Sound.start(offset, loops)`).
    pub fn play(&self, pcm: &Arc<Pcm>, offset_secs: f32, loops: u32, volume: f32) -> VoiceId {
        let mut m = self.mixer.lock().unwrap();
        m.next_id += 1;
        let id = m.next_id;
        let pos = ((offset_secs * self.rate as f32) as usize).min(pcm.frames.len().saturating_sub(1));
        m.voices.push(Voice {
            id,
            pcm: pcm.clone(),
            pos,
            loops: if loops >= 999 { u32::MAX } else { loops.saturating_sub(1) },
            vol: volume * self.master,
            target: volume * self.master,
            step: 0.0,
            stop_at_zero: false,
            paused: false,
        });
        VoiceId(id)
    }

    pub fn stop(&self, id: VoiceId) {
        let mut m = self.mixer.lock().unwrap();
        m.voices.retain(|v| v.id != id.0);
    }

    pub fn stop_all(&self) {
        self.mixer.lock().unwrap().voices.clear();
    }

    pub fn set_volume(&self, id: VoiceId, vol: f32) {
        let mut m = self.mixer.lock().unwrap();
        if let Some(v) = m.voices.iter_mut().find(|v| v.id == id.0) {
            v.vol = vol * self.master;
            v.target = vol * self.master;
            v.step = 0.0;
        }
    }

    /// Linear fade to `vol` over `secs`; with `stop` the voice ends when it reaches silence.
    pub fn fade_to(&self, id: VoiceId, vol: f32, secs: f32, stop: bool) {
        let mut m = self.mixer.lock().unwrap();
        if let Some(v) = m.voices.iter_mut().find(|v| v.id == id.0) {
            v.target = vol * self.master;
            v.step = (v.target - v.vol).abs() / (secs.max(0.001) * self.rate as f32);
            v.stop_at_zero = stop && vol <= 0.0;
        }
    }

    pub fn set_paused(&self, id: VoiceId, paused: bool) {
        if let Some(v) = self.mixer.lock().unwrap().voices.iter_mut().find(|v| v.id == id.0) {
            v.paused = paused;
        }
    }

    /// Current playback position in seconds.
    pub fn position(&self, id: VoiceId) -> Option<f32> {
        if self._device.is_none() {
            return None;
        }
        self.mixer.lock().unwrap().voices.iter().find(|v| v.id == id.0).map(|v| v.pos as f32 / self.rate as f32)
    }

    pub fn is_playing(&self, id: VoiceId) -> bool {
        self.mixer.lock().unwrap().voices.iter().any(|v| v.id == id.0)
    }

    /// Voices that ended since the last call (for `onSoundComplete`).
    pub fn take_finished(&self) -> Vec<VoiceId> {
        std::mem::take(&mut self.mixer.lock().unwrap().finished).into_iter().map(VoiceId).collect()
    }
}

impl Audio {
    /// Registers PCM that was decoded elsewhere (e.g. the audio track of a video).
    pub fn pcm_from_samples(&self, rate: u32, channels: u16, samples: &[f32]) -> Arc<Pcm> {
        let frames: Vec<[f32; 2]> = if channels >= 2 {
            samples.chunks_exact(channels as usize).map(|c| [c[0], c[1]]).collect()
        } else {
            samples.iter().map(|s| [*s, *s]).collect()
        };
        let frames = if rate != self.rate && !frames.is_empty() { resample(&frames, rate, self.rate) } else { frames };
        Arc::new(Pcm { frames })
    }
}

// ------------------------------------------------------------------ resampling

/// Zero crossings of the sinc kernel on each side (quality vs. cost).
const ZC: usize = 24;
/// Kernel table resolution per input sample.
const PHASES: usize = 512;

/// Band-limited (windowed-sinc, Blackman) resampling of stereo frames from `from` Hz to `to` Hz.
/// Linear interpolation, used before, acts as a low-pass that dulls 11/22 kHz sound effects and
/// adds aliasing; this keeps the response flat up to ~95% of the lower Nyquist frequency.
pub fn resample(src: &[[f32; 2]], from: u32, to: u32) -> Vec<[f32; 2]> {
    use rayon::prelude::*;
    if src.is_empty() || from == to || from == 0 || to == 0 {
        return src.to_vec();
    }
    let step = from as f64 / to as f64; // input samples per output sample
    // cutoff relative to the input Nyquist: stay below the output Nyquist when downsampling
    let cutoff = if to < from { to as f64 / from as f64 } else { 1.0 } * 0.95;
    let half = (ZC as f64 / cutoff).ceil() as usize; // kernel half-width in input samples
    // kernel table over x in [0, half] (symmetric), PHASES entries per input sample
    let n_tab = half * PHASES + 2;
    let tab: Vec<f32> = (0..n_tab)
        .map(|i| {
            let x = i as f64 / PHASES as f64;
            if x >= half as f64 {
                return 0.0;
            }
            let t = std::f64::consts::PI * cutoff * x;
            let sinc = if x == 0.0 { 1.0 } else { t.sin() / t };
            let wpos = 0.5 + 0.5 * (x / half as f64); // Blackman over [-half, half] mapped to [0,1]
            let tw = 2.0 * std::f64::consts::PI * wpos;
            let win = 0.42 - 0.5 * tw.cos() + 0.08 * (2.0 * tw).cos();
            (cutoff * sinc * win) as f32
        })
        .collect();
    let kernel = |x: f64| -> f32 {
        let p = x.abs() * PHASES as f64;
        let i = p as usize;
        if i + 1 >= n_tab {
            return 0.0;
        }
        let f = (p - i as f64) as f32;
        tab[i] + (tab[i + 1] - tab[i]) * f
    };
    let n_out = ((src.len() as f64) / step).floor().max(1.0) as usize;
    let last = src.len() as isize - 1;
    let taps = 2 * half;
    // Rational ratio: output i sits at input (i*from)/to + ((i*from)%to)/to, so there are only
    // `to/g` distinct fractional phases; their weights are computed once.
    let g = gcd(from as u64, to as u64);
    let (num, den) = (from as u64 / g, to as u64 / g);
    let phased = den <= 4096;
    let weights: Vec<f32> = if phased {
        let mut w = vec![0.0f32; den as usize * taps];
        for ph in 0..den as usize {
            let frac = ph as f64 / den as f64;
            let row = &mut w[ph * taps..(ph + 1) * taps];
            let mut sum = 0.0f32;
            for (j, v) in row.iter_mut().enumerate() {
                // tap j is input sample c - half + 1 + j, at distance x from the output position
                let x = (j as f64 - half as f64 + 1.0) - frac;
                *v = kernel(x);
                sum += *v;
            }
            if sum.abs() > 1e-6 {
                row.iter_mut().for_each(|v| *v /= sum);
            }
        }
        w
    } else {
        Vec::new()
    };
    (0..n_out)
        .into_par_iter()
        .map(|i| {
            let (c, row): (isize, Option<&[f32]>) = if phased {
                let pos = i as u64 * num;
                let ph = (pos % den) as usize;
                ((pos / den) as isize, Some(&weights[ph * taps..(ph + 1) * taps]))
            } else {
                ((i as f64 * step).floor() as isize, None)
            };
            let base = c - half as isize + 1;
            let (mut l, mut r) = (0.0f32, 0.0f32);
            match row {
                Some(row) if base >= 0 && base + taps as isize - 1 <= last => {
                    let seg = &src[base as usize..base as usize + taps];
                    for (s, w) in seg.iter().zip(row) {
                        l += s[0] * w;
                        r += s[1] * w;
                    }
                }
                Some(row) => {
                    for (j, w) in row.iter().enumerate() {
                        let k = base + j as isize;
                        if k >= 0 && k <= last {
                            let s = src[k as usize];
                            l += s[0] * w;
                            r += s[1] * w;
                        }
                    }
                }
                None => {
                    let center = i as f64 * step;
                    let mut wsum = 0.0f32;
                    for k in base..base + taps as isize {
                        let w = kernel(k as f64 - center);
                        wsum += w;
                        if k >= 0 && k <= last {
                            let s = src[k as usize];
                            l += s[0] * w;
                            r += s[1] * w;
                        }
                    }
                    if wsum.abs() > 1e-6 {
                        l /= wsum;
                        r /= wsum;
                    }
                }
            }
            [l, r]
        })
        .collect()
}

fn gcd(mut a: u64, mut b: u64) -> u64 {
    while b != 0 {
        let t = a % b;
        a = b;
        b = t;
    }
    a.max(1)
}

#[cfg(test)]
mod tests {
    use super::*;

    fn tone(rate: u32, hz: f64, secs: f64) -> Vec<[f32; 2]> {
        let n = (rate as f64 * secs) as usize;
        (0..n).map(|i| {
            let v = (2.0 * std::f64::consts::PI * hz * i as f64 / rate as f64).sin() as f32 * 0.5;
            [v, v]
        }).collect()
    }

    /// amplitude of `hz` in a signal (single-bin DFT over the middle part)
    fn amp(sig: &[[f32; 2]], rate: u32, hz: f64) -> f64 {
        let a = sig.len() / 4;
        let b = sig.len() * 3 / 4;
        let (mut re, mut im) = (0.0, 0.0);
        for (k, s) in sig[a..b].iter().enumerate() {
            let ph = 2.0 * std::f64::consts::PI * hz * (k + a) as f64 / rate as f64;
            re += s[0] as f64 * ph.cos();
            im += s[0] as f64 * ph.sin();
        }
        2.0 * (re * re + im * im).sqrt() / (b - a) as f64
    }

    #[test]
    fn upsampling_keeps_treble_and_rejects_images() {
        for (from, to, hz) in [(22050, 44100, 8000.0), (22050, 48000, 9500.0), (11025, 44100, 4500.0), (44100, 48000, 15000.0)] {
            let out = resample(&tone(from, hz, 0.5), from, to);
            let pass = amp(&out, to, hz);
            assert!((pass - 0.5).abs() < 0.02, "{from}->{to} {hz} Hz kept {pass}");
            if to > from {
                let image = amp(&out, to, from as f64 - hz);
                assert!(image < 0.005, "{from}->{to} image {image}");
            }
        }
    }

    #[test]
    #[ignore]
    fn bench_music_track() {
        let t = std::time::Instant::now();
        let out = resample(&tone(44100, 440.0, 180.0), 44100, 48000);
        eprintln!("3 min 44.1k->48k: {:?} ({} frames)", t.elapsed(), out.len());
    }

    #[test]
    fn downsampling_removes_aliases() {
        // 20 kHz at 44.1 kHz cannot be represented at 22.05 kHz and must vanish
        let out = resample(&tone(44100, 20000.0, 0.5), 44100, 22050);
        assert!(amp(&out, 22050, 22050.0 - 20000.0) < 0.01);
    }
}
