shader_type canvas_item;

uniform vec2 center = vec2(0.5, 0.5); // Centro de la imagen en coordenadas UV (0.0 a 1.0)
uniform float radius = 0.5; // Radio desde el centro en coordenadas UV (0.0 a 1.0)
uniform float softness = 0.1; // Suavidad del borde

void fragment() {
    vec2 uv = FRAGCOORD.xy / SCREEN_PIXEL_SIZE.xy;
    
    // Convertir a coordenadas UV de -1 a 1
    uv = (uv - vec2(0.5)) * vec2(2.0);
    
    // Calcular la distancia al centro
    float dist = distance(uv, center * 2.0 - vec2(1.0));
    
    // Calcular el alpha usando smoothstep para un borde suave
    float alpha = smoothstep(radius, radius - softness, dist);
    
    vec4 color = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE.xy);
    color.a *= alpha;
    
    COLOR = color;
}
