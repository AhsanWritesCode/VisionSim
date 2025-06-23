//
//  centralBlur.metal
//  VisionSim4
//
//  Created by Ahsan Tariq on 2025-05-29.
//

#include <metal_stdlib>
using namespace metal;

// Per-frame uniforms
struct Uniforms {
    float blurRadius; // 0 = no blur, ~30 = strong blur
};

// Vertex shader (pass through)
vertex float4 passthroughVertex(
    const device float4* vertexArray [[buffer(0)]],
    uint vid [[vertex_id]]
) {
    return vertexArray[vid];
}

// Simple fragment shader doing a radial blur by sampling 8 neighbors
fragment half4 centralBlurFragment(
    float4 pos       [[position]],
    float2 uv        [[user(texturecoord)]],
    constant Uniforms& u [[buffer(0)]],
    texture2d<half>  colorTex [[texture(0)]],
    sampler          samp     [[sampler(0)]]
) {
    // sample center
    half4 accum = colorTex.sample(samp, uv);
    const int N = 8;
    half weight = 1.0 / (N + 1);
    accum *= weight;

    // radial blur: sample N points around the center
    float2 dir = uv - float2(0.5, 0.5);
    float dist = length(dir);
    if (dist > 0.0) {
        dir = normalize(dir);
        for (int i = 1; i <= N; i++) {
            float t = (i / float(N)) * (u.blurRadius / 300.0);
            float2 sampleUV = uv + dir * t;
            accum += colorTex.sample(samp, sampleUV) * weight;
        }
    }

    return accum;
}
