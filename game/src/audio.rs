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
            let ratio = rate as f64 / self.rate as f64;
            let n = (mono_or_stereo.len() as f64 / ratio) as usize;
            let src = std::mem::take(&mut mono_or_stereo);
            mono_or_stereo = (0..n)
                .map(|i| {
                    let p = i as f64 * ratio;
                    let k = p as usize;
                    let f = (p - k as f64) as f32;
                    let a = src[k.min(src.len() - 1)];
                    let b = src[(k + 1).min(src.len() - 1)];
                    [a[0] + (b[0] - a[0]) * f, a[1] + (b[1] - a[1]) * f]
                })
                .collect();
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
        let frames = if rate != self.rate && !frames.is_empty() {
            let ratio = rate as f64 / self.rate as f64;
            let n = (frames.len() as f64 / ratio) as usize;
            (0..n)
                .map(|i| {
                    let p = i as f64 * ratio;
                    let k = p as usize;
                    let f = (p - k as f64) as f32;
                    let a = frames[k.min(frames.len() - 1)];
                    let b = frames[(k + 1).min(frames.len() - 1)];
                    [a[0] + (b[0] - a[0]) * f, a[1] + (b[1] - a[1]) * f]
                })
                .collect()
        } else {
            frames
        };
        Arc::new(Pcm { frames })
    }
}
