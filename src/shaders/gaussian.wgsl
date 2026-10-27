struct VertexOutput {
    @builtin(position) position: vec4f,
    @location(0) @interpolate(flat) color: vec3f,
};

struct Splat {
    pos_size: array<u32,2>,
    color: array<u32,2>,
    conic_opacity: array<u32,2>,
};

@group(0) @binding(0) var<storage, read> splats: array<Splat>;
@group(0) @binding(1) var<storage, read> sorted_indices: array<u32>;

@vertex
fn vs_main(@builtin(vertex_index) vi: u32,
           @builtin(instance_index) ii: u32) -> VertexOutput {
    let s = splats[sorted_indices[ii]];
    let center = unpack2x16float(s.pos_size[0]);
    let size = unpack2x16float(s.pos_size[1]);
    let c = array<vec2f,6>(vec2f(-1,-1), vec2f(1,-1), vec2f(1,1),
                           vec2f(-1,-1), vec2f(1,1), vec2f(-1,1));
    var out: VertexOutput;
    out.position = vec4f(center + c[vi] * size, 0.0, 1.0);

    out.color = vec3f(
    unpack2x16float(s.color[0]),
    unpack2x16float(s.color[1]).x
);

    return out;
}

@fragment
fn fs_main(in: VertexOutput) -> @location(0) vec4f {
    return vec4f(in.color, 1.0);
}