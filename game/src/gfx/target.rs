//! Render targets: multisampled colour + stencil, with resolve texture.
use super::MSAA;

pub const STENCIL_FORMAT: wgpu::TextureFormat = wgpu::TextureFormat::Stencil8;

pub struct Target {
    pub width: u32,
    pub height: u32,
    pub format: wgpu::TextureFormat,
    pub msaa_view: wgpu::TextureView,
    pub resolve_tex: wgpu::Texture,
    pub resolve_view: wgpu::TextureView,
    pub stencil_view: wgpu::TextureView,
}

impl Target {
    pub fn new(device: &wgpu::Device, width: u32, height: u32, format: wgpu::TextureFormat) -> Target {
        let size = wgpu::Extent3d { width, height, depth_or_array_layers: 1 };
        let msaa = device.create_texture(&wgpu::TextureDescriptor {
            label: Some("msaa color"),
            size,
            mip_level_count: 1,
            sample_count: MSAA,
            dimension: wgpu::TextureDimension::D2,
            format,
            usage: wgpu::TextureUsages::RENDER_ATTACHMENT,
            view_formats: &[],
        });
        let resolve_tex = device.create_texture(&wgpu::TextureDescriptor {
            label: Some("resolve"),
            size,
            mip_level_count: 1,
            sample_count: 1,
            dimension: wgpu::TextureDimension::D2,
            format,
            usage: wgpu::TextureUsages::RENDER_ATTACHMENT | wgpu::TextureUsages::TEXTURE_BINDING | wgpu::TextureUsages::COPY_SRC,
            view_formats: &[],
        });
        let stencil = device.create_texture(&wgpu::TextureDescriptor {
            label: Some("stencil"),
            size,
            mip_level_count: 1,
            sample_count: MSAA,
            dimension: wgpu::TextureDimension::D2,
            format: STENCIL_FORMAT,
            usage: wgpu::TextureUsages::RENDER_ATTACHMENT,
            view_formats: &[],
        });
        Target {
            width,
            height,
            format,
            msaa_view: msaa.create_view(&Default::default()),
            resolve_view: resolve_tex.create_view(&Default::default()),
            resolve_tex,
            stencil_view: stencil.create_view(&Default::default()),
        }
    }
}
