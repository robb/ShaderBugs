#include <metal_stdlib>
#include <SwiftUI/SwiftUI_Metal.h>
using namespace metal;



[[ stitchable ]] float2 distortionEffectWithoutTexture(float2 position, float4 bounds) {
    float2 uv = position / bounds.zw;

    return bounds.zw * fmod(uv * 2, 1);
}

[[ stitchable ]] float2 distortionEffectWithTexture(float2 position, float4 bounds, texture2d<half> texture) {
    float2 uv = position / bounds.zw;

    return bounds.zw * fmod(uv * 2, 1);
}

[[ stitchable ]] half4 layerEffectWithoutTexture(float2 position, SwiftUI::Layer layer, float4 bounds) {
    float2 uv = position / bounds.zw;

    return layer.sample(position) - half4(uv.x / 4, 0, 0, 0);
}

[[ stitchable ]] half4 layerEffectWithTexture(float2 position, SwiftUI::Layer layer, float4 bounds, texture2d<half> texture) {
    float2 uv = position / bounds.zw;

    return layer.sample(position) - half4(uv.x / 4, 0, 0, 0);
}

// ---

[[ stitchable ]] half4 layerEffectNoExtraArguments(float2 position, SwiftUI::Layer layer) {
    return layer.sample(position + float2(4 * sin(position.y / 12 * M_PI_F), 0));
}

[[ stitchable ]] half4 layerEffectFloat2(float2 position, SwiftUI::Layer layer, float2 arg1) {
    return layer.sample(position + float2(4 * sin(position.y / 12 * M_PI_F), 0));
}

[[ stitchable ]] half4 layerEffectFloat2Float2(float2 position, SwiftUI::Layer layer, float2 arg1, float2 arg2) {
    return layer.sample(position + float2(4 * sin(position.y / 12 * M_PI_F), 0));
}

[[ stitchable ]] half4 layerEffectFloat2Float2Float2(float2 position, SwiftUI::Layer layer, float2 arg1, float2 arg2, float2 arg3) {
    return layer.sample(position + float2(4 * sin(position.y / 12 * M_PI_F), 0));
}
