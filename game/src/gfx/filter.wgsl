// Flash display-list filters on offscreen layers: separable box blur and colour matrix.
struct P {
    mode: vec4<f32>, // x: 0 blur | 1 colour matrix, y: taps, z/w: step in pixels
    dims: vec4<f32>, // target width, height
    r0: vec4<f32>,
    r1: vec4<f32>,
    r2: vec4<f32>,
    r3: vec4<f32>,
    off: vec4<f32>,
};

@group(0) @binding(0) var<uniform> p: P;
@group(0) @binding(1) var src: texture_2d<f32>;
@group(0) @binding(2) var samp: sampler;

@vertex
fn vs_main(@builtin(vertex_index) i: u32) -> @builtin(position) vec4<f32> {
    let x = f32((i << 1u) & 2u);
    let y = f32(i & 2u);
    return vec4<f32>(x * 2.0 - 1.0, 1.0 - y * 2.0, 0.0, 1.0);
}

@fragment
fn fs_main(@builtin(position) pos: vec4<f32>) -> @location(0) vec4<f32> {
    let uv = pos.xy / p.dims.xy;
    if (p.mode.x < 0.5) {
        let n = i32(p.mode.y);
        let step = vec2<f32>(p.mode.z, p.mode.w) / p.dims.xy;
        let half = (f32(n) - 1.0) * 0.5;
        var acc = vec4<f32>(0.0);
        for (var i = 0; i < n; i = i + 1) {
            acc = acc + textureSampleLevel(src, samp, uv + step * (f32(i) - half), 0.0);
        }
        return acc / f32(n);
    }
    let s = textureSampleLevel(src, samp, uv, 0.0);
    let v = vec4<f32>(s.rgb / max(s.a, 1e-5), s.a);
    let o = clamp(vec4<f32>(dot(p.r0, v), dot(p.r1, v), dot(p.r2, v), dot(p.r3, v)) + p.off, vec4<f32>(0.0), vec4<f32>(1.0));
    return vec4<f32>(o.rgb * o.a, o.a);
}
