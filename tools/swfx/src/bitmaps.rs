//! SWF bitmap tags -> RGBA8 images.
use anyhow::{anyhow, Result};
use flate2::read::ZlibDecoder;
use image::RgbaImage;
use std::io::Read;
use swf::{BitmapFormat, DefineBitsLossless};

fn zlib(data: &[u8]) -> Result<Vec<u8>> {
    let mut out = Vec::new();
    ZlibDecoder::new(data).read_to_end(&mut out)?;
    Ok(out)
}

/// SWF JPEGs often hold an "abbreviated tables" stream followed by an image stream
/// (`FFD8 tables FFD9 FFD8 image FFD9`) and sometimes a stray leading `FFD9 FFD8`.
/// Merge them into one valid JPEG stream.
fn fix_jpeg(data: &[u8]) -> Vec<u8> {
    let mut d: Vec<u8> = data.to_vec();
    if d.len() > 4 && d[0] == 0xFF && d[1] == 0xD9 && d[2] == 0xFF && d[3] == 0xD8 {
        d.drain(..2);
    }
    // remove an embedded EOI+SOI pair (not the final EOI)
    let mut i = 2;
    while i + 4 <= d.len().saturating_sub(2) {
        if d[i] == 0xFF && d[i + 1] == 0xD9 && d[i + 2] == 0xFF && d[i + 3] == 0xD8 {
            d.drain(i..i + 4);
            continue;
        }
        i += 1;
    }
    d
}

pub fn decode_jpeg(data: &[u8]) -> Result<RgbaImage> {
    let data = fix_jpeg(data);
    let img = image::load_from_memory_with_format(&data, image::ImageFormat::Jpeg)?;
    Ok(img.to_rgba8())
}

pub fn decode_jpeg_with_tables(tables: &[u8], data: &[u8]) -> Result<RgbaImage> {
    if tables.len() <= 2 {
        return decode_jpeg(data);
    }
    let data = &fix_jpeg(data)[..];
    let mut buf = Vec::with_capacity(tables.len() + data.len());
    let t = if tables.len() >= 2 && tables[tables.len() - 2] == 0xFF && tables[tables.len() - 1] == 0xD9 {
        &tables[..tables.len() - 2]
    } else {
        tables
    };
    let d = if data.len() >= 2 && data[0] == 0xFF && data[1] == 0xD8 { &data[2..] } else { data };
    buf.extend_from_slice(t);
    buf.extend_from_slice(d);
    Ok(image::load_from_memory_with_format(&buf, image::ImageFormat::Jpeg)?.to_rgba8())
}

pub fn decode_jpeg3(data: &[u8], alpha: &[u8]) -> Result<RgbaImage> {
    let mut img = decode_jpeg(data)?;
    if !alpha.is_empty() {
        let a = zlib(alpha)?;
        for (i, px) in img.pixels_mut().enumerate() {
            if let Some(&v) = a.get(i) {
                px.0[3] = v;
            }
        }
    }
    Ok(img)
}

pub fn decode_lossless(t: &DefineBitsLossless) -> Result<RgbaImage> {
    let raw = zlib(&t.data)?;
    let (w, h) = (t.width as usize, t.height as usize);
    let mut img = RgbaImage::new(w as u32, h as u32);
    let v2 = t.version >= 2;
    match t.format {
        BitmapFormat::ColorMap8 { num_colors } => {
            let n = num_colors as usize + 1;
            let entry = if v2 { 4 } else { 3 };
            let table = raw.get(..n * entry).ok_or_else(|| anyhow!("short colormap"))?;
            let pix = &raw[n * entry..];
            let stride = (w + 3) & !3;
            for y in 0..h {
                for x in 0..w {
                    let i = *pix.get(y * stride + x).unwrap_or(&0) as usize;
                    let i = i.min(n - 1);
                    let (r, g, b, a) = if v2 {
                        (table[i * 4], table[i * 4 + 1], table[i * 4 + 2], table[i * 4 + 3])
                    } else {
                        (table[i * 3], table[i * 3 + 1], table[i * 3 + 2], 255)
                    };
                    img.put_pixel(x as u32, y as u32, image::Rgba(unpremul(r, g, b, a, v2)));
                }
            }
        }
        BitmapFormat::Rgb15 => {
            let stride = (w * 2 + 3) & !3;
            for y in 0..h {
                for x in 0..w {
                    let o = y * stride + x * 2;
                    let v = ((*raw.get(o).unwrap_or(&0) as u16) << 8) | *raw.get(o + 1).unwrap_or(&0) as u16;
                    let r = ((v >> 10) & 31) as u32 * 255 / 31;
                    let g = ((v >> 5) & 31) as u32 * 255 / 31;
                    let b = (v & 31) as u32 * 255 / 31;
                    img.put_pixel(x as u32, y as u32, image::Rgba([r as u8, g as u8, b as u8, 255]));
                }
            }
        }
        BitmapFormat::Rgb32 => {
            for y in 0..h {
                for x in 0..w {
                    let o = (y * w + x) * 4;
                    let p = raw.get(o..o + 4).ok_or_else(|| anyhow!("short rgb32"))?;
                    let px = if v2 { unpremul(p[1], p[2], p[3], p[0], true) } else { [p[1], p[2], p[3], 255] };
                    img.put_pixel(x as u32, y as u32, image::Rgba(px));
                }
            }
        }
    }
    Ok(img)
}

fn unpremul(r: u8, g: u8, b: u8, a: u8, premul: bool) -> [u8; 4] {
    if !premul || a == 255 || a == 0 {
        return [r, g, b, a];
    }
    let f = |c: u8| ((c as u32 * 255 + a as u32 / 2) / a as u32).min(255) as u8;
    [f(r), f(g), f(b), a]
}
