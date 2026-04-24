// ============================================================
// KAKUSEI 覚醒 — Cel Shader HD-2D
// Style cible : Pokémon Gamma Emerald / NIONX / Octopath Traveler
// Godot 4 — ShaderMaterial
// ============================================================

shader_type spatial;
render_mode cull_back, depth_draw_opaque, specular_disabled;

// --- Paramètres exposés dans l'Inspector ---

// Texture de base de l'asset
uniform sampler2D albedo_texture : source_color, hint_default_white;
uniform vec4 albedo_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// Cel shading — niveaux de couleur (4 = style Pokémon BW)
uniform float color_steps : hint_range(2.0, 8.0, 1.0) = 4.0;

// Lumière
uniform vec3 light_direction = vec3(-0.5, -0.8, -0.3);
uniform vec4 highlight_color : source_color = vec4(1.0, 0.98, 0.92, 1.0);
uniform vec4 shadow_color : source_color = vec4(0.55, 0.45, 0.65, 1.0);
uniform float shadow_intensity : hint_range(0.0, 1.0) = 0.45;

// Outline (contour noir style pixel art)
uniform vec4 outline_color : source_color = vec4(0.08, 0.05, 0.05, 1.0);
uniform float outline_thickness : hint_range(0.0, 3.0) = 1.2;

// Rim light (lueur de contour, profondeur HD-2D)
uniform float rim_power : hint_range(0.0, 8.0) = 2.5;
uniform float rim_intensity : hint_range(0.0, 1.0) = 0.25;
uniform vec4 rim_color : source_color = vec4(0.8, 0.9, 1.0, 1.0);

// ============================================================
// VERTEX — Outline par expansion de normales
// ============================================================
void vertex() {
	// Expansion des normales pour créer l'outline
	// (technique "inverted hull" standard cel shading)
	VERTEX += NORMAL * outline_thickness * 0.004;
}

// ============================================================
// FRAGMENT — Cel shading quantifié
// ============================================================
void fragment() {
	// 1. Couleur de base depuis texture
	vec4 tex_color = texture(albedo_texture, UV) * albedo_color;
	
	// 2. Calcul lumière diffuse (Lambert)
	vec3 light_dir = normalize(-light_direction);
	float n_dot_l = dot(NORMAL, light_dir);
	
	// 3. Quantification en paliers = effet cel shading pixel art
	// Plus color_steps est bas, plus l'effet est "BD/manga"
	float cel = floor(n_dot_l * color_steps) / color_steps;
	cel = clamp(cel, 0.0, 1.0);
	
	// 4. Mélange ombre/lumière avec les couleurs définies
	vec3 shaded_color = mix(
		tex_color.rgb * shadow_color.rgb,
		tex_color.rgb * highlight_color.rgb,
		cel
	);
	
	// Atténuation de l'ombre pour ne pas trop noircir
	shaded_color = mix(tex_color.rgb, shaded_color, shadow_intensity + 0.55);
	
	// 5. Rim light — donne la profondeur HD-2D caractéristique
	// (halo bleuté sur les contours, signature visuelle d'Octopath)
	float rim = 1.0 - clamp(dot(NORMAL, VIEW), 0.0, 1.0);
	rim = pow(rim, rim_power);
	shaded_color += rim * rim_color.rgb * rim_intensity;
	
	// 6. Output final
	ALBEDO = shaded_color;
	ALPHA = tex_color.a;
}
