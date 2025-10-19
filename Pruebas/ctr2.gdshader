shader_type canvas_item;

uniform float scanline_intensity : hint_range(0.0, 1.0) = 0.3;
uniform float vignette_strength : hint_range(0.0, 1.0) = 0.4;

void fragment() {
    vec2 uv = UV;
    vec4 col = texture(TEXTURE, uv);
    
    // Scanlines
    float scan = sin(uv.y * 800.0) * scanline_intensity;
    col.rgb -= scan;
    
    // Vignette
    float dist = length(uv - 0.5);
    col.rgb *= 1.0 - dist * vignette_strength;
    
    COLOR = col;
}
