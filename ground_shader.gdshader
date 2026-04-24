// ============================================================
// KAKUSEI 覚醒 — Shader de sol procédural
// Style Pokémon Gamma Emerald
// À appliquer sur le plan de sol dans BernisKawa.gd
// Supporte : herbe, sable, pierre
// ============================================================

shader_type spatial;
render_mode cull_back, depth_draw_opaque, specular_disabled;

// --- Type de sol ---
// 0 = herbe, 1 = sable, 2 = pierre
uniform int soil_type : hint_range(0, 2) = 0;

// --- Paramètres herbe ---
uniform vec4 grass_dark   : source_color = vec4(0.115, 0.210, 0.055, 1.0);
uniform vec4 grass_mid    : source_color = vec4(0.178, 0.318, 0.082, 1.0);
uniform vec4 grass_light  : source_color = vec4(0.238, 0.420, 0.095, 1.0);
uniform vec4 grass_yellow : source_color = vec4(0.310, 0.480, 0.080, 1.0);

// --- Paramètres sable ---
uniform vec4 sand_dark    : source_color = vec4(0.445, 0.355, 0.115, 1.0);
uniform vec4 sand_light   : source_color = vec4(0.548, 0.445, 0.158, 1.0);

// --- Paramètres pierre ---
uniform vec4 stone_dark   : source_color = vec4(0.195, 0.200, 0.210, 1.0);
uniform vec4 stone_light  : source_color = vec4(0.310, 0.318, 0.332, 1.0);
uniform vec4 stone_joint  : source_color = vec4(0.145, 0.148, 0.155, 1.0);

// --- Échelle du bruit (taille des taches) ---
uniform float noise_scale_1 : hint_range(0.1, 5.0) = 0.55;   // Grandes taches
uniform float noise_scale_2 : hint_range(0.1, 10.0) = 1.80;  // Taches moyennes
uniform float noise_scale_3 : hint_range(0.5, 20.0) = 6.50;  // Petits détails

// --- Animation vent (herbe) ---
uniform float wind_speed    : hint_range(0.0, 2.0) = 0.28;
uniform float wind_strength : hint_range(0.0, 1.0) = 0.35;

// ============================================================
// FONCTIONS DE BRUIT
// Bruit de valeur 2D — smooth, organique
// ============================================================

vec2 hash2(vec2 p) {
	p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
	return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

// Perlin noise 2D lisse
float perlin(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	vec2 u = f * f * (3.0 - 2.0 * f);  // Smoothstep

	float a = dot(hash2(i + vec2(0,0)), f - vec2(0,0));
	float b = dot(hash2(i + vec2(1,0)), f - vec2(1,0));
	float c = dot(hash2(i + vec2(0,1)), f - vec2(0,1));
	float d = dot(hash2(i + vec2(1,1)), f - vec2(1,1));

	return mix(mix(a, b, u.x), mix(c, d, u.x), u.y) * 0.5 + 0.5;
}

// FBM (Fractional Brownian Motion) — superposition de bruits
// Donne les grandes taches organiques de Gamma Emerald
float fbm(vec2 p, int octaves) {
	float val   = 0.0;
	float amp   = 0.5;
	float freq  = 1.0;
	float total = 0.0;
	for (int i = 0; i < octaves; i++) {
		val   += perlin(p * freq) * amp;
		total += amp;
		amp   *= 0.50;
		freq  *= 2.05;
	}
	return val / total;
}

// ============================================================
// HERBE style Gamma Emerald
// ============================================================
vec3 grass_color(vec2 uv, float time) {
	// Animation vent légère sur les UV
	vec2 wind_offset = vec2(
		sin(time * wind_speed + uv.y * 3.0) * wind_strength * 0.008,
		cos(time * wind_speed * 0.7 + uv.x * 2.5) * wind_strength * 0.005
	);
	vec2 uv_wind = uv + wind_offset;

	// Couche 1 : grandes taches organiques (blobs Gamma Emerald)
	float n1 = fbm(uv_wind * noise_scale_1, 4);

	// Couche 2 : variation moyenne
	float n2 = fbm(uv_wind * noise_scale_2 + vec2(5.3, 2.7), 3);

	// Couche 3 : petits détails (touches jaune-vert)
	float n3 = perlin(uv_wind * noise_scale_3 + vec2(1.2, 8.4));

	// Quantification douce (3-4 niveaux comme Gamma Emerald)
	// Les grandes taches sont bien délimitées mais avec bords doux
	float base = n1 * 0.65 + n2 * 0.25 + n3 * 0.10;

	// Seuils de couleur (reproduit les taches sombres/claires de Gamma)
	vec3 col;
	if (base < 0.28) {
		col = grass_dark.rgb;
	} else if (base < 0.45) {
		// Transition douce sombre→moyen
		float t = smoothstep(0.28, 0.45, base);
		col = mix(grass_dark.rgb, grass_mid.rgb, t);
	} else if (base < 0.68) {
		col = grass_mid.rgb;
	} else if (base < 0.80) {
		// Transition moyen→clair
		float t = smoothstep(0.68, 0.80, base);
		col = mix(grass_mid.rgb, grass_light.rgb, t);
	} else {
		col = grass_light.rgb;
	}

	// Touches jaune-vert dispersées (brins de Gamma Emerald)
	float spots = smoothstep(0.72, 0.85, n3);
	// Seulement dans les zones claires
	float in_light = smoothstep(0.55, 0.75, base);
	col = mix(col, grass_yellow.rgb, spots * in_light * 0.75);

	return col;
}

// ============================================================
// SABLE style Gamma Emerald
// ============================================================
vec3 sand_color(vec2 uv) {
	// Très légères variations — quasi uniforme comme dans le jeu
	float n1 = fbm(uv * 0.80, 3);
	float n2 = perlin(uv * 3.50 + vec2(4.1, 7.8));

	float base = n1 * 0.70 + n2 * 0.30;

	// Variation très subtile (la référence est quasi plate)
	float t = smoothstep(0.35, 0.65, base);
	vec3 col = mix(sand_dark.rgb, sand_light.rgb, t * 0.6 + 0.2);

	return col;
}

// ============================================================
// PIERRE TAILLÉE (place, fontaine)
// ============================================================
vec3 stone_color(vec2 uv) {
	// Joints réguliers décalés (dallage breton)
	float joint_size = 0.05;
	vec2  tile_uv    = uv * 4.0;  // 4 dalles par unité

	// Décalage alterné une rangée sur deux
	float row   = floor(tile_uv.y);
	float offset = mod(row, 2.0) * 0.5;
	vec2  local = fract(tile_uv + vec2(offset, 0.0));

	// Joint
	bool is_joint = (local.x < joint_size) || (local.y < joint_size);

	float n1 = fbm(uv * 1.20 + vec2(2.3, 5.1), 3);
	float n2 = perlin(uv * 4.50 + vec2(8.7, 1.2));

	vec3 col;
	if (is_joint) {
		col = stone_joint.rgb;
	} else {
		float base = n1 * 0.75 + n2 * 0.25;
		float t    = smoothstep(0.3, 0.7, base);
		col = mix(stone_dark.rgb, stone_light.rgb, t);
	}
	return col;
}

// ============================================================
// FRAGMENT PRINCIPAL
// ============================================================
void fragment() {
	// UV basés sur la position world (pas de répétition visible)
	vec2 world_uv = vec2(VERTEX.x, VERTEX.z);

	vec3 color;
	if (soil_type == 0) {
		color = grass_color(world_uv, TIME);
	} else if (soil_type == 1) {
		color = sand_color(world_uv);
	} else {
		color = stone_color(world_uv);
	}

	ALBEDO   = color;
	ROUGHNESS = 1.0;
	METALLIC  = 0.0;
	// Pas de specular sur le sol
}
