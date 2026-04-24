extends Node3D

# ==============================================================================
# BernisKawa3D.gd
# Scène R&D 3D autonome — map Bernis-Kawa 120×120
# Tout généré en code — lancer avec F6
# Contrôles : flèches = marcher | Shift = sprinter
# ==============================================================================

var _player		: CharacterBody3D
var _camera_arm	: Node3D
var _camera		: Camera3D

const PLAYER_SPEED	:= 6.0
const PLAYER_SPRINT	:= 11.0
const GRAVITY		:= 20.0

const CAM_DISTANCE	:= 18.0
const CAM_ANGLE_V	:= -46.0
const CAM_ANGLE_H	:= 225.0
const CAM_SMOOTH	:= 8.0

const MAP_HALF		:= 58.0

# ==============================================================================
func _ready() -> void:
	_build_environment()
	_build_player()
	_build_camera()
	_place_assets()

# ==============================================================================
# ENVIRONNEMENT
# ==============================================================================
func _build_environment() -> void:
	# ── Sol ───────────────────────────────────────────────────────────────────
	var ground_body			:= StaticBody3D.new()
	ground_body.name		= "GroundBody"

	var ground				:= MeshInstance3D.new()
	ground.name				= "Ground"
	var ground_mesh			:= PlaneMesh.new()
	ground_mesh.size		= Vector2(120.0, 120.0)
	ground.mesh				= ground_mesh

	var ground_mat					:= StandardMaterial3D.new()
	var grass_tex					:= load("res://grass_texture.png.png")
	if grass_tex:
		ground_mat.albedo_texture	= grass_tex
		ground_mat.uv1_scale		= Vector3(20.0, 20.0, 1.0)
	else:
		ground_mat.albedo_color		= Color(0.35, 0.60, 0.25)
	ground_mat.roughness			= 0.95
	ground.material_override		= ground_mat

	var ground_col			:= CollisionShape3D.new()
	var ground_shape		:= BoxShape3D.new()
	ground_shape.size		= Vector3(120.0, 0.1, 120.0)
	ground_col.shape		= ground_shape

	ground_body.add_child(ground)
	ground_body.add_child(ground_col)
	add_child(ground_body)

	# ── Soleil ────────────────────────────────────────────────────────────────
	var sun					:= DirectionalLight3D.new()
	sun.name				= "Sun"
	sun.rotation_degrees	= Vector3(-55.0, 45.0, 0.0)
	sun.light_energy		= 1.2
	sun.shadow_enabled		= true
	add_child(sun)

	# ── Ciel + ambiance ───────────────────────────────────────────────────────
	var sky_mat						:= ProceduralSkyMaterial.new()
	sky_mat.sky_top_color			= Color(0.28, 0.52, 0.85)
	sky_mat.sky_horizon_color		= Color(0.75, 0.85, 0.95)
	sky_mat.ground_bottom_color		= Color(0.20, 0.18, 0.15)
	var sky							:= Sky.new()
	sky.sky_material				= sky_mat
	var env							:= Environment.new()
	env.background_mode				= Environment.BG_SKY
	env.sky							= sky
	env.ambient_light_source		= Environment.AMBIENT_SOURCE_COLOR
	env.ambient_light_color			= Color(0.6, 0.65, 0.75)
	env.ambient_light_energy		= 0.4
	var world_env					:= WorldEnvironment.new()
	world_env.environment			= env
	add_child(world_env)

# ==============================================================================
# ASSETS — arbre + maison placés en exemples
# Tu dupliques les lignes pour ajouter d'autres instances
# ==============================================================================
func _place_assets() -> void:
	var assets			:= Node3D.new()
	assets.name			= "Assets"
	add_child(assets)

	# ── Arbre ─────────────────────────────────────────────────────────────────
	var tree_scene	:= load("res://assets/Blender/tree.glb")
	if tree_scene:
		var tree			: Node3D = tree_scene.instantiate()
		tree.name			= "Tree_01"
		tree.position		= Vector3(10.0, 0.0, -8.0)
		assets.add_child(tree)
	else:
		push_warning("BernisKawa3D : tree.glb introuvable")

	# ── Maison ────────────────────────────────────────────────────────────────
	var house_scene	:= load("res://assets/Blender/Sans titre.glb")
	if house_scene:
		var house			: Node3D = house_scene.instantiate()
		house.name			= "House_01"
		house.position		= Vector3(-8.0, 0.0, 5.0)
		assets.add_child(house)
	else:
		push_warning("BernisKawa3D : Sans titre.glb introuvable")

# ==============================================================================
# JOUEUR
# ==============================================================================
func _build_player() -> void:
	_player				= CharacterBody3D.new()
	_player.name		= "Player"
	_player.position	= Vector3(0.0, 0.0, 0.0)

	var col				:= CollisionShape3D.new()
	var shape			:= CapsuleShape3D.new()
	shape.radius		= 0.26
	shape.height		= 1.45
	col.position		= Vector3(0.0, 0.725, 0.0)
	col.shape			= shape
	_player.add_child(col)

	var body_mi					:= MeshInstance3D.new()
	var body_mesh				:= CapsuleMesh.new()
	body_mesh.radius			= 0.26
	body_mesh.height			= 1.45
	body_mi.mesh				= body_mesh
	body_mi.position			= Vector3(0.0, 0.725, 0.0)
	var body_mat				:= StandardMaterial3D.new()
	body_mat.albedo_color		= Color(0.22, 0.42, 0.82)
	body_mat.roughness			= 0.75
	body_mi.material_override	= body_mat
	_player.add_child(body_mi)

	var head_mi					:= MeshInstance3D.new()
	var head_mesh				:= SphereMesh.new()
	head_mesh.radius			= 0.20
	head_mesh.height			= 0.40
	head_mi.mesh				= head_mesh
	head_mi.position			= Vector3(0.0, 1.67, 0.0)
	var head_mat				:= StandardMaterial3D.new()
	head_mat.albedo_color		= Color(0.92, 0.76, 0.60)
	head_mat.roughness			= 0.85
	head_mi.material_override	= head_mat
	_player.add_child(head_mi)

	add_child(_player)

# ==============================================================================
# CAMÉRA
# ==============================================================================
func _build_camera() -> void:
	_camera_arm			= Node3D.new()
	_camera_arm.name	= "CameraArm"
	add_child(_camera_arm)

	_camera				= Camera3D.new()
	_camera.name		= "Camera"
	_camera.projection	= Camera3D.PROJECTION_ORTHOGONAL
	_camera.size		= 14.0

	var h_rad	:= deg_to_rad(CAM_ANGLE_H)
	var v_rad	:= deg_to_rad(CAM_ANGLE_V)
	_camera.position	= Vector3(
		CAM_DISTANCE * sin(h_rad) * cos(v_rad),
		CAM_DISTANCE * sin(-v_rad),
		CAM_DISTANCE * cos(h_rad) * cos(v_rad)
	)
	_camera.look_at_from_position(_camera.position, Vector3.ZERO, Vector3.UP)
	_camera_arm.add_child(_camera)

# ==============================================================================
# LOOP
# ==============================================================================
func _physics_process(delta: float) -> void:
	_handle_player(delta)

func _process(delta: float) -> void:
	_handle_camera(delta)

func _handle_player(delta: float) -> void:
	if not _player.is_on_floor():
		_player.velocity.y -= GRAVITY * delta

	var input := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	var speed := PLAYER_SPRINT if Input.is_key_pressed(KEY_SHIFT) else PLAYER_SPEED

	if input.length() > 0.1:
		var cam_basis	:= Vector3(sin(deg_to_rad(CAM_ANGLE_H)), 0.0, cos(deg_to_rad(CAM_ANGLE_H)))
		var cam_right	:= cam_basis
		var cam_fwd		:= Vector3(-cam_basis.z, 0.0, cam_basis.x)
		var direction	:= (cam_right * input.x + cam_fwd * -input.y).normalized()
		_player.velocity.x	= direction.x * speed
		_player.velocity.z	= direction.z * speed
		var target_angle	:= atan2(direction.x, direction.z)
		_player.rotation.y	= lerp_angle(_player.rotation.y, target_angle, 12.0 * delta)
	else:
		_player.velocity.x	= move_toward(_player.velocity.x, 0.0, speed * 8.0 * delta)
		_player.velocity.z	= move_toward(_player.velocity.z, 0.0, speed * 8.0 * delta)

	_player.position.x	= clamp(_player.position.x, -MAP_HALF, MAP_HALF)
	_player.position.z	= clamp(_player.position.z, -MAP_HALF, MAP_HALF)

	_player.move_and_slide()

func _handle_camera(delta: float) -> void:
	var target				:= _player.position + Vector3(0.0, 0.9, 0.0)
	_camera_arm.position	= _camera_arm.position.lerp(target, CAM_SMOOTH * delta)
