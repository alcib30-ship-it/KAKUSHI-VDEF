extends Node3D

# ============================================================
# KAKUSEI 覚醒 — Bernis-Kawa
# Scène principale Chapitre 1
# Attache sur un Node3D vide, lance F5
# ============================================================

# --- Nodes ---
var player:       CharacterBody3D
var cam_target:   Node3D          # Point que suit la caméra
var camera:       Camera3D
var info_label:   Label
var panel_ui:     PanelContainer

# --- Caméra (style Gamma Emerald, jamais modifiable par le joueur) ---
const CAM_H_DEG   := 225.0   # Angle horizontal fixe (sud-ouest)
const CAM_V_DEG   := -46.0   # Inclinaison verticale
const CAM_DIST    := 15.0    # Distance orthographique
const CAM_SIZE    := 10.5    # Taille ortho (zoom)
const CAM_LERP    := 10.0    # Fluidité du suivi

# --- Mouvement joueur ---
const WALK_SPEED  := 5.0
const SPRINT_MULT := 1.8
const GRAVITY     := 24.0

# --- État UI ---
var ui_visible    := true
var last_asset_path := ""
var placed_nodes: Array[Node3D] = []

# ============================================================
# INIT
# ============================================================
func _ready() -> void:
	_setup_environment()
	_setup_ground()
	_setup_player()
	_setup_camera()
	_setup_ui()
	_update_camera(true)

# ============================================================
# ENVIRONNEMENT & LUMIÈRES
# ============================================================
func _setup_environment() -> void:
	# Lumière soleil principale (chaude, angle Gamma Emerald)
	var sun := DirectionalLight3D.new()
	sun.name                  = "Sun"
	sun.light_color           = Color(1.00, 0.97, 0.92)
	sun.light_energy          = 1.65
	sun.shadow_enabled        = true
	sun.shadow_bias           = 0.015
	sun.directional_shadow_mode = DirectionalLight3D.SHADOW_ORTHOGONAL
	sun.rotation_degrees      = Vector3(-52, -30, 0)
	add_child(sun)

	# Fill light froide (donne profondeur HD-2D)
	var fill := DirectionalLight3D.new()
	fill.name              = "FillLight"
	fill.light_color       = Color(0.55, 0.70, 1.00)
	fill.light_energy      = 0.32
	fill.shadow_enabled    = false
	fill.rotation_degrees  = Vector3(-18, 150, 0)
	add_child(fill)

	# WorldEnvironment
	var we  := WorldEnvironment.new()
	var env := Environment.new()

	# Fond ciel bleu côtier (Bernis-Kawa = village portuaire)
	env.background_mode      = Environment.BG_COLOR
	env.background_color     = Color(0.52, 0.74, 0.92)

	# Lumière ambiante froide douce
	env.ambient_light_source  = Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color   = Color(0.70, 0.78, 0.98)
	env.ambient_light_energy  = 0.48

	# Tone mapping Filmic (évite la surexposition)
	env.tonemap_mode     = Environment.TONE_MAPPER_FILMIC
	env.tonemap_exposure = 1.05

	# Glow très discret (signature HD-2D)
	env.glow_enabled     = true
	env.glow_normalized  = false
	env.glow_intensity   = 0.18
	env.glow_bloom       = 0.05
	env.glow_blend_mode  = Environment.GLOW_BLEND_MODE_SOFTLIGHT

	# Brouillard léger (profondeur, donne l'impression d'horizon)
	env.fog_enabled         = true
	env.fog_light_color     = Color(0.78, 0.88, 1.00)
	env.fog_light_energy    = 0.28
	env.fog_density         = 0.004
	env.fog_aerial_perspective = 0.15

	we.environment = env
	add_child(we)

# ============================================================
# SOL
# ============================================================
func _setup_ground() -> void:
	var plane := PlaneMesh.new()
	plane.size = Vector2(80, 80)

	var mi := MeshInstance3D.new()
	mi.name = "Ground"
	mi.mesh = plane

	var img := Image.load_from_file("C:/Users/alcib/OneDrive/Dokumente/0_Projet KAKUSEI/kakusei/assets/grass_texture.png")
	var tex := ImageTexture.create_from_image(img)
	var mat := StandardMaterial3D.new()
	mat.albedo_texture = tex
	mat.uv1_scale = Vector3(6, 6, 1)
	mat.roughness = 1.0
	mat.metallic = 0.0
	mi.material_override = mat
	add_child(mi)

	var sb := StaticBody3D.new()
	var col := CollisionShape3D.new()
	var box := BoxShape3D.new()
	box.size = Vector3(80, 0.1, 80)
	col.shape = box
	col.position.y = -0.05
	sb.add_child(col)
	add_child(sb)

func _ground_shader_code() -> String:
	return """
shader_type spatial;
render_mode cull_back, depth_draw_opaque, specular_disabled;

uniform int   soil_type       : hint_range(0, 2) = 0;

uniform vec4  grass_dark      : source_color = vec4(0.115, 0.210, 0.055, 1.0);
uniform vec4  grass_mid       : source_color = vec4(0.178, 0.318, 0.082, 1.0);
uniform vec4  grass_light     : source_color = vec4(0.238, 0.420, 0.095, 1.0);
uniform vec4  grass_yellow    : source_color = vec4(0.310, 0.480, 0.080, 1.0);

uniform vec4  sand_dark       : source_color = vec4(0.445, 0.355, 0.115, 1.0);
uniform vec4  sand_light      : source_color = vec4(0.548, 0.445, 0.158, 1.0);

uniform vec4  stone_dark      : source_color = vec4(0.195, 0.200, 0.210, 1.0);
uniform vec4  stone_light     : source_color = vec4(0.310, 0.318, 0.332, 1.0);
uniform vec4  stone_joint     : source_color = vec4(0.145, 0.148, 0.155, 1.0);

uniform float noise_scale_1   : hint_range(0.1, 5.0)  = 0.55;
uniform float noise_scale_2   : hint_range(0.1, 10.0) = 1.80;
uniform float noise_scale_3   : hint_range(0.5, 20.0) = 6.50;
uniform float wind_speed      : hint_range(0.0, 2.0)  = 0.28;
uniform float wind_strength   : hint_range(0.0, 1.0)  = 0.35;

vec2 hash2(vec2 p) {
	p = vec2(dot(p, vec2(127.1, 311.7)), dot(p, vec2(269.5, 183.3)));
	return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

float perlin(vec2 p) {
	vec2 i = floor(p);
	vec2 f = fract(p);
	vec2 u = f * f * (3.0 - 2.0 * f);
	float a = dot(hash2(i + vec2(0,0)), f - vec2(0,0));
	float b = dot(hash2(i + vec2(1,0)), f - vec2(1,0));
	float c = dot(hash2(i + vec2(0,1)), f - vec2(0,1));
	float d = dot(hash2(i + vec2(1,1)), f - vec2(1,1));
	return mix(mix(a, b, u.x), mix(c, d, u.x), u.y) * 0.5 + 0.5;
}

float fbm(vec2 p, int octaves) {
	float val = 0.0; float amp = 0.5;
	float freq = 1.0; float total = 0.0;
	for (int i = 0; i < 4; i++) {
		if (i >= octaves) break;
		val   += perlin(p * freq) * amp;
		total += amp; amp *= 0.5; freq *= 2.05;
	}
	return val / total;
}

vec3 grass_color(vec2 uv, float time) {
	vec2 wo = vec2(
		sin(time * wind_speed + uv.y * 3.0) * wind_strength * 0.008,
		cos(time * wind_speed * 0.7 + uv.x * 2.5) * wind_strength * 0.005
	);
	vec2 w = uv + wo;
	float n1 = fbm(w * noise_scale_1, 4);
	float n2 = fbm(w * noise_scale_2 + vec2(5.3, 2.7), 3);
	float n3 = perlin(w * noise_scale_3 + vec2(1.2, 8.4));
	float base = n1 * 0.65 + n2 * 0.25 + n3 * 0.10;
	vec3 col;
	if (base < 0.28) {
		col = grass_dark.rgb;
	} else if (base < 0.45) {
		col = mix(grass_dark.rgb, grass_mid.rgb, smoothstep(0.28, 0.45, base));
	} else if (base < 0.68) {
		col = grass_mid.rgb;
	} else if (base < 0.80) {
		col = mix(grass_mid.rgb, grass_light.rgb, smoothstep(0.68, 0.80, base));
	} else {
		col = grass_light.rgb;
	}
	float spots    = smoothstep(0.72, 0.85, n3);
	float in_light = smoothstep(0.55, 0.75, base);
	col = mix(col, grass_yellow.rgb, spots * in_light * 0.75);
	return col;
}

vec3 sand_color(vec2 uv) {
	float n1  = fbm(uv * 0.80, 3);
	float n2  = perlin(uv * 3.50 + vec2(4.1, 7.8));
	float base = n1 * 0.70 + n2 * 0.30;
	float t   = smoothstep(0.35, 0.65, base);
	return mix(sand_dark.rgb, sand_light.rgb, t * 0.6 + 0.2);
}

vec3 stone_color(vec2 uv) {
	float js   = 0.05;
	vec2  tu   = uv * 4.0;
	float row  = floor(tu.y);
	float off  = mod(row, 2.0) * 0.5;
	vec2  loc  = fract(tu + vec2(off, 0.0));
	bool  joint = (loc.x < js) || (loc.y < js);
	float n1   = fbm(uv * 1.20 + vec2(2.3, 5.1), 3);
	float n2   = perlin(uv * 4.50 + vec2(8.7, 1.2));
	if (joint) return stone_joint.rgb;
	float t = smoothstep(0.3, 0.7, n1 * 0.75 + n2 * 0.25);
	return mix(stone_dark.rgb, stone_light.rgb, t);
}

void fragment() {
	vec2 uv = vec2(VERTEX.x, VERTEX.z);
	vec3 color;
	if      (soil_type == 0) color = grass_color(uv, TIME);
	else if (soil_type == 1) color = sand_color(uv);
	else                      color = stone_color(uv);
	ALBEDO    = color;
	ROUGHNESS = 1.0;
	METALLIC  = 0.0;
}
"""

# ============================================================
# JOUEUR
# ============================================================
func _setup_player() -> void:
	player      = CharacterBody3D.new()
	player.name = "Player"
	add_child(player)
	player.position = Vector3(0, 0.8, 0)

	# Collision capsule
	var col_shape := CollisionShape3D.new()
	var cap       := CapsuleShape3D.new()
	cap.radius    = 0.28
	cap.height    = 1.50
	col_shape.shape    = cap
	col_shape.position = Vector3(0, 0, 0)
	player.add_child(col_shape)

	# Corps (capsule bleue)
	var body_mi   := MeshInstance3D.new()
	var body_mesh := CapsuleMesh.new()
	body_mesh.radius = 0.26
	body_mesh.height = 1.45
	body_mi.mesh     = body_mesh
	var body_mat     := StandardMaterial3D.new()
	body_mat.albedo_color = Color(0.22, 0.42, 0.82)
	body_mat.roughness    = 0.75
	body_mi.material_override = body_mat
	player.add_child(body_mi)

	# Tête
	var head_mi   := MeshInstance3D.new()
	var head_mesh := SphereMesh.new()
	head_mesh.radius = 0.20
	head_mesh.height = 0.40
	head_mi.mesh     = head_mesh
	head_mi.position = Vector3(0, 0.95, 0)
	var head_mat     := StandardMaterial3D.new()
	head_mat.albedo_color = Color(0.92, 0.76, 0.60)
	head_mat.roughness    = 0.85
	head_mi.material_override = head_mat
	player.add_child(head_mi)

	# Script de mouvement
	var mv := GDScript.new()
	mv.source_code = """
extends CharacterBody3D

const WALK   = 5.0
const SPRINT = 9.0
const GRAV   = 24.0

func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= GRAV * delta
	else:
		velocity.y = -0.5

	var spd = SPRINT if (Input.is_key_pressed(KEY_SHIFT) or Input.is_key_pressed(KEY_CTRL)) else WALK
	var dir = Vector3.ZERO

	if Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_Z) or Input.is_action_pressed("ui_up"):
		dir.z -= 1
	if Input.is_key_pressed(KEY_S) or Input.is_action_pressed("ui_down"):
		dir.z += 1
	if Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_Q) or Input.is_action_pressed("ui_left"):
		dir.x -= 1
	if Input.is_key_pressed(KEY_D) or Input.is_action_pressed("ui_right"):
		dir.x += 1

	if dir.length() > 0.01:
		dir = dir.normalized()
		velocity.x = dir.x * spd
		velocity.z = dir.z * spd
	else:
		velocity.x = move_toward(velocity.x, 0, spd * 10 * delta)
		velocity.z = move_toward(velocity.z, 0, spd * 10 * delta)

	move_and_slide()
"""
	mv.reload()
	player.set_script(mv)

# ============================================================
# CAMÉRA
# ============================================================
func _setup_camera() -> void:
	# cam_target = nœud fantôme qui suit le joueur en lerp
	# La caméra est enfant de cam_target → suit sans jitter
	cam_target          = Node3D.new()
	cam_target.name     = "CamTarget"
	add_child(cam_target)
	cam_target.position = player.position

	camera              = Camera3D.new()
	camera.name         = "Camera"
	camera.projection   = Camera3D.PROJECTION_ORTHOGONAL
	camera.size         = CAM_SIZE
	camera.near         = 0.5
	camera.far          = 200.0
	cam_target.add_child(camera)

func _update_camera(instant: bool = false) -> void:
	if not is_instance_valid(player) or not is_instance_valid(cam_target):
		return

	# Lerp de cam_target vers le joueur
	var target_pos := player.global_position
	if instant:
		cam_target.global_position = target_pos
	else:
		cam_target.global_position = cam_target.global_position.lerp(
			target_pos,
			CAM_LERP * get_process_delta_time()
		)

	# Position caméra en coordonnées sphériques autour de cam_target
	var h := deg_to_rad(CAM_H_DEG)
	var v := deg_to_rad(CAM_V_DEG)
	camera.position = Vector3(
		CAM_DIST * cos(v) * sin(h),
		CAM_DIST * sin(-v),
		CAM_DIST * cos(v) * cos(h)
	)
	# Regarder légèrement au-dessus du sol (0.7) pour centrer le perso
	camera.look_at(cam_target.global_position + Vector3(0, 0.7, 0), Vector3.UP)

func _process(_delta: float) -> void:
	_update_camera()

# ============================================================
# UI
# ============================================================
func _setup_ui() -> void:
	var canvas := CanvasLayer.new()
	canvas.name = "UI"
	add_child(canvas)

	# Panel principal (coin supérieur gauche)
	panel_ui = PanelContainer.new()
	panel_ui.name = "Panel"
	panel_ui.set_anchors_preset(Control.PRESET_TOP_LEFT)
	panel_ui.custom_minimum_size = Vector2(255, 0)
	panel_ui.size_flags_horizontal = Control.SIZE_SHRINK_BEGIN
	canvas.add_child(panel_ui)

	var vbox := VBoxContainer.new()
	vbox.add_theme_constant_override("separation", 6)
	panel_ui.add_child(vbox)

	_sp(vbox, 8)
	_lbl(vbox, "KAKUSEI 覚醒", 16, Color(1.00, 0.95, 0.45))
	_lbl(vbox, "Bernis-Kawa  —  Chapitre 1", 10, Color(0.65, 0.90, 0.72))
	vbox.add_child(HSeparator.new())

	# Bouton charger asset
	var btn_load := Button.new()
	btn_load.text = "📂  Charger un asset (.glb)"
	btn_load.pressed.connect(_on_load_pressed)
	vbox.add_child(btn_load)

	# Bouton masquer le dernier asset placé
	var btn_hide := Button.new()
	btn_hide.name = "BtnHide"
	btn_hide.text = "👁  Masquer dernier asset"
	btn_hide.pressed.connect(_toggle_last_asset)
	vbox.add_child(btn_hide)

	# Bouton supprimer le dernier asset
	var btn_del := Button.new()
	btn_del.text = "🗑  Supprimer dernier asset"
	btn_del.pressed.connect(_delete_last_asset)
	vbox.add_child(btn_del)

	# Bouton tout effacer
	var btn_clear := Button.new()
	btn_clear.text = "💥  Tout effacer"
	btn_clear.pressed.connect(_clear_all)
	vbox.add_child(btn_clear)

	vbox.add_child(HSeparator.new())

	# Label info
	info_label = Label.new()
	info_label.name = "Info"
	info_label.text = "Charge un .glb puis\nclique sur le sol pour placer."
	info_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	info_label.add_theme_font_size_override("font_size", 11)
	info_label.modulate = Color(0.82, 0.94, 0.82)
	vbox.add_child(info_label)

	vbox.add_child(HSeparator.new())
	_lbl(vbox, "ZQSD / Flèches : bouger\nShift : sprint\nH : afficher/masquer UI\nClick gauche : placer asset", 10, Color(0.58, 0.58, 0.58))

# ============================================================
# LOGIQUE ASSETS
# ============================================================
var ghost: Node3D = null

func _on_load_pressed() -> void:
	var dlg := FileDialog.new()
	dlg.file_mode = FileDialog.FILE_MODE_OPEN_FILE
	dlg.access    = FileDialog.ACCESS_FILESYSTEM
	dlg.filters   = PackedStringArray(["*.glb ; GLB", "*.gltf ; GLTF"])
	dlg.title     = "KAKUSEI — Charger un asset"
	dlg.min_size  = Vector2i(960, 640)
	add_child(dlg)
	dlg.popup_centered()
	dlg.file_selected.connect(_on_file_selected)
	dlg.canceled.connect(dlg.queue_free)

func _on_file_selected(path: String) -> void:
	last_asset_path = path
	if ghost and is_instance_valid(ghost):
		ghost.queue_free()
	ghost = _load_glb(path)
	if ghost:
		add_child(ghost)
		_set_alpha(ghost, 0.40)
	info_label.text = "Asset : %s\n\nClick gauche sur le sol\npour placer.\n\nH = toggle UI" % path.get_file()

func _input(event: InputEvent) -> void:
	# Placement au click gauche
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT and last_asset_path != "":
			_place_at_cursor(event.position)

	# Déplacer le ghost sous le curseur
	if event is InputEventMouseMotion and ghost and is_instance_valid(ghost):
		var hit := _raycast_ground(event.position)
		if hit != Vector3.INF:
			ghost.position = Vector3(hit.x, 0.0, hit.z)

	# H = toggle UI
	if event is InputEventKey and event.pressed and event.keycode == KEY_H:
		panel_ui.visible = not panel_ui.visible

func _place_at_cursor(screen_pos: Vector2) -> void:
	var hit := _raycast_ground(screen_pos)
	if hit == Vector3.INF:
		return
	var inst := _load_glb(last_asset_path)
	if inst == null:
		return
	inst.position = Vector3(hit.x, 0.0, hit.z)
	add_child(inst)
	placed_nodes.append(inst)
	info_label.text = "%d asset(s) placé(s)\n\nDernier : %s\n\nH = toggle UI" % [
		placed_nodes.size(), last_asset_path.get_file()
	]

func _raycast_ground(screen_pos: Vector2) -> Vector3:
	var space  := get_world_3d().direct_space_state
	var origin := camera.project_ray_origin(screen_pos)
	var dir    := camera.project_ray_normal(screen_pos)
	var end    := origin + dir * 300.0
	var query  := PhysicsRayQueryParameters3D.create(origin, end)
	query.exclude = [player]
	var result := space.intersect_ray(query)
	if result.is_empty():
		return Vector3.INF
	return result["position"]

func _toggle_last_asset() -> void:
	if placed_nodes.is_empty():
		return
	var last: Node3D = placed_nodes.back()
	if is_instance_valid(last):
		last.visible = not last.visible
		var btn := panel_ui.find_child("BtnHide", true, false) as Button
		if btn:
			btn.text = "👁  Afficher dernier asset" if not last.visible else "👁  Masquer dernier asset"

func _delete_last_asset() -> void:
	if placed_nodes.is_empty():
		return
	var last: Node3D = placed_nodes.pop_back()
	if is_instance_valid(last):
		last.queue_free()
	info_label.text = "%d asset(s) restant(s)" % placed_nodes.size()

func _clear_all() -> void:
	for n in placed_nodes:
		if is_instance_valid(n):
			n.queue_free()
	placed_nodes.clear()
	if ghost and is_instance_valid(ghost):
		ghost.queue_free()
		ghost = null
	last_asset_path = ""
	info_label.text = "Scène vidée.\nCharge un .glb pour recommencer."

# ============================================================
# UTILITAIRES
# ============================================================
func _load_glb(path: String) -> Node3D:
	var gltf  := GLTFDocument.new()
	var state := GLTFState.new()
	if gltf.append_from_file(path, state) != OK:
		info_label.text = "❌ Erreur : " + path.get_file()
		return null
	return gltf.generate_scene(state)

func _set_alpha(node: Node, alpha: float) -> void:
	if node is MeshInstance3D:
		var mat := StandardMaterial3D.new()
		mat.albedo_color   = Color(0.55, 0.82, 1.0, alpha)
		mat.transparency   = BaseMaterial3D.TRANSPARENCY_ALPHA
		mat.shading_mode   = BaseMaterial3D.SHADING_MODE_UNSHADED
		(node as MeshInstance3D).material_override = mat
	for c in node.get_children():
		_set_alpha(c, alpha)

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
