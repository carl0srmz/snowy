//! FLV promo videos: demuxed and decoded with FFmpeg (libavcodec/libavformat/libswscale) on
//! worker threads; frames are uploaded to a GPU texture and paced by the audio clock.
use crate::audio::{Audio, VoiceId};
use crate::gfx::{Renderer, TexId};
use ffmpeg_next as ff;
use std::path::{Path, PathBuf};
use std::sync::mpsc::{sync_channel, Receiver, TryRecvError};

struct Frame {
    pts: f32,
    rgba: Vec<u8>,
}

pub struct VideoPlayer {
    pub path: PathBuf,
    pub w: u32,
    pub h: u32,
    pub tex: TexId,
    rx: Receiver<Frame>,
    pending: Option<Frame>,
    voice: Option<VoiceId>,
    pub paused: bool,
    pub duration: f32,
    pub ended: bool,
    clock: f32,
    last_wall: std::time::Instant,
}

fn open_info(path: &Path) -> Option<(u32, u32, f32)> {
    let ictx = ff::format::input(&path).ok()?;
    let vs = ictx.streams().best(ff::media::Type::Video)?;
    let ctx = ff::codec::context::Context::from_parameters(vs.parameters()).ok()?;
    let dec = ctx.decoder().video().ok()?;
    let dur = ictx.duration() as f32 / ff::ffi::AV_TIME_BASE as f32;
    Some((dec.width(), dec.height(), dur.max(0.0)))
}

/// Decodes the MP3 audio track (FLV audio packets are raw MPEG frames) to stereo float PCM.
fn decode_audio(path: &Path) -> Option<(u32, Vec<f32>)> {
    let mut ictx = ff::format::input(&path).ok()?;
    let ai = ictx.streams().best(ff::media::Type::Audio)?.index();
    let mut data = Vec::new();
    for (s, p) in ictx.packets() {
        if s.index() == ai {
            if let Some(d) = p.data() {
                data.extend_from_slice(d);
            }
        }
    }
    let mut dec = puremp3::Mp3Decoder::new(&data[..]);
    let mut out = Vec::new();
    let mut rate = 44100;
    while let Ok(f) = dec.next_frame() {
        rate = f.header.sample_rate.hz();
        for i in 0..f.num_samples {
            out.push(f.samples[0][i]);
            out.push(f.samples[1][i]);
        }
    }
    Some((rate, out))
}

fn spawn_decoder(path: PathBuf, w: u32, h: u32) -> Receiver<Frame> {
    let (tx, rx) = sync_channel::<Frame>(6);
    std::thread::spawn(move || {
        let Ok(mut ictx) = ff::format::input(&path) else { return };
        let Some(vs) = ictx.streams().best(ff::media::Type::Video) else { return };
        let vi = vs.index();
        let tb = vs.time_base();
        let tb = tb.numerator() as f32 / tb.denominator().max(1) as f32;
        let ctx = match ff::codec::context::Context::from_parameters(vs.parameters()) {
            Ok(c) => c,
            Err(e) => {
                log::warn!("video context: {e}");
                return;
            }
        };
        let mut dec = match ctx.decoder().video() {
            Ok(d) => d,
            Err(e) => {
                log::warn!("video decoder: {e}");
                return;
            }
        };
        let mut scaler = match ff::software::scaling::context::Context::get(dec.format(), dec.width(), dec.height(), ff::format::Pixel::RGBA, w, h, ff::software::scaling::flag::Flags::BILINEAR) {
            Ok(s) => s,
            Err(e) => {
                log::warn!("video scaler: {e} (fmt {:?} {}x{})", dec.format(), dec.width(), dec.height());
                return;
            }
        };
        let mut frame = ff::frame::Video::empty();
        let mut rgba = ff::frame::Video::empty();
        let mut send = |dec: &mut ff::decoder::Video, scaler: &mut ff::software::scaling::context::Context| -> bool {
            while dec.receive_frame(&mut frame).is_ok() {
                if scaler.run(&frame, &mut rgba).is_err() {
                    continue;
                }
                let stride = rgba.stride(0);
                let src = rgba.data(0);
                let mut buf = Vec::with_capacity((w * h * 4) as usize);
                for y in 0..h as usize {
                    buf.extend_from_slice(&src[y * stride..y * stride + (w * 4) as usize]);
                }
                let pts = frame.timestamp().unwrap_or(0) as f32 * tb;
                if tx.send(Frame { pts, rgba: buf }).is_err() {
                    return false;
                }
            }
            true
        };
        for (s, p) in ictx.packets() {
            if s.index() != vi {
                continue;
            }
            if let Err(e) = dec.send_packet(&p) {
                log::warn!("video send_packet: {e}");
                continue;
            }
            if !send(&mut dec, &mut scaler) {
                return;
            }
        }
        let _ = dec.send_eof();
        let _ = send(&mut dec, &mut scaler);
    });
    rx
}

impl VideoPlayer {
    pub fn open(path: &Path, rd: &mut Renderer, audio: &mut Audio) -> Option<VideoPlayer> {
        let _ = ff::init();
        let (w, h, duration) = open_info(path)?;
        let tex = rd.create_texture(w, h, &vec![0u8; (w * h * 4) as usize]);
        let rx = spawn_decoder(path.to_path_buf(), w, h);
        let voice = decode_audio(path).map(|(rate, samples)| {
            let pcm = audio.pcm_from_samples(rate, 2, &samples);
            audio.play(&pcm, 0.0, 1, 1.0)
        });
        Some(VideoPlayer { path: path.to_path_buf(), w, h, tex, rx, pending: None, voice, paused: false, duration, ended: false, clock: 0.0, last_wall: std::time::Instant::now() })
    }

    pub fn set_paused(&mut self, audio: &Audio, p: bool) {
        self.paused = p;
        if let Some(v) = self.voice {
            audio.set_paused(v, p);
        }
        self.last_wall = std::time::Instant::now();
    }

    pub fn position(&self) -> f32 {
        self.clock
    }

    /// Advances playback; returns true when a new frame was uploaded.
    pub fn update(&mut self, rd: &mut Renderer, audio: &Audio) -> bool {
        let now = std::time::Instant::now();
        let dt = (now - self.last_wall).as_secs_f32();
        self.last_wall = now;
        // audio is the master clock; fall back to wall time for silent files
        match self.voice.and_then(|v| audio.position(v)) {
            Some(t) => self.clock = t,
            None => {
                if !self.paused {
                    self.clock += dt;
                }
            }
        }
        let mut shown = false;
        loop {
            if self.pending.is_none() {
                match self.rx.try_recv() {
                    Ok(f) => self.pending = Some(f),
                    Err(TryRecvError::Empty) => break,
                    Err(TryRecvError::Disconnected) => {
                        if self.clock >= self.duration - 0.05 {
                            self.ended = true;
                        }
                        break;
                    }
                }
            }
            match &self.pending {
                Some(f) if f.pts <= self.clock => {
                    let f = self.pending.take().unwrap();
                    rd.update_texture(self.tex, self.w, self.h, &f.rgba);
                    shown = true;
                }
                _ => break,
            }
        }
        shown
    }

    pub fn stop(&mut self, audio: &Audio, rd: &mut Renderer) {
        if let Some(v) = self.voice.take() {
            audio.stop(v);
        }
        rd.destroy_texture(self.tex);
    }
}
