//! Loading converted libraries and uploading them to the GPU.
use crate::gfx::*;
use anyhow::{Context, Result};
use rayon::prelude::*;
use snow_fmt::*;
use std::collections::{BTreeMap, HashMap};
use std::path::{Path, PathBuf};

pub struct GpuMeshFill {
    pub mesh: MeshHandle,
    pub fill: FillRef,
}

pub struct GpuShape {
    pub bounds: Rect,
    pub meshes: Vec<GpuMeshFill>,
    /// CPU copy of the triangle soup for hit testing.
    pub tris: Vec<[[f32; 2]; 3]>,
}

pub struct GpuLib {
    pub id: u32,
    pub lib: Library,
    pub shapes: HashMap<CharId, GpuShape>,
    pub morphs: HashMap<CharId, BTreeMap<u16, GpuShape>>,
    pub bitmaps: HashMap<CharId, (TexId, u32, u32)>,
    pub dir: PathBuf,
}

impl GpuLib {
    pub fn export(&self, name: &str) -> Option<CharId> {
        self.lib.exports.get(name).copied()
    }
}

struct Pending {
    lib: Library,
    images: Vec<(CharId, image::RgbaImage)>,
    dir: PathBuf,
}

/// Decodes libraries and their bitmaps on all cores; GPU upload happens on the calling thread.
pub fn load_libraries(rd: &mut Renderer, root: &Path, names: &[&str], first_id: u32) -> Result<Vec<GpuLib>> {
    let pending: Vec<Result<Pending>> = names
        .par_iter()
        .map(|n| {
            let dir = root.join(n);
            let lib = Library::load(&dir.join("lib.bin")).with_context(|| format!("loading library {}", n))?;
            let images: Vec<(CharId, image::RgbaImage)> = lib
                .bitmaps
                .par_iter()
                .map(|b| {
                    let p = dir.join("bitmaps").join(&b.file);
                    let img = image::open(&p).with_context(|| format!("{}", p.display()))?.to_rgba8();
                    Ok((b.id, img))
                })
                .collect::<Result<Vec<_>>>()?;
            Ok(Pending { lib, images, dir })
        })
        .collect();
    let mut out = Vec::new();
    for (i, p) in pending.into_iter().enumerate() {
        out.push(upload(rd, p?, first_id + i as u32));
    }
    Ok(out)
}

fn upload(rd: &mut Renderer, p: Pending, id: u32) -> GpuLib {
    let Pending { lib, images, dir } = p;
    let mut bitmaps = HashMap::new();
    for (cid, img) in &images {
        let tex = rd.create_texture(img.width(), img.height(), img.as_raw());
        bitmaps.insert(*cid, (tex, img.width(), img.height()));
    }
    // gradient ramps: one 256xN texture per library
    let mut ramp_rows: Vec<[[u8; 4]; 256]> = Vec::new();
    let mut ramp_of: HashMap<usize, u32> = HashMap::new(); // fill pointer -> row
    let mut collect = |s: &ShapeDef| {
        for m in &s.meshes {
            if let Fill::Gradient(g) = &m.fill {
                let key = g as *const GradFill as usize;
                ramp_of.entry(key).or_insert_with(|| {
                    ramp_rows.push(gradient_ramp(g));
                    ramp_rows.len() as u32 - 1
                });
            }
        }
    };
    for c in lib.chars.values() {
        match c {
            Char::Shape(s) => collect(s),
            Char::Morph(m) => m.frames.values().for_each(&mut collect),
            _ => {}
        }
    }
    for f in lib.fonts.values() {
        for g in &f.glyphs {
            collect(&g.shape);
        }
    }
    let rows = ramp_rows.len().max(1) as u32;
    let ramp_tex = {
        let mut px = Vec::with_capacity(256 * rows as usize * 4);
        if ramp_rows.is_empty() {
            px.extend_from_slice(&[255u8; 256 * 4]);
        }
        for r in &ramp_rows {
            for c in r {
                px.extend_from_slice(c);
            }
        }
        rd.create_texture(256, rows, &px)
    };

    let mut shapes = HashMap::new();
    let mut morphs = HashMap::new();
    let build = |rd: &mut Renderer, s: &ShapeDef| -> GpuShape {
        let refs: Vec<(&[[f32; 2]], &[u32])> = s.meshes.iter().map(|m| (&m.verts[..], &m.indices[..])).collect();
        let handles = rd.upload_meshes(&refs);
        let mut meshes = Vec::new();
        let mut tris = Vec::new();
        for (m, h) in s.meshes.iter().zip(handles) {
            let fill = match &m.fill {
                Fill::Solid(c) => FillRef::Solid(*c),
                Fill::Bitmap(b) => match bitmaps.get(&b.id) {
                    Some((t, w, hh)) => FillRef::Bitmap { tex: *t, size: (*w, *hh), matrix: bitmap_matrix(&b.matrix), smooth: b.smooth, repeat: b.repeat },
                    None => FillRef::Solid([1.0, 0.0, 1.0, 1.0]),
                },
                Fill::Gradient(g) => FillRef::Gradient {
                    ramp: ramp_tex,
                    rows,
                    row: ramp_of[&(g as *const GradFill as usize)],
                    kind: g.kind,
                    matrix: g.matrix,
                    spread: g.spread,
                },
            };
            for t in m.indices.chunks_exact(3) {
                tris.push([m.verts[t[0] as usize], m.verts[t[1] as usize], m.verts[t[2] as usize]]);
            }
            meshes.push(GpuMeshFill { mesh: h, fill });
        }
        GpuShape { bounds: s.bounds, meshes, tris }
    };
    for (cid, c) in &lib.chars {
        match c {
            Char::Shape(s) => {
                shapes.insert(*cid, build(rd, s));
            }
            Char::Morph(m) => {
                let mut frames = BTreeMap::new();
                for (r, s) in &m.frames {
                    frames.insert(*r, build(rd, s));
                }
                morphs.insert(*cid, frames);
            }
            _ => {}
        }
    }
    // font glyphs are uploaded lazily by the text engine (they are small and re-tinted per use)
    GpuLib { id, lib, shapes, morphs, bitmaps, dir }
}

/// SWF bitmap fill matrices are expressed against bitmap pixels scaled by 20 (twips);
/// the converter stored them as-is, so fold the 1/20 into the linear part here.
fn bitmap_matrix(m: &Matrix) -> Matrix {
    Matrix { a: m.a / 20.0, b: m.b / 20.0, c: m.c / 20.0, d: m.d / 20.0, tx: m.tx, ty: m.ty }
}
