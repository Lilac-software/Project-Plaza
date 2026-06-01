shader_type spatial;
// Désactive l'éclairage par défaut de Godot pour qu'on le fasse nous-mêmes
render_mode diffuse_toon, specular_disabled;

// Les variables équivalentes à vos nœuds
uniform sampler2D base_texture : source_color;
uniform sampler2D color_ramp : source_color; // Utilisez un GradientTexture1D ici dans l'inspecteur
uniform float brightness : hint_range(-1.0, 1.0) = 0.5;
uniform float contrast : hint_range(0.0, 4.0) = 0.6;
uniform vec3 mix_color : source_color = vec3(0.5, 0.2, 0.0); // La couleur de votre nœud Mix

void fragment() {
    // Équivalent de l'Image Texture branchée au début
    vec4 tex_color = texture(base_texture, UV);
    ALBEDO = tex_color.rgb;
}

void light() {
    // 1. Calcul de la lumière diffuse de base (équivalent du 1er Diffuse BSDF)
    float NdotL = max(dot(NORMAL, LIGHT), 0.0);
    vec3 base_lighting = ALBEDO * LIGHT_COLOR * NdotL * ATTENUATION;
    
    // 2. Luminosité / Contraste
    // Conversion de l'intensité de la lumière en niveau de gris (masque)
    float light_intensity = length(base_lighting);
    light_intensity = (light_intensity - 0.5 + brightness) * contrast + 0.5;
    light_intensity = clamp(light_intensity, 0.0, 1.0);
    
    // 3. Color Ramp (Shader to RGB -> Brightness -> ColorRamp)
    // On lit la texture de gradient en fonction de l'intensité lumineuse
    vec3 ramp_val = texture(color_ramp, vec2(light_intensity, 0.5)).rgb;
    
    // 4. Les nœuds Mix et Color Dodge
    // On mixe la couleur d'origine (ALBEDO) avec une couleur en fonction du ramp
    // Remarque : Le Color Dodge mathématique est (Base / (1.0 - Blend))
    vec3 mixed_color = mix(ALBEDO, mix_color, ramp_val.r); 
    
    // Application de la couleur finale à la lumière de Godot
    DIFFUSE_LIGHT += mixed_color * LIGHT_COLOR * NdotL * ATTENUATION;
}
