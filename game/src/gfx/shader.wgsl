// Flash-style vector shape renderer: solid, bitmap and gradient fills, colour transforms.

struct Globals {
    // clip.x = p.x * view.x + view.z ; clip.y = p.y * view.y + view.w
    view: vec4<f32>,
};

struct Draw {
    m0: vec4<f32>,    // a b c d   (shape -> stage)
    m1: vec4<f32>,    // tx ty kind spread
    color: vec4<f32>, // solid colour (straight alpha)
    cmul: vec4<f32>,
    cadd: vec4<f32>,
    fm0: vec4<f32>,   // inverse fill matrix a b c d (stage-shape space -> fill space)
    fm1: vec4<f32>,   // tx ty focal ramp_row
    fp: vec4<f32>,    // tex_w tex_h flags(1=smooth,2=repeat) ramp_rows
};

@group(0) @binding(0) var<uniform> globals: Globals;
@group(0) @binding(1) var<storage, read> draws: array<Draw>;
@group(0) @binding(2) var samp_linear: sampler;
@group(0) @binding(3) var samp_nearest: sampler;
@group(1) @binding(0) var tex: texture_2d<f32>;

struct VOut {
    @builtin(position) pos: vec4<f32>,
    @location(0) local: vec2<f32>,
    @location(1) @interpolate(flat) idx: u32,
};

@vertex
fn vs_main(@location(0) p: vec2<f32>, @builtin(instance_index) idx: u32) -> VOut {
    let d = draws[idx];
    let x = d.m0.x * p.x + d.m0.z * p.y + d.m1.x;
    let y = d.m0.y * p.x + d.m0.w * p.y + d.m1.y;
    var o: VOut;
    o.pos = vec4<f32>(x * globals.view.x + globals.view.z, y * globals.view.y + globals.view.w, 0.0, 1.0);
    o.local = p;
    o.idx = idx;
    return o;
}

fn apply_spread(t: f32, spread: f32) -> f32 {
    if (spread < 0.5) {
        return clamp(t, 0.0, 1.0);
    } else if (spread < 1.5) {
        let r = t - 2.0 * floor(t / 2.0);
        return select(r, 2.0 - r, r > 1.0);
    }
    return t - floor(t);
}

@fragment
fn fs_main(in: VOut) -> @location(0) vec4<f32> {
    let d = draws[in.idx];
    let kind = i32(d.m1.z + 0.5);
    var c = d.color;
    if (kind == 5) {
        // offscreen filter layer (premultiplied), sampled 1:1 at this pixel
        let s = textureSampleLevel(tex, samp_nearest, in.pos.xy / d.fp.xy, 0.0);
        c = vec4<f32>(s.rgb / max(s.a, 1e-5), s.a);
    } else if (kind != 0) {
        let fx = d.fm0.x * in.local.x + d.fm0.z * in.local.y + d.fm1.x;
        let fy = d.fm0.y * in.local.x + d.fm0.w * in.local.y + d.fm1.y;
        if (kind == 1) {
            // bitmap fill: fill space is in bitmap pixels
            var uv = vec2<f32>(fx / d.fp.x, fy / d.fp.y);
            if ((i32(d.fp.z) & 2) != 0) {
                uv = fract(uv);
            } else {
                uv = clamp(uv, vec2<f32>(0.0), vec2<f32>(1.0));
            }
            let a = textureSampleLevel(tex, samp_linear, uv, 0.0);
            let b = textureSampleLevel(tex, samp_nearest, uv, 0.0);
            c = select(b, a, (i32(d.fp.z) & 1) != 0);
        } else {
            // gradient: fill space is the -16384..16384 twips box
            var t = 0.0;
            if (kind == 2) {
                t = fx / 32768.0 + 0.5;
            } else if (kind == 3) {
                t = length(vec2<f32>(fx, fy)) / 16384.0;
            } else {
                // focal radial gradient
                let fo = d.fm1.z;
                let p = vec2<f32>(fx, fy) / 16384.0;
                let f = vec2<f32>(fo, 0.0);
                let dir = p - f;
                let a = dot(dir, dir);
                let b = 2.0 * dot(f, dir);
                let cc = dot(f, f) - 1.0;
                let disc = max(b * b - 4.0 * a * cc, 0.0);
                let s = (-b + sqrt(disc)) / (2.0 * max(a, 1e-6));
                t = 1.0 / max(s, 1e-6);
            }
            t = apply_spread(t, d.m1.w);
            let v = (d.fm1.w + 0.5) / d.fp.w;
            c = textureSampleLevel(tex, samp_linear, vec2<f32>(t, v), 0.0);
        }
    }
    // colour transform on straight alpha, then premultiply
    var o = clamp(c * d.cmul + d.cadd, vec4<f32>(0.0), vec4<f32>(1.0));
    return vec4<f32>(o.rgb * o.a, o.a);
}
