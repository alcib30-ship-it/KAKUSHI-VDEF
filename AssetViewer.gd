extends Node3D

# ============================================================
# KAKUSEI 覚醒 — Asset Viewer v3
# Shader HD-2D style Gamma Emerald / Octopath Traveler
# - Cel shading propre sans trous
# - Outline séparé en next_pass (cull_front)
# - Lumière neutre, pas de jaune
# ============================================================

var camera: Camera3D
var asset_slot: Node3D
var current_asset: Node3D = null

# Deux matériaux séparés
var cel_material: ShaderMaterial = null
var outline_material: ShaderMaterial = null

# UI
var info_label: Label
var rotate_toggle: CheckButton
var scale_slider: HSlider
var camera_slider: HSlider
var outline_toggle: CheckButton

# Caméra orbite
var is_orbiting := false
var orbit_h := 200.0
var orbit_v := -42.0
var orbit_distance := 10.0
var auto_rotate := false

func _ready() -> void:
	_build_shaders()
	_build_scene()
	_build_ui()
	_update_camera()

# ============================================================
# SHADERS
# ============================================================
func _build_shaders() -> void:

	# --- SHADER 1 : CEL SHADING (passe principale) ---
	# Pas d'outline ici, pas de vertex expansion = zéro trou
	var cel_code := """
shader_type spatial;
render_mode cull_back, depth_draw_opaque, specular_disabled;

uniform sampler2D albedo_texture : source_color, hint_default_white;
uniform vec4 albedo_tint : source_color = vec4(1.0, 1.0, 1.0, 1.0);

// Cel shading
uniform float cel_bands : hint_range(2.0, 6.0, 1.0) = 3.0;
uniform float cel_softness : hint_range(0.0, 0.5) = 0.03;

// Couleurs lumière — neutres style Gamma Emerald
uniform vec4 light_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform vec4 shadow_color : source_color = vec4(0.48, 0.52, 0.68, 1.0);
uniform float shadow_strength : hint_range(0.0, 1.0) = 0.55;

// Rim light (halo de profondeur HD-2D)
uniform float rim_power : hint_range(1.0, 8.0) = 4.0;
uniform float rim_strength : hint_range(0.0, 0.8) = 0.15;
uniform vec4 rim_color : source_color = vec4(0.68, 0.82, 1.0, 1.0);

// Ambient occlusion fake (assombrit les creux)
uniform float ao_strength : hint_range(0.0, 1.0) = 0.2;

void fragment() {
	// Texture de base
	vec4 tex = texture(albedo_texture, UV) * albedo_tint;

	// Lumière principale depuis la scène (LIGHT via NORMAL)
	// On utilise la normale en view-space pour simuler l'éclairage
	vec3 n = normalize(NORMAL);
	vec3 view = normalize(VIEW);

	// Direction lumière fixe style Gamma Emerald
	// Soleil en haut-gauche, légèrement devant
	vec3 light_dir = normalize(vec3(0.35, 0.75, 0.55));
	float n_dot_l = dot(n, light_dir);

	// Quantification en bandes nettes (cel shading)
	// smoothstep évite les artefacts aux transitions
	float cel = 0.0;
	float band_size = 1.0 / cel_bands;
	for (int i = 0; i < 6; i++) {
		if (float(i) >= cel_bands) break;
		float threshold = float(i) * band_size;
		cel += smoothstep(threshold - cel_softness, threshold + cel_softness, n_dot_l * 0.5 + 0.5);
	}
	cel = clamp(cel / cel_bands, 0.0, 1.0);

	// Couleur finale = mix ombre/lumière selon cel
	vec3 lit = mix(
		tex.rgb * shadow_color.rgb,
		tex.rgb * light_color.rgb,
		cel
	);
	// Atténuer l'effet pour ne pas écraser les couleurs originales
	lit = mix(tex.rgb, lit, shadow_strength);

	// Rim light — donne la profondeur caractéristique HD-2D
	float rim = 1.0 - clamp(dot(n, view), 0.0, 1.0);
	rim = pow(rim, rim_power);
	lit += rim * rim_color.rgb * rim_strength;

	// AO fake : les faces qui regardent vers le bas sont plus sombres
	float ao = clamp(dot(n, vec3(0.0, 1.0, 0.0)) * 0.5 + 0.5, 0.0, 1.0);
	lit = mix(lit * 0.7, lit, ao * (1.0 - ao_strength) + ao_strength);

	ALBEDO = lit;
	ALPHA = tex.a;
}
"""

	# --- SHADER 2 : OUTLINE (next_pass séparé) ---
	# cull_front = on rend seulement les faces arrière, agrandies
	# Résultat : contour propre, ZÉRO trou dans le mesh
	var outline_code := """
shader_type spatial;
render_mode cull_front, depth_draw_opaque, unshaded, shadows_disabled;

uniform float outline_size : hint_range(0.0, 0.05) = 0.008;
uniform vec4 outline_color : source_color = vec4(0.06, 0.04, 0.08, 1.0);

void vertex() {
	// Expansion dans la direction des normales (world space)
	vec4 clip_pos = PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(VERTEX, 1.0);
	vec3 clip_normal = normalize((PROJECTION_MATRIX * MODELVIEW_MATRIX * vec4(NORMAL, 0.0)).xyz);
	
	// Expansion en clip space pour outline constant quelle que soit la distance
	float aspect = VIEWPORT_SIZE.x / VIEWPORT_SIZE.y;
	clip_normal.x /= aspect;
	
	clip_pos.xy += clip_normal.xy * outline_size * clip_pos.w;
	POSITION = clip_pos;
}

void fragment() {
	ALBEDO = outline_color.rgb;
	ALPHA = outline_color.a;
}
"""

	# Créer les deux ShaderMaterial
	var cel_shader := Shader.new()
	cel_shader.code = cel_code
	cel_material = ShaderMaterial.new()
	cel_material.shader = cel_shader

	var outline_shader := Shader.new()
	outline_shader.code = outline_code
	outline_material = ShaderMaterial.new()
	outline_material.shader = outline_shader

	# Chaîner l'outline en next_pass du cel
	cel_material.next_pass = outline_material

# ============================================================
# SCÈNE 3D
# ============================================================
func _build_scene() -> void:
	camera = Camera3D.new()
	camera.projection = Camera3D.PROJECTION_ORTHOGONAL
	camera.size = 10.0
	camera.near = 0.1
	camera.far = 200.0
	add_child(camera)

	asset_slot = Node3D.new()
	asset_slot.name = "AssetSlot"
	add_child(asset_slot)

	# Lumière principale — neutre/légèrement chaude
	var sun := DirectionalLight3D.new()
	sun.light_color = Color(1.0, 0.98, 0.94)
	sun.light_energy = 1.4
	sun.shadow_enabled = true
	sun.rotation_degrees = Vector3(-52, -28, 0)
	add_child(sun)

	# Fill light froide pour la profondeur
	var fill := DirectionalLight3D.new()
	fill.light_color = Color(0.58, 0.72, 1.0)
	fill.light_energy = 0.3
	fill.shadow_enabled = false
	fill.rotation_degrees = Vector3(-20, 148, 0)
	add_child(fill)

	# Environnement — fond vert style Gamma Emerald
	var env_node := WorldEnvironment.new()
	var env := Environment.new()
	env.background_mode = Environment.BG_COLOR
	env.background_color = Color(0.42, 0.62, 0.52)
	env.ambient_light_source = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color = Color(0.72, 0.80, 0.98)
	env.ambient_light_energy = 0.45
	env.tonemap_mode = Environment.TONE_MAPPER_FILMIC
	env.glow_enabled = true
	env.glow_intensity = 0.18
	env.glow_bloom = 0.05
	env_node.environment = env
	add_child(env_node)

	# Sol
	var plane := PlaneMesh.new()
	plane.size = Vector2(30, 30)
	var floor_mi := MeshInstance3D.new()
	floor_mi.mesh = plane
	var floor_mat := StandardMaterial3D.new()
	floor_mat.albedo_color = Color(0.34, 0.54, 0.40)
	floor_mat.roughness = 1.0
	floor_mi.material_override = floor_mat
	add_child(floor_mi)

	# Grille
	var im := ImmediateMesh.new()
	var grid_mi := MeshInstance3D.new()
	grid_mi.mesh = im
	var gmat := StandardMaterial3D.new()
	gmat.albedo_color = Color(0.26, 0.44, 0.31)
	gmat.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	grid_mi.material_override = gmat
	add_child(grid_mi)
	im.clear_surfaces()
	im.surface_begin(Mesh.PRIMITIVE_LINES)
	for i in range(-10, 11):
		im.surface_add_vertex(Vector3(i, 0.01, -10))
		im.surface_add_vertex(Vector3(i, 0.01, 10))
		im.surface_add_vertex(Vector3(-10, 0.01, i))
		im.surface_add_vertex(Vector3(10, 0.01, i))
	im.surface_end()

# ============================================================
# UI
# ============================================================
func _build_ui() -> void:
	var canvas := CanvasLayer.new()
	add_child(canvas)

	var panel := PanelContainer.new()
	panel.set_anchors_preset(Control.PRESET_LEFT_WIDE)
	panel.custom_minimum_size = Vector2(275, 0)
	panel.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	canvas.add_child(panel)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 8)
	panel.add_child(vbox)

	_sp(vbox, 10)
	_lbl(vbox, "KAKUSEI — Asset Viewer", 15, Color(1.0, 0.95, 0.5))
	_lbl(vbox, "Shader : Gamma Emerald HD-2D v3", 10, Color(0.6, 0.9, 0.7))
	vbox.add_child(HSeparator.new())

	var btn_load := Button.new()
	btn_load.text = "📂  Charger un asset (.glb)"
	btn_load.pressed.connect(_on_load_pressed)
	vbox.add_child(btn_load)

	var btn_apply := Button.new()
	btn_apply.text = "✨  Réappliquer Shader"
	btn_apply.pressed.connect(_force_shader)
	vbox.add_child(btn_apply)

	var btn_remove := Button.new()
	btn_remove.text = "🔲  Voir sans Shader"
	btn_remove.pressed.connect(_remove_shader_all)
	vbox.add_child(btn_remove)

	vbox.add_child(HSeparator.new())

	info_label = Label.new()
	info_label.text = "Charge un .glb pour commencer."
	info_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info_label.add_theme_font_size_override("font_size", 11)
	info_label.modulate = Color(0.85, 0.95, 0.85)
	vbox.add_child(info_label)

	vbox.add_child(HSeparator.new())

	# Toggle outline
	outline_toggle = CheckButton.new()
	outline_toggle.text = "Outline (contour noir)"
	outline_toggle.button_pressed = true
	outline_toggle.toggled.connect(_on_outline_toggled)
	vbox.add_child(outline_toggle)

	# Toggle rotation
	rotate_toggle = CheckButton.new()
	rotate_toggle.text = "Rotation auto"
	rotate_toggle.button_pressed = false
	rotate_toggle.toggled.connect(func(v): auto_rotate = v)
	vbox.add_child(rotate_toggle)

	vbox.add_child(HSeparator.new())

	_lbl(vbox, "Échelle :", 11, Color(0.8, 0.8, 0.8))
	scale_slider = HSlider.new()
	scale_slider.min_value = 0.1
	scale_slider.max_value = 5.0
	scale_slider.step = 0.05
	scale_slider.value = 1.0
	scale_slider.value_changed.connect(func(v):
		if current_asset: current_asset.scale = Vector3(v, v, v))
	vbox.add_child(scale_slider)

	_lbl(vbox, "Zoom :", 11, Color(0.8, 0.8, 0.8))
	camera_slider = HSlider.new()
	camera_slider.min_value = 3.0
	camera_slider.max_value = 25.0
	camera_slider.step = 0.5
	camera_slider.value = orbit_distance
	camera_slider.value_changed.connect(func(v):
		orbit_distance = v; _update_camera())
	vbox.add_child(camera_slider)

	vbox.add_child(HSeparator.new())
	_lbl(vbox, "Clic droit + glisser : orbiter\nMolette : zoom\nR : reset vue", 10, Color(0.55, 0.55, 0.55))

func _lbl(p: Control, t: String, s: int, c: Color = Color.WHITE) -> void:
	var l := Label.new()
	l.text = t
	l.add_theme_font_size_override("font_size", s)
	l.modulate = c
	l.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	p.add_child(l)

func _sp(p: Control, h: int) -> void:
	var s := Control.new()
	s.custom_minimum_size = Vector2(0, h)
	p.add_child(s)

# ============================================================
# CAMÉRA
# ============================================================
func _process(delta: float) -> void:
	if auto_rotate and current_asset:
		orbit_h += 24.0 * delta
		_update_camera()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			is_orbiting = event.pressed
		elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
			orbit_distance = max(3.0, orbit_distance - 0.6)
			camera_slider.value = orbit_distance
			_update_camera()
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			orbit_distance = min(25.0, orbit_distance + 0.6)
			camera_slider.value = orbit_distance
			_update_camera()
	if event is InputEventMouseMotion and is_orbiting:
		orbit_h += event.relative.x * 0.5
		orbit_v = clamp(orbit_v - event.relative.y * 0.3, -80.0, -8.0)
		_update_camera()
	if event is InputEventKey and event.pressed and event.keycode == KEY_R:
		_reset_view()

func _update_camera() -> void:
	var h := deg_to_rad(orbit_h)
	var v := deg_to_rad(orbit_v)
	camera.position = Vector3(
		orbit_distance * cos(v) * sin(h),
		orbit_distance * sin(-v),
		orbit_distance * cos(v) * cos(h)
	)
	camera.look_at(Vector3(0, 1.0, 0), Vector3.UP)
	camera.size = orbit_distance

func _reset_view() -> void:
	orbit_h = 200.0
	orbit_v = -42.0
	orbit_distance = 10.0
	camera_slider.value = 10.0
	if current_asset:
		current_asset.scale = Vector3.ONE
		scale_slider.value = 1.0
	_update_camera()

# ============================================================
# CHARGEMENT
# ============================================================
func _on_load_pressed() -> void:
	var dialog := FileDialog.new()
	dialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dialog.access = FileDialog.ACCESS_FILESYSTEM
	dialog.filters = PackedStringArray(["*.glb ; GLB", "*.gltf ; GLTF"])
	dialog.title = "Charger un asset KAKUSEI"
	dialog.min_size = Vector2i(900, 600)
	add_child(dialog)
	dialog.popup_centered()
	dialog.file_selected.connect(_load_asset)
	dialog.canceled.connect(dialog.queue_free)

func _load_asset(path: String) -> void:
	for child in asset_slot.get_children():
		child.queue_free()
	current_asset = null

	var gltf := GLTFDocument.new()
	var state := GLTFState.new()
	if gltf.append_from_file(path, state) != OK:
		info_label.text = "❌ Erreur chargement :\n" + path
		return

	var scene := gltf.generate_scene(state)
	if scene == null:
		info_label.text = "❌ Scene nulle :\n" + path
		return

	asset_slot.add_child(scene)
	current_asset = scene
	_center_asset(scene)

	await get_tree().process_frame
	_force_shader()

	info_label.text = "✅ %s\n%d mesh(es)\n\nShader HD-2D appliqué ✓\nOutline : %s\n\nR = reset vue" % [
		path.get_file(),
		_count_meshes(scene),
		"Actif" if outline_toggle.button_pressed else "Inactif"
	]

# ============================================================
# APPLICATION SHADER
# ============================================================
func _force_shader() -> void:
	if current_asset == null:
		info_label.text = "Charge un asset d'abord."
		return
	_apply_cel_recursive(current_asset)

func _remove_shader_all() -> void:
	if current_asset == null:
		return
	_remove_recursive(current_asset)
	info_label.text = info_label.text + "\n[Sans shader]"

func _apply_cel_recursive(node: Node) -> void:
	if node is MeshInstance3D:
		var mi := node as MeshInstance3D
		if mi.mesh == null:
			return
		var n_surfaces := mi.mesh.get_surface_count()
		for i in range(n_surfaces):
			var mat := cel_material.duplicate(true) as ShaderMaterial
			# Récupérer la texture albedo du matériau original
			var original: Material = mi.mesh.surface_get_material(i)
			if original == null:
				original = mi.get_surface_override_material(i)
			_inject_texture(mat, original)
			# Appliquer outline en next_pass si activé
			if outline_toggle.button_pressed:
				mat.next_pass = outline_material.duplicate()
			else:
				mat.next_pass = null
			mi.set_surface_override_material(i, mat)
	for child in node.get_children():
		_apply_cel_recursive(child)

func _inject_texture(mat: ShaderMaterial, original: Material) -> void:
	if original == null:
		return
	if original is BaseMaterial3D:
		var bm := original as BaseMaterial3D
		if bm.albedo_texture:
			mat.set_shader_parameter("albedo_texture", bm.albedo_texture)
		# Tint depuis la couleur albedo originale
		mat.set_shader_parameter("albedo_tint", bm.albedo_color)
	elif original is ShaderMaterial:
		var sm := original as ShaderMaterial
		var t = sm.get_shader_parameter("albedo_texture")
		if t:
			mat.set_shader_parameter("albedo_texture", t)

func _remove_recursive(node: Node) -> void:
	if node is MeshInstance3D:
		var mi := node as MeshInstance3D
		if mi.mesh:
			for i in range(mi.mesh.get_surface_count()):
				mi.set_surface_override_material(i, null)
	for child in node.get_children():
		_remove_recursive(child)

func _on_outline_toggled(active: bool) -> void:
	if current_asset == null:
		return
	# Mettre à jour le next_pass sur tous les matériaux actifs
	_update_outline_recursive(current_asset, active)

func _update_outline_recursive(node: Node, active: bool) -> void:
	if node is MeshInstance3D:
		var mi := node as MeshInstance3D
		if mi.mesh:
			for i in range(mi.mesh.get_surface_count()):
				var mat := mi.get_surface_override_material(i)
				if mat is ShaderMaterial:
					(mat as ShaderMaterial).next_pass = outline_material.duplicate() if active else null
	for child in node.get_children():
		_update_outline_recursive(child, active)

# ============================================================
# UTILITAIRES
# ============================================================
func _center_asset(node: Node3D) -> void:
	var aabb := _get_aabb(node)
	if aabb.size.length() < 0.001:
		return
	var off := -aabb.get_center()
	off.y = -aabb.position.y
	node.position = off

func _get_aabb(node: Node) -> AABB:
	var r := AABB()
	var first := true
	if node is MeshInstance3D:
		var mi := node as MeshInstance3D
		if mi.mesh:
			var a := mi.global_transform * mi.get_aabb()
			r = a
			first = false
	for child in node.get_children():
		var sub := _get_aabb(child)
		if sub.size.length() > 0.001:
			r = sub if first else r.merge(sub)
			first = false
	return r

func _count_meshes(node: Node) -> int:
	var c := 1 if node is MeshInstance3D else 0
	for child in node.get_children():
		c += _count_meshes(child)
	return c
