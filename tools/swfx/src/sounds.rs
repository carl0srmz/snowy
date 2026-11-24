//! DefineSound -> mp3 / wav files.
use anyhow::{bail, Result};
use swf::{AudioCompression, Sound};

fn wav(rate: u32, channels: u8, pcm: &[i16]) -> Vec<u8> {
    let data_len = (pcm.len() * 2) as u32;
    let mut v = Vec::with_capacity(44 + pcm.len() * 2);
    v.extend_from_slice(b"RIFF");
    v.extend_from_slice(&(36 + data_len).to_le_bytes());
    v.extend_from_slice(b"WAVEfmt ");
    v.extend_from_slice(&16u32.to_le_bytes());
    v.extend_from_slice(&1u16.to_le_bytes());
    v.extend_from_slice(&(channels as u16).to_le_bytes());
    v.extend_from_slice(&rate.to_le_bytes());
    v.extend_from_slice(&(rate * channels as u32 * 2).to_le_bytes());
    v.extend_from_slice(&(channels as u16 * 2).to_le_bytes());
    v.extend_from_slice(&16u16.to_le_bytes());
    v.extend_from_slice(b"data");
    v.extend_from_slice(&data_len.to_le_bytes());
    for s in pcm {
        v.extend_from_slice(&s.to_le_bytes());
    }
    v
}

const INDEX_TABLE: [[i32; 16]; 4] = [
    [-1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [-1, -1, 2, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [-1, -1, -1, -1, 2, 4, 6, 8, 0, 0, 0, 0, 0, 0, 0, 0],
    [-1, -1, -1, -1, -1, -1, -1, -1, 1, 2, 4, 6, 8, 10, 13, 16],
];
const STEP: [i32; 89] = [
    7, 8, 9, 10, 11, 12, 13, 14, 16, 17, 19, 21, 23, 25, 28, 31, 34, 37, 41, 45, 50, 55, 60, 66, 73, 80, 88, 97, 107,
    118, 130, 143, 157, 173, 190, 209, 230, 253, 279, 307, 337, 371, 408, 449, 494, 544, 598, 658, 724, 796, 876, 963,
    1060, 1166, 1282, 1411, 1552, 1707, 1878, 2066, 2272, 2499, 2749, 3024, 3327, 3660, 4026, 4428, 4871, 5358, 5894,
    6484, 7132, 7845, 8630, 9493, 10442, 11487, 12635, 13899, 15289, 16818, 18500, 20350, 22385, 24623, 27086, 29794, 32767,
];

struct Bits<'a> {
    d: &'a [u8],
    pos: usize,
}
impl<'a> Bits<'a> {
    fn read(&mut self, n: u32) -> i32 {
        let mut v = 0i32;
        for _ in 0..n {
            let byte = self.d.get(self.pos / 8).copied().unwrap_or(0);
            v = (v << 1) | ((byte >> (7 - self.pos % 8)) & 1) as i32;
            self.pos += 1;
        }
        v
    }
    fn done(&self) -> bool {
        self.pos / 8 >= self.d.len()
    }
}

fn adpcm(data: &[u8], channels: usize) -> Vec<i16> {
    let mut b = Bits { d: data, pos: 0 };
    let bits = b.read(2) as u32 + 2;
    let mut out: Vec<i16> = Vec::new();
    let mut ch_out: Vec<Vec<i16>> = vec![Vec::new(); channels];
    while !b.done() {
        let mut pred = [0i32; 2];
        let mut idx = [0i32; 2];
        for c in 0..channels {
            pred[c] = b.read(16) as i16 as i32;
            idx[c] = b.read(6).min(88);
            ch_out[c].push(pred[c] as i16);
        }
        for _ in 0..4095 {
            if b.done() {
                break;
            }
            for c in 0..channels {
                let code = b.read(bits);
                let step = STEP[idx[c] as usize];
                let sign_mask = 1 << (bits - 1);
                let mut diff = 0;
                let mag = code & (sign_mask - 1);
                let mut half = sign_mask >> 1;
                let mut s = step;
                for _ in 0..bits - 1 {
                    if mag & half != 0 {
                        diff += s;
                    }
                    half >>= 1;
                    s >>= 1;
                }
                diff += step >> (bits - 1);
                if code & sign_mask != 0 {
                    diff = -diff;
                }
                pred[c] = (pred[c] + diff).clamp(-32768, 32767);
                let tbl = (bits - 2) as usize;
                idx[c] = (idx[c] + INDEX_TABLE[tbl][(mag as usize).min(15)]).clamp(0, 88);
                ch_out[c].push(pred[c] as i16);
            }
        }
    }
    let n = ch_out[0].len();
    for i in 0..n {
        for c in 0..channels {
            out.push(*ch_out[c].get(i).unwrap_or(&0));
        }
    }
    out
}

pub fn extract(snd: &Sound) -> Result<(String, Vec<u8>, u32, u8)> {
    let rate = snd.format.sample_rate as u32;
    let ch = if snd.format.is_stereo { 2 } else { 1 };
    match snd.format.compression {
        AudioCompression::Mp3 => {
            // first two bytes are the encoder delay in samples; decode to PCM so the game
            // only ever reads WAV (no decoding at load time).
            let d = snd.data.get(2..).unwrap_or(&[]);
            let mut dec = puremp3::Mp3Decoder::new(d);
            let mut pcm: Vec<i16> = Vec::new();
            let (mut out_rate, mut out_ch) = (rate, ch);
            while let Ok(f) = dec.next_frame() {
                out_rate = f.header.sample_rate.hz();
                out_ch = if matches!(f.header.channels, puremp3::Channels::Mono) { 1 } else { 2 };
                for i in 0..f.num_samples {
                    let l = (f.samples[0][i].clamp(-1.0, 1.0) * 32767.0) as i16;
                    pcm.push(l);
                    if out_ch == 2 {
                        pcm.push((f.samples[1][i].clamp(-1.0, 1.0) * 32767.0) as i16);
                    }
                }
            }
            Ok((format!("{}.wav", snd.id), wav(out_rate, out_ch, &pcm), out_rate, out_ch))
        }
        AudioCompression::Uncompressed | AudioCompression::UncompressedUnknownEndian => {
            let pcm: Vec<i16> = if snd.format.is_16_bit {
                snd.data.chunks_exact(2).map(|b| i16::from_le_bytes([b[0], b[1]])).collect()
            } else {
                snd.data.iter().map(|&b| ((b as i16) - 128) << 8).collect()
            };
            Ok((format!("{}.wav", snd.id), wav(rate, ch, &pcm), rate, ch))
        }
        AudioCompression::Adpcm => {
            let pcm = adpcm(snd.data, ch as usize);
            Ok((format!("{}.wav", snd.id), wav(rate, ch, &pcm), rate, ch))
        }
        other => bail!("unsupported sound compression {:?}", other),
    }
}
