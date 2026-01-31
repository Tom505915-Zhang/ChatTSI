#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(binding = 0) uniform sampler2D source;
layout(std140, binding = 1) uniform buf {
    vec4 tint;
} ubuf;

void main() {
    vec4 base = texture(source, qt_TexCoord0);
    vec3 glass = mix(base.rgb, ubuf.tint.rgb, 0.18);
    fragColor = vec4(glass, base.a);
}
