//! GPU renderer (wgpu): tessellated Flash vector art, bitmaps, gradients, masks.
mod target;

use anyhow::{anyhow, Result};
use bytemuck::{Pod, Zeroable};
use snow_fmt::*;
use std::collections::HashMap;

pub use target::*;

pub const MSAA: u32 = 4;

#[repr(C)]
#[derive(Clone, Copy, Pod, Zeroable, Default)]
pub struct DrawParams {
    pub m0: [f32; 4],
    pub m1: [f32; 4],
    pub color: [f32; 4],
    pub cmul: [f32; 4],
    pub cadd: [f32; 4],
    pub fm0: [f32; 4],
    pub fm1: [f32; 4],
    pub fp: [f32; 4],
}

#[derive(Clone, Copy, PartialEq, Eq, Hash, Debug)]
pub enum StencilMode {
    None,
    /// draw only where stencil == ref
    Test,
    /// increment stencil where drawn (no colour)
    MaskWrite,
    /// decrement stencil where drawn (no colour)
    MaskErase,
}

#[derive(Clone, Copy, Debug)]
pub struct MeshHandle {
    pub buf: u32,
    pub vbyte: u64,
    pub ibyte: u64,
    pub icount: u32,
}

pub const TRANSIENT: u32 = u32::MAX;

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub struct TexId(pub u32);

struct GpuBuf {
    v: wgpu::Buffer,
    i: wgpu::Buffer,
}

struct Tex {
    _tex: wgpu::Texture,
    bind: wgpu::BindGroup,
}

enum Cmd {
    /// `layer` != NO_LAYER: sample the filtered offscreen layer instead of `tex`
    Draw { buf: u32, vbyte: u64, ibyte: u64, icount: u32, inst: u32, tex: u32, blend: u8, stencil: StencilMode, sref: u8, layer: u32 },
    Scissor(Option<[u32; 4]>),
}

const NO_LAYER: u32 = u32::MAX;
const FX_SLOT: u64 = 256;
const FX_SLOTS: u64 = 4096;

/// An offscreen group (a clip with display-list filters) recorded as its own command stream.
struct Layer {
    cmds: Vec<Cmd>,
    filters: Vec<Filter>,
}

/// A single-sample colour texture used by the filter chain.
struct PoolTex {
    view: wgpu::TextureView,
    bind: wgpu::BindGroup,
    id: TexId,
}

/// Offscreen resources for layers, sized like the current target.
struct Fx {
    key: (u32, u32, wgpu::TextureFormat),
    msaa: Target,
    shared_bind: wgpu::BindGroup,
    scratch: [PoolTex; 2],
    results: Vec<PoolTex>,
}

enum FxOp {
    Blur { dx: f32, dy: f32, n: u32 },
    Matrix([f32; 20]),
}

pub struct Renderer {
    pub device: wgpu::Device,
    pub queue: wgpu::Queue,
    shader: wgpu::ShaderModule,
    globals_buf: wgpu::Buffer,
    draw_layout: wgpu::BindGroupLayout,
    tex_layout: wgpu::BindGroupLayout,
    pipeline_layout: wgpu::PipelineLayout,
    pipelines: HashMap<(u8, StencilMode, wgpu::TextureFormat), wgpu::RenderPipeline>,
    sampler_linear: wgpu::Sampler,
    sampler_nearest: wgpu::Sampler,
    bufs: Vec<GpuBuf>,
    texs: Vec<Tex>,
    pub white: TexId,
    // per frame
    draws: Vec<DrawParams>,
    cmds: Vec<Cmd>,
    t_verts: Vec<[f32; 2]>,
    t_idx: Vec<u32>,
    draw_storage: Option<(wgpu::Buffer, u64)>,
    t_bufs: Option<(wgpu::Buffer, wgpu::Buffer, u64, u64)>,
    draw_bind: Option<wgpu::BindGroup>,
    layers: Vec<Layer>,
    stack: Vec<Vec<Cmd>>,
    fx: Option<Fx>,
    fx_ids: Vec<TexId>,
    fx_shader: wgpu::ShaderModule,
    fx_layout: wgpu::BindGroupLayout,
    fx_pipes: HashMap<wgpu::TextureFormat, wgpu::RenderPipeline>,
    fx_params: wgpu::Buffer,
    pub stats: FrameStats,
}

#[derive(Default, Clone, Copy, Debug)]
pub struct FrameStats {
    pub draws: u32,
    pub tris: u32,
}

impl Renderer {
    pub fn new(device: wgpu::Device, queue: wgpu::Queue) -> Renderer {
        let shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
            label: Some("shapes"),
            source: wgpu::ShaderSource::Wgsl(include_str!("shader.wgsl").into()),
        });
        let globals_buf = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("globals"),
            size: 16,
            usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
            mapped_at_creation: false,
        });
        let draw_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
            label: Some("draw layout"),
            entries: &[
                wgpu::BindGroupLayoutEntry {
                    binding: 0,
                    visibility: wgpu::ShaderStages::VERTEX,
                    ty: wgpu::BindingType::Buffer { ty: wgpu::BufferBindingType::Uniform, has_dynamic_offset: false, min_binding_size: None },
                    count: None,
                },
                wgpu::BindGroupLayoutEntry {
                    binding: 1,
                    visibility: wgpu::ShaderStages::VERTEX_FRAGMENT,
                    ty: wgpu::BindingType::Buffer { ty: wgpu::BufferBindingType::Storage { read_only: true }, has_dynamic_offset: false, min_binding_size: None },
                    count: None,
                },
                wgpu::BindGroupLayoutEntry {
                    binding: 2,
                    visibility: wgpu::ShaderStages::FRAGMENT,
                    ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering),
                    count: None,
                },
                wgpu::BindGroupLayoutEntry {
                    binding: 3,
                    visibility: wgpu::ShaderStages::FRAGMENT,
                    ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::NonFiltering),
                    count: None,
                },
            ],
        });
        let tex_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
            label: Some("tex layout"),
            entries: &[wgpu::BindGroupLayoutEntry {
                binding: 0,
                visibility: wgpu::ShaderStages::FRAGMENT,
                ty: wgpu::BindingType::Texture {
                    sample_type: wgpu::TextureSampleType::Float { filterable: true },
                    view_dimension: wgpu::TextureViewDimension::D2,
                    multisampled: false,
                },
                count: None,
            }],
        });
        let pipeline_layout = device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
            label: Some("pipeline layout"),
            bind_group_layouts: &[Some(&draw_layout), Some(&tex_layout)],
            immediate_size: 0,
        });
        let mk = |f: wgpu::FilterMode| {
            device.create_sampler(&wgpu::SamplerDescriptor {
                mag_filter: f,
                min_filter: f,
                mipmap_filter: wgpu::MipmapFilterMode::Nearest,
                ..Default::default()
            })
        };
        let sampler_linear = mk(wgpu::FilterMode::Linear);
        let sampler_nearest = mk(wgpu::FilterMode::Nearest);
        let fx_shader = device.create_shader_module(wgpu::ShaderModuleDescriptor {
            label: Some("filters"),
            source: wgpu::ShaderSource::Wgsl(include_str!("filter.wgsl").into()),
        });
        let fx_layout = device.create_bind_group_layout(&wgpu::BindGroupLayoutDescriptor {
            label: Some("filter layout"),
            entries: &[
                wgpu::BindGroupLayoutEntry {
                    binding: 0,
                    visibility: wgpu::ShaderStages::FRAGMENT,
                    ty: wgpu::BindingType::Buffer { ty: wgpu::BufferBindingType::Uniform, has_dynamic_offset: true, min_binding_size: wgpu::BufferSize::new(112) },
                    count: None,
                },
                wgpu::BindGroupLayoutEntry {
                    binding: 1,
                    visibility: wgpu::ShaderStages::FRAGMENT,
                    ty: wgpu::BindingType::Texture { sample_type: wgpu::TextureSampleType::Float { filterable: true }, view_dimension: wgpu::TextureViewDimension::D2, multisampled: false },
                    count: None,
                },
                wgpu::BindGroupLayoutEntry { binding: 2, visibility: wgpu::ShaderStages::FRAGMENT, ty: wgpu::BindingType::Sampler(wgpu::SamplerBindingType::Filtering), count: None },
            ],
        });
        let fx_params = device.create_buffer(&wgpu::BufferDescriptor {
            label: Some("filter params"),
            size: FX_SLOT * FX_SLOTS,
            usage: wgpu::BufferUsages::UNIFORM | wgpu::BufferUsages::COPY_DST,
            mapped_at_creation: false,
        });
        let mut r = Renderer {
            device,
            queue,
            shader,
            globals_buf,
            draw_layout,
            tex_layout,
            pipeline_layout,
            pipelines: HashMap::new(),
            sampler_linear,
            sampler_nearest,
            bufs: Vec::new(),
            texs: Vec::new(),
            white: TexId(0),
            draws: Vec::new(),
            cmds: Vec::new(),
            t_verts: Vec::new(),
            t_idx: Vec::new(),
            draw_storage: None,
            t_bufs: None,
            draw_bind: None,
            layers: Vec::new(),
            stack: Vec::new(),
            fx: None,
            fx_ids: Vec::new(),
            fx_shader,
            fx_layout,
            fx_pipes: HashMap::new(),
            fx_params,
            stats: FrameStats::default(),
        };
        r.white = r.create_texture(1, 1, &[255, 255, 255, 255]);
        r
    }

    /// Uploads RGBA8 (straight alpha) pixels.
    pub fn create_texture(&mut self, w: u32, h: u32, rgba: &[u8]) -> TexId {
        let tex = self.device.create_texture(&wgpu::TextureDescriptor {
            label: None,
            size: wgpu::Extent3d { width: w, height: h, depth_or_array_layers: 1 },
            mip_level_count: 1,
            sample_count: 1,
            dimension: wgpu::TextureDimension::D2,
            format: wgpu::TextureFormat::Rgba8Unorm,
            usage: wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_DST,
            view_formats: &[],
        });
        self.queue.write_texture(
            tex.as_image_copy(),
            rgba,
            wgpu::TexelCopyBufferLayout { offset: 0, bytes_per_row: Some(4 * w), rows_per_image: Some(h) },
            wgpu::Extent3d { width: w, height: h, depth_or_array_layers: 1 },
        );
        let view = tex.create_view(&Default::default());
        let bind = self.device.create_bind_group(&wgpu::BindGroupDescriptor {
            label: None,
            layout: &self.tex_layout,
            entries: &[wgpu::BindGroupEntry { binding: 0, resource: wgpu::BindingResource::TextureView(&view) }],
        });
        self.texs.push(Tex { _tex: tex, bind });
        TexId(self.texs.len() as u32 - 1)
    }

    /// Releases the GPU memory of a texture created by `create_texture` (the id stays valid but blank).
    pub fn destroy_texture(&mut self, id: TexId) {
        if id.0 <= 0 || id.0 as usize >= self.texs.len() {
            return;
        }
        let w = self.texs[0].bind.clone();
        let t = &mut self.texs[id.0 as usize];
        t.bind = w;
        t._tex.destroy();
    }

    /// Replaces the pixels of an existing texture of identical size (used for video frames).
    pub fn update_texture(&mut self, id: TexId, w: u32, h: u32, rgba: &[u8]) {
        let t = &self.texs[id.0 as usize];
        self.queue.write_texture(
            t._tex.as_image_copy(),
            rgba,
            wgpu::TexelCopyBufferLayout { offset: 0, bytes_per_row: Some(4 * w), rows_per_image: Some(h) },
            wgpu::Extent3d { width: w, height: h, depth_or_array_layers: 1 },
        );
    }

    /// Uploads the meshes of one library's shapes into a single GPU buffer pair.
    pub fn upload_meshes(&mut self, meshes: &[(&[[f32; 2]], &[u32])]) -> Vec<MeshHandle> {
        let mut verts: Vec<[f32; 2]> = Vec::new();
        let mut idx: Vec<u32> = Vec::new();
        let mut handles = Vec::new();
        let buf = self.bufs.len() as u32;
        for (v, i) in meshes {
            let vbyte = (verts.len() * 8) as u64;
            let ibyte = (idx.len() * 4) as u64;
            verts.extend_from_slice(v);
            // indices stay relative; base vertex is folded in so each mesh is self-contained
            let base = (vbyte / 8) as u32;
            idx.extend(i.iter().map(|x| x + base));
            handles.push(MeshHandle { buf, vbyte, ibyte, icount: i.len() as u32 });
        }
        use wgpu::util::DeviceExt;
        let v = self.device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
            label: None,
            contents: bytemuck::cast_slice(if verts.is_empty() { &[[0.0f32; 2]] } else { &verts }),
            usage: wgpu::BufferUsages::VERTEX,
        });
        let i = self.device.create_buffer_init(&wgpu::util::BufferInitDescriptor {
            label: None,
            contents: bytemuck::cast_slice(if idx.is_empty() { &[0u32] } else { &idx }),
            usage: wgpu::BufferUsages::INDEX,
        });
        self.bufs.push(GpuBuf { v, i });
        handles
    }

    fn pipeline(&mut self, blend: u8, stencil: StencilMode, format: wgpu::TextureFormat) -> &wgpu::RenderPipeline {
        let key = (blend, stencil, format);
        if !self.pipelines.contains_key(&key) {
            let bs = blend_state(blend);
            let color_write = match stencil {
                StencilMode::MaskWrite | StencilMode::MaskErase => wgpu::ColorWrites::empty(),
                _ => wgpu::ColorWrites::ALL,
            };
            let face = |op: wgpu::StencilOperation| wgpu::StencilFaceState {
                compare: if stencil == StencilMode::None { wgpu::CompareFunction::Always } else { wgpu::CompareFunction::Equal },
                fail_op: wgpu::StencilOperation::Keep,
                depth_fail_op: wgpu::StencilOperation::Keep,
                pass_op: op,
            };
            let op = match stencil {
                StencilMode::MaskWrite => wgpu::StencilOperation::IncrementClamp,
                StencilMode::MaskErase => wgpu::StencilOperation::DecrementClamp,
                _ => wgpu::StencilOperation::Keep,
            };
            let p = self.device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
                label: None,
                layout: Some(&self.pipeline_layout),
                vertex: wgpu::VertexState {
                    module: &self.shader,
                    entry_point: Some("vs_main"),
                    compilation_options: Default::default(),
                    buffers: &[Some(wgpu::VertexBufferLayout {
                        array_stride: 8,
                        step_mode: wgpu::VertexStepMode::Vertex,
                        attributes: &wgpu::vertex_attr_array![0 => Float32x2],
                    })],
                },
                fragment: Some(wgpu::FragmentState {
                    module: &self.shader,
                    entry_point: Some("fs_main"),
                    compilation_options: Default::default(),
                    targets: &[Some(wgpu::ColorTargetState { format, blend: Some(bs), write_mask: color_write })],
                }),
                primitive: wgpu::PrimitiveState { topology: wgpu::PrimitiveTopology::TriangleList, cull_mode: None, ..Default::default() },
                depth_stencil: Some(wgpu::DepthStencilState {
                    format: STENCIL_FORMAT,
                    depth_write_enabled: Some(false),
                    depth_compare: Some(wgpu::CompareFunction::Always),
                    stencil: wgpu::StencilState { front: face(op), back: face(op), read_mask: 0xff, write_mask: 0xff },
                    bias: Default::default(),
                }),
                multisample: wgpu::MultisampleState { count: MSAA, mask: !0, alpha_to_coverage_enabled: false },
                multiview_mask: None,
                cache: None,
            });
            self.pipelines.insert(key, p);
        }
        &self.pipelines[&key]
    }

    // ---- frame recording -------------------------------------------------

    pub fn begin_frame(&mut self) {
        self.draws.clear();
        self.cmds.clear();
        self.t_verts.clear();
        self.t_idx.clear();
        self.layers.clear();
        self.stack.clear();
        self.stats = FrameStats::default();
    }

    /// Starts recording an offscreen group (filters); everything drawn until `end_layer` goes into it.
    pub fn begin_layer(&mut self) {
        let parent = std::mem::take(&mut self.cmds);
        self.stack.push(parent);
    }

    /// Ends the group and composites it (after `filters`) into the enclosing stream with the
    /// given colour transform, blend and stencil test.
    pub fn end_layer(&mut self, filters: &[Filter], cx: &CXform, blend: u8, stencil: StencilMode, sref: u8) {
        let Some(parent) = self.stack.pop() else { return };
        let cmds = std::mem::replace(&mut self.cmds, parent);
        self.layers.push(Layer { cmds, filters: filters.to_vec() });
        let li = self.layers.len() as u32 - 1;
        let big = 16384.0;
        let vbyte = (self.t_verts.len() * 8) as u64;
        let ibyte = (self.t_idx.len() * 4) as u64;
        let base = self.t_verts.len() as u32;
        self.t_verts.extend_from_slice(&[[-big, -big], [big, -big], [big, big], [-big, big]]);
        self.t_idx.extend([0u32, 1, 2, 0, 2, 3].iter().map(|i| i + base));
        let inst = self.draws.len() as u32;
        self.draws.push(DrawParams {
            m0: [1.0, 0.0, 0.0, 1.0],
            m1: [0.0, 0.0, 5.0, 0.0],
            color: [1.0; 4],
            cmul: cx.mul,
            cadd: cx.add,
            fm0: [1.0, 0.0, 0.0, 1.0],
            fm1: [0.0; 4],
            fp: [1.0, 1.0, 0.0, 1.0],
        });
        self.cmds.push(Cmd::Draw { buf: TRANSIENT, vbyte, ibyte, icount: 6, inst, tex: 0, blend, stencil, sref, layer: li });
    }

    /// Queues one mesh draw. `world` maps shape space to stage pixels.
    pub fn draw(&mut self, mesh: MeshHandle, world: &Matrix, cx: &CXform, fill: &FillRef, blend: u8, stencil: StencilMode, sref: u8) {
        let (params, tex) = fill_params(world, cx, fill);
        let inst = self.draws.len() as u32;
        self.draws.push(params);
        self.cmds.push(Cmd::Draw { buf: mesh.buf, vbyte: mesh.vbyte, ibyte: mesh.ibyte, icount: mesh.icount, inst, tex: tex.0, blend, stencil, sref, layer: NO_LAYER });
        self.stats.draws += 1;
        self.stats.tris += mesh.icount / 3;
    }

    /// Queues geometry that exists for this frame only (text, procedural shapes).
    pub fn draw_transient(&mut self, verts: &[[f32; 2]], indices: &[u32], world: &Matrix, cx: &CXform, fill: &FillRef, blend: u8, stencil: StencilMode, sref: u8) {
        let base = self.t_verts.len() as u32;
        let vbyte = (self.t_verts.len() * 8) as u64;
        let ibyte = (self.t_idx.len() * 4) as u64;
        self.t_verts.extend_from_slice(verts);
        self.t_idx.extend(indices.iter().map(|i| i + base));
        let mesh = MeshHandle { buf: TRANSIENT, vbyte, ibyte, icount: indices.len() as u32 };
        self.draw(mesh, world, cx, fill, blend, stencil, sref);
    }

    pub fn set_scissor(&mut self, rect: Option<[u32; 4]>) {
        self.cmds.push(Cmd::Scissor(rect));
    }

    /// Flushes recorded draws into `encoder` on the given (multisampled) target.
    pub fn flush(
        &mut self,
        encoder: &mut wgpu::CommandEncoder,
        target: &Target,
        resolve: Option<&wgpu::TextureView>,
        clear: Option<wgpu::Color>,
        view: [f32; 4],
        viewport: [f32; 4],
    ) {
        self.queue.write_buffer(&self.globals_buf, 0, bytemuck::cast_slice(&view));
        // layer composites sample their texture 1:1, so they need the target size
        for stream in std::iter::once(&self.cmds).chain(self.layers.iter().map(|l| &l.cmds)) {
            for c in stream {
                if let Cmd::Draw { inst, layer, .. } = c {
                    if *layer != NO_LAYER {
                        self.draws[*inst as usize].fp = [target.width as f32, target.height as f32, 0.0, 1.0];
                    }
                }
            }
        }
        // storage of draw params
        let need = (self.draws.len().max(1) * std::mem::size_of::<DrawParams>()) as u64;
        let regrow = self.draw_storage.as_ref().map(|s| s.1 < need).unwrap_or(true);
        if regrow {
            let size = need.next_power_of_two().max(64 * 1024);
            let b = self.device.create_buffer(&wgpu::BufferDescriptor {
                label: Some("draw params"),
                size,
                usage: wgpu::BufferUsages::STORAGE | wgpu::BufferUsages::COPY_DST,
                mapped_at_creation: false,
            });
            self.draw_storage = Some((b, size));
            self.draw_bind = None;
        }
        if !self.draws.is_empty() {
            self.queue.write_buffer(&self.draw_storage.as_ref().unwrap().0, 0, bytemuck::cast_slice(&self.draws));
        }
        if self.draw_bind.is_none() {
            self.draw_bind = Some(self.device.create_bind_group(&wgpu::BindGroupDescriptor {
                label: None,
                layout: &self.draw_layout,
                entries: &[
                    wgpu::BindGroupEntry { binding: 0, resource: self.globals_buf.as_entire_binding() },
                    wgpu::BindGroupEntry { binding: 1, resource: self.draw_storage.as_ref().unwrap().0.as_entire_binding() },
                    wgpu::BindGroupEntry { binding: 2, resource: wgpu::BindingResource::Sampler(&self.sampler_linear) },
                    wgpu::BindGroupEntry { binding: 3, resource: wgpu::BindingResource::Sampler(&self.sampler_nearest) },
                ],
            }));
        }
        // transient geometry
        let vneed = (self.t_verts.len().max(1) * 8) as u64;
        let ineed = (self.t_idx.len().max(1) * 4) as u64;
        let regrow = self.t_bufs.as_ref().map(|b| b.2 < vneed || b.3 < ineed).unwrap_or(true);
        if regrow {
            let vs = vneed.next_power_of_two().max(64 * 1024);
            let is = ineed.next_power_of_two().max(64 * 1024);
            let v = self.device.create_buffer(&wgpu::BufferDescriptor { label: Some("t verts"), size: vs, usage: wgpu::BufferUsages::VERTEX | wgpu::BufferUsages::COPY_DST, mapped_at_creation: false });
            let i = self.device.create_buffer(&wgpu::BufferDescriptor { label: Some("t idx"), size: is, usage: wgpu::BufferUsages::INDEX | wgpu::BufferUsages::COPY_DST, mapped_at_creation: false });
            self.t_bufs = Some((v, i, vs, is));
        }
        if !self.t_verts.is_empty() {
            let (v, i, _, _) = self.t_bufs.as_ref().unwrap();
            self.queue.write_buffer(v, 0, bytemuck::cast_slice(&self.t_verts));
            self.queue.write_buffer(i, 0, bytemuck::cast_slice(&self.t_idx));
        }

        // make sure all pipelines exist before the passes borrow them
        let fmt = target.format;
        let mut keys: Vec<(u8, StencilMode)> = Vec::new();
        for stream in std::iter::once(&self.cmds).chain(self.layers.iter().map(|l| &l.cmds)) {
            for c in stream {
                if let Cmd::Draw { blend, stencil, .. } = c {
                    keys.push((*blend, *stencil));
                }
            }
        }
        for (b, s) in keys {
            self.pipeline(b, s, fmt);
        }

        // offscreen layers: render, then run their filter chains
        if !self.layers.is_empty() {
            let scale = viewport[2] / (2.0 / view[0]).abs();
            self.ensure_fx(target.width, target.height, fmt);
            let mut slot = 0u64;
            for li in 0..self.layers.len() {
                let fx = self.fx.as_ref().unwrap();
                self.run_pass(encoder, "layer", &self.layers[li].cmds, &fx.msaa.msaa_view, &fx.msaa.resolve_view, &fx.msaa.stencil_view, Some(wgpu::Color::TRANSPARENT), viewport, fmt, (target.width, target.height));
                self.run_filters(encoder, li, target.width, target.height, scale, &mut slot);
            }
        }
        self.run_pass(encoder, "scene", &self.cmds, &target.msaa_view, resolve.unwrap_or(&target.resolve_view), &target.stencil_view, clear, viewport, fmt, (target.width, target.height));
    }

    fn run_pass(
        &self,
        encoder: &mut wgpu::CommandEncoder,
        label: &str,
        cmds: &[Cmd],
        msaa: &wgpu::TextureView,
        resolve: &wgpu::TextureView,
        stencil: &wgpu::TextureView,
        clear: Option<wgpu::Color>,
        viewport: [f32; 4],
        fmt: wgpu::TextureFormat,
        size: (u32, u32),
    ) {
        let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
            label: Some(label),
            color_attachments: &[Some(wgpu::RenderPassColorAttachment {
                view: msaa,
                depth_slice: None,
                resolve_target: Some(resolve),
                ops: wgpu::Operations {
                    load: match clear {
                        Some(c) => wgpu::LoadOp::Clear(c),
                        None => wgpu::LoadOp::Load,
                    },
                    store: wgpu::StoreOp::Discard,
                },
            })],
            depth_stencil_attachment: Some(wgpu::RenderPassDepthStencilAttachment {
                view: stencil,
                depth_ops: None,
                stencil_ops: Some(wgpu::Operations { load: wgpu::LoadOp::Clear(0), store: wgpu::StoreOp::Discard }),
            }),
            timestamp_writes: None,
            occlusion_query_set: None,
            multiview_mask: None,
        });
        // viewport and scissor must lie inside the target (a stale size after a window resize
        // would otherwise be a validation error)
        let (tw, th) = (size.0 as f32, size.1 as f32);
        let x0 = viewport[0].clamp(0.0, tw);
        let y0 = viewport[1].clamp(0.0, th);
        let vw = viewport[2].min(tw - x0);
        let vh = viewport[3].min(th - y0);
        if vw < 1.0 || vh < 1.0 {
            return;
        }
        let clip_rect = |r: [u32; 4]| -> [u32; 4] {
            let x = r[0].min(size.0);
            let y = r[1].min(size.1);
            [x, y, r[2].min(size.0 - x), r[3].min(size.1 - y)]
        };
        let full = clip_rect([x0 as u32, y0 as u32, vw as u32, vh as u32]);
        pass.set_viewport(x0, y0, vw, vh, 0.0, 1.0);
        pass.set_scissor_rect(full[0], full[1], full[2], full[3]);
        pass.set_bind_group(0, self.draw_bind.as_ref(), &[]);
        let tb = self.t_bufs.as_ref().unwrap();
        for c in cmds {
            match c {
                Cmd::Scissor(r) => match r {
                    Some(r) => {
                        let r = clip_rect(*r);
                        pass.set_scissor_rect(r[0], r[1], r[2], r[3]);
                    }
                    None => pass.set_scissor_rect(full[0], full[1], full[2], full[3]),
                },
                Cmd::Draw { buf, vbyte, ibyte, icount, inst, tex, blend, stencil, sref, layer } => {
                    if *icount == 0 {
                        continue;
                    }
                    pass.set_pipeline(&self.pipelines[&(*blend, *stencil, fmt)]);
                    pass.set_stencil_reference(*sref as u32);
                    let bind = if *layer != NO_LAYER {
                        let id = self.fx.as_ref().unwrap().results[*layer as usize].id;
                        &self.texs[id.0 as usize].bind
                    } else {
                        &self.texs[*tex as usize].bind
                    };
                    pass.set_bind_group(1, bind, &[]);
                    let (vb, ib) = if *buf == TRANSIENT { (&tb.0, &tb.1) } else { (&self.bufs[*buf as usize].v, &self.bufs[*buf as usize].i) };
                    pass.set_vertex_buffer(0, vb.slice(*vbyte..));
                    pass.set_index_buffer(ib.slice(*ibyte..), wgpu::IndexFormat::Uint32);
                    // indices were stored with the vertex base folded in, relative to the buffer start;
                    // the vertex slice starts at `vbyte`, so rebase.
                    let base = -((*vbyte / 8) as i32);
                    pass.draw_indexed(0..*icount, base, *inst..*inst + 1);
                }
            }
        }
    }

    // ---- offscreen filter layers ------------------------------------------

    fn pool_tex(&mut self, w: u32, h: u32, fmt: wgpu::TextureFormat, extra: wgpu::TextureUsages) -> (wgpu::Texture, PoolTex) {
        let tex = self.device.create_texture(&wgpu::TextureDescriptor {
            label: Some("fx"),
            size: wgpu::Extent3d { width: w, height: h, depth_or_array_layers: 1 },
            mip_level_count: 1,
            sample_count: 1,
            dimension: wgpu::TextureDimension::D2,
            format: fmt,
            usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING | extra,
            view_formats: &[],
        });
        let view = tex.create_view(&Default::default());
        let bind = self.device.create_bind_group(&wgpu::BindGroupDescriptor {
            label: None,
            layout: &self.tex_layout,
            entries: &[wgpu::BindGroupEntry { binding: 0, resource: wgpu::BindingResource::TextureView(&view) }],
        });
        let fbind = self.fx_bind(&view);
        // register for the main pass (composite draws sample it); reuse ids across resizes
        let id = match self.fx_ids.pop() {
            Some(id) => {
                self.texs[id.0 as usize] = Tex { _tex: tex.clone(), bind };
                id
            }
            None => {
                self.texs.push(Tex { _tex: tex.clone(), bind });
                TexId(self.texs.len() as u32 - 1)
            }
        };
        (tex, PoolTex { view, bind: fbind, id })
    }

    fn fx_bind(&self, view: &wgpu::TextureView) -> wgpu::BindGroup {
        self.device.create_bind_group(&wgpu::BindGroupDescriptor {
            label: None,
            layout: &self.fx_layout,
            entries: &[
                wgpu::BindGroupEntry { binding: 0, resource: wgpu::BindingResource::Buffer(wgpu::BufferBinding { buffer: &self.fx_params, offset: 0, size: wgpu::BufferSize::new(112) }) },
                wgpu::BindGroupEntry { binding: 1, resource: wgpu::BindingResource::TextureView(view) },
                wgpu::BindGroupEntry { binding: 2, resource: wgpu::BindingResource::Sampler(&self.sampler_linear) },
            ],
        })
    }

    fn ensure_fx(&mut self, w: u32, h: u32, fmt: wgpu::TextureFormat) {
        let key = (w, h, fmt);
        if let Some(old) = self.fx.take() {
            if old.key == key {
                let n = self.layers.len();
                self.fx = Some(old);
                while self.fx.as_ref().unwrap().results.len() < n {
                    let (_, t) = self.pool_tex(w, h, fmt, wgpu::TextureUsages::empty());
                    self.fx.as_mut().unwrap().results.push(t);
                }
                self.ensure_fx_pipeline(fmt);
                return;
            }
            // size or format changed: recycle the texture ids
            self.fx_ids.extend(old.results.iter().chain(old.scratch.iter()).map(|t| t.id));
        }
        let msaa = Target::new(&self.device, w, h, fmt);
        let shared_bind = self.fx_bind(&msaa.resolve_view);
        let (_, s0) = self.pool_tex(w, h, fmt, wgpu::TextureUsages::empty());
        let (_, s1) = self.pool_tex(w, h, fmt, wgpu::TextureUsages::empty());
        let mut results = Vec::new();
        for _ in 0..self.layers.len() {
            let (_, t) = self.pool_tex(w, h, fmt, wgpu::TextureUsages::empty());
            results.push(t);
        }
        self.fx = Some(Fx { key, msaa, shared_bind, scratch: [s0, s1], results });
        self.ensure_fx_pipeline(fmt);
    }

    fn ensure_fx_pipeline(&mut self, fmt: wgpu::TextureFormat) {
        if self.fx_pipes.contains_key(&fmt) {
            return;
        }
        let layout = self.device.create_pipeline_layout(&wgpu::PipelineLayoutDescriptor { label: Some("filter pipeline layout"), bind_group_layouts: &[Some(&self.fx_layout)], immediate_size: 0 });
        let p = self.device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
            label: Some("filters"),
            layout: Some(&layout),
            vertex: wgpu::VertexState { module: &self.fx_shader, entry_point: Some("vs_main"), compilation_options: Default::default(), buffers: &[] },
            fragment: Some(wgpu::FragmentState {
                module: &self.fx_shader,
                entry_point: Some("fs_main"),
                compilation_options: Default::default(),
                targets: &[Some(wgpu::ColorTargetState { format: fmt, blend: None, write_mask: wgpu::ColorWrites::ALL })],
            }),
            primitive: wgpu::PrimitiveState::default(),
            depth_stencil: None,
            multisample: wgpu::MultisampleState::default(),
            multiview_mask: None,
            cache: None,
        });
        self.fx_pipes.insert(fmt, p);
    }

    /// Applies layer `li`'s filters to the freshly resolved shared texture; the result lands in `results[li]`.
    fn run_filters(&self, encoder: &mut wgpu::CommandEncoder, li: usize, w: u32, h: u32, scale: f32, slot: &mut u64) {
        let fx = self.fx.as_ref().unwrap();
        let mut ops: Vec<FxOp> = Vec::new();
        for f in &self.layers[li].filters {
            match f {
                Filter::Blur { x, y, passes } => {
                    let nx = (x * scale).round().clamp(1.0, 96.0) as u32;
                    let ny = (y * scale).round().clamp(1.0, 96.0) as u32;
                    for _ in 0..(*passes).clamp(1, 3) {
                        if nx > 1 {
                            ops.push(FxOp::Blur { dx: 1.0, dy: 0.0, n: nx });
                        }
                        if ny > 1 {
                            ops.push(FxOp::Blur { dx: 0.0, dy: 1.0, n: ny });
                        }
                    }
                }
                Filter::ColorMatrix(m) => ops.push(FxOp::Matrix(*m)),
            }
        }
        if ops.is_empty() {
            let mut id = [0.0f32; 20];
            id[0] = 1.0;
            id[6] = 1.0;
            id[12] = 1.0;
            id[18] = 1.0;
            ops.push(FxOp::Matrix(id));
        }
        let pipe = &self.fx_pipes[&fx.key.2];
        let last = ops.len() - 1;
        let mut cur: &wgpu::BindGroup = &fx.shared_bind;
        for (i, op) in ops.iter().enumerate() {
            if *slot >= FX_SLOTS {
                break;
            }
            let mut p = [0.0f32; 28];
            p[4] = w as f32;
            p[5] = h as f32;
            match op {
                FxOp::Blur { dx, dy, n } => {
                    p[1] = *n as f32;
                    p[2] = *dx;
                    p[3] = *dy;
                }
                FxOp::Matrix(m) => {
                    p[0] = 1.0;
                    for r in 0..4 {
                        for c in 0..4 {
                            p[8 + r * 4 + c] = m[r * 5 + c];
                        }
                        // SWF stores the translation column in 0..255 units
                        p[24 + r] = m[r * 5 + 4] / 255.0;
                    }
                }
            }
            let offset = *slot * FX_SLOT;
            *slot += 1;
            self.queue.write_buffer(&self.fx_params, offset, bytemuck::cast_slice(&p));
            let dst = if i == last { &fx.results[li] } else { &fx.scratch[i % 2] };
            {
                let mut pass = encoder.begin_render_pass(&wgpu::RenderPassDescriptor {
                    label: Some("filter"),
                    color_attachments: &[Some(wgpu::RenderPassColorAttachment {
                        view: &dst.view,
                        depth_slice: None,
                        resolve_target: None,
                        ops: wgpu::Operations { load: wgpu::LoadOp::Clear(wgpu::Color::TRANSPARENT), store: wgpu::StoreOp::Store },
                    })],
                    depth_stencil_attachment: None,
                    timestamp_writes: None,
                    occlusion_query_set: None,
                    multiview_mask: None,
                });
                pass.set_pipeline(pipe);
                pass.set_bind_group(0, cur, &[offset as u32]);
                pass.draw(0..3, 0..1);
            }
            cur = &dst.bind;
        }
    }
}

fn blend_state(b: u8) -> wgpu::BlendState {
    use wgpu::{BlendComponent as C, BlendFactor as F, BlendOperation as O};
    let over = C { src_factor: F::One, dst_factor: F::OneMinusSrcAlpha, operation: O::Add };
    match b {
        // 1 = additive
        1 => wgpu::BlendState { color: C { src_factor: F::One, dst_factor: F::One, operation: O::Add }, alpha: over },
        // 2 = multiply
        2 => wgpu::BlendState { color: C { src_factor: F::Dst, dst_factor: F::OneMinusSrcAlpha, operation: O::Add }, alpha: over },
        // 3 = screen
        3 => wgpu::BlendState { color: C { src_factor: F::One, dst_factor: F::OneMinusSrc, operation: O::Add }, alpha: over },
        // 4 = erase / alpha-cut (destination alpha removed)
        4 => wgpu::BlendState { color: C { src_factor: F::Zero, dst_factor: F::OneMinusSrcAlpha, operation: O::Add }, alpha: C { src_factor: F::Zero, dst_factor: F::OneMinusSrcAlpha, operation: O::Add } },
        _ => wgpu::BlendState { color: over, alpha: over },
    }
}

pub fn blend_index(b: Blend) -> u8 {
    match b {
        Blend::Add => 1,
        Blend::Multiply => 2,
        Blend::Screen => 3,
        Blend::Erase => 4,
        _ => 0,
    }
}

/// What a mesh is filled with, resolved to GPU-side resources.
pub enum FillRef {
    Solid([f32; 4]),
    Bitmap { tex: TexId, size: (u32, u32), matrix: Matrix, smooth: bool, repeat: bool },
    Gradient { ramp: TexId, rows: u32, row: u32, kind: GradKind, matrix: Matrix, spread: Spread },
}

fn fill_params(world: &Matrix, cx: &CXform, fill: &FillRef) -> (DrawParams, TexId) {
    let mut p = DrawParams {
        m0: [world.a, world.b, world.c, world.d],
        m1: [world.tx, world.ty, 0.0, 0.0],
        color: [1.0; 4],
        cmul: cx.mul,
        cadd: cx.add,
        fm0: [1.0, 0.0, 0.0, 1.0],
        fm1: [0.0; 4],
        fp: [1.0, 1.0, 0.0, 1.0],
    };
    let mut tex = TexId(0);
    match fill {
        FillRef::Solid(c) => p.color = *c,
        FillRef::Bitmap { tex: t, size, matrix, smooth, repeat } => {
            // SWF bitmap matrices map bitmap pixels (in twips-scaled units) to shape space.
            // The stored matrix has a,b,c,d unitless and tx,ty in pixels; bitmap pixels are 1 unit wide
            // after the 1/20 twip scale which `swfx` already folded into a,b,c,d.
            let inv = matrix.inverse();
            p.m1[2] = 1.0;
            p.fm0 = [inv.a, inv.b, inv.c, inv.d];
            p.fm1 = [inv.tx, inv.ty, 0.0, 0.0];
            p.fp = [size.0 as f32, size.1 as f32, (*smooth as u32 | ((*repeat as u32) << 1)) as f32, 1.0];
            tex = *t;
        }
        FillRef::Gradient { ramp, rows, row, kind, matrix, spread } => {
            // gradient space unit = 1/20 px per twip; matrix maps gradient twips -> shape pixels
            let m = Matrix { a: matrix.a / 20.0, b: matrix.b / 20.0, c: matrix.c / 20.0, d: matrix.d / 20.0, tx: matrix.tx, ty: matrix.ty };
            let inv = m.inverse();
            p.m1[2] = match kind {
                GradKind::Linear => 2.0,
                GradKind::Radial => 3.0,
                GradKind::Focal(_) => 4.0,
            };
            p.m1[3] = match spread {
                Spread::Pad => 0.0,
                Spread::Reflect => 1.0,
                Spread::Repeat => 2.0,
            };
            p.fm0 = [inv.a, inv.b, inv.c, inv.d];
            p.fm1 = [inv.tx, inv.ty, if let GradKind::Focal(f) = kind { *f } else { 0.0 }, *row as f32];
            p.fp = [1.0, 1.0, 0.0, *rows as f32];
            tex = *ramp;
        }
    }
    (p, tex)
}

/// Builds the 256-texel colour ramp of a gradient (premultiplication happens in the shader).
pub fn gradient_ramp(g: &GradFill) -> [[u8; 4]; 256] {
    let mut out = [[0u8; 4]; 256];
    let stops = &g.stops;
    if stops.is_empty() {
        return out;
    }
    let to_lin = |c: f32| if c <= 0.04045 { c / 12.92 } else { ((c + 0.055) / 1.055).powf(2.4) };
    let from_lin = |c: f32| if c <= 0.0031308 { c * 12.92 } else { 1.055 * c.powf(1.0 / 2.4) - 0.055 };
    for (i, o) in out.iter_mut().enumerate() {
        let t = i as f32 / 255.0;
        let mut c = stops[0].1;
        if t >= stops[stops.len() - 1].0 {
            c = stops[stops.len() - 1].1;
        } else if t > stops[0].0 {
            for w in stops.windows(2) {
                if t >= w[0].0 && t <= w[1].0 {
                    let span = (w[1].0 - w[0].0).max(1e-6);
                    let f = (t - w[0].0) / span;
                    for k in 0..4 {
                        let (a, b) = (w[0].1[k], w[1].1[k]);
                        c[k] = if g.linear_rgb && k < 3 { from_lin(to_lin(a) + (to_lin(b) - to_lin(a)) * f) } else { a + (b - a) * f };
                    }
                    break;
                }
            }
        }
        *o = [(c[0] * 255.0 + 0.5) as u8, (c[1] * 255.0 + 0.5) as u8, (c[2] * 255.0 + 0.5) as u8, (c[3] * 255.0 + 0.5) as u8];
    }
    out
}

pub fn anyhow_gpu<T>(r: Result<T, impl std::fmt::Display>) -> Result<T> {
    r.map_err(|e| anyhow!("{}", e))
}

/// Copies a resolved target into CPU memory (RGBA8, straight copy of the framebuffer bytes).
pub fn read_target(device: &wgpu::Device, queue: &wgpu::Queue, t: &Target) -> image::RgbaImage {
    let bpr = (t.width * 4 + 255) & !255;
    let buf = device.create_buffer(&wgpu::BufferDescriptor {
        label: Some("readback"),
        size: (bpr * t.height) as u64,
        usage: wgpu::BufferUsages::COPY_DST | wgpu::BufferUsages::MAP_READ,
        mapped_at_creation: false,
    });
    let mut enc = device.create_command_encoder(&Default::default());
    enc.copy_texture_to_buffer(
        t.resolve_tex.as_image_copy(),
        wgpu::TexelCopyBufferInfo { buffer: &buf, layout: wgpu::TexelCopyBufferLayout { offset: 0, bytes_per_row: Some(bpr), rows_per_image: Some(t.height) } },
        wgpu::Extent3d { width: t.width, height: t.height, depth_or_array_layers: 1 },
    );
    queue.submit([enc.finish()]);
    let slice = buf.slice(..);
    slice.map_async(wgpu::MapMode::Read, |_| {});
    let _ = device.poll(wgpu::PollType::wait_indefinitely());
    let data = slice.get_mapped_range().expect("map");
    let mut img = image::RgbaImage::new(t.width, t.height);
    for y in 0..t.height as usize {
        let row = &data[y * bpr as usize..y * bpr as usize + (t.width * 4) as usize];
        for x in 0..t.width as usize {
            let p = &row[x * 4..x * 4 + 4];
            let px = if matches!(t.format, wgpu::TextureFormat::Bgra8Unorm | wgpu::TextureFormat::Bgra8UnormSrgb) { [p[2], p[1], p[0], p[3]] } else { [p[0], p[1], p[2], p[3]] };
            img.put_pixel(x as u32, y as u32, image::Rgba(px));
        }
    }
    drop(data);
    buf.unmap();
    img
}
