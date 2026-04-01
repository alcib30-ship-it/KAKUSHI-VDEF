extends Node2D

const VITESSE = 80

@onready var corps  = $Corps
@onready var sprite : AnimatedSprite2D = $Corps/SpriteRen

func _ready() -> void:
	await get_tree().process_frame
	if Global.spawn_point != "":
		var marker = get_tree().current_scene.find_child(Global.spawn_point, true, false)
		if marker != null:
			corps.position = marker.position
		else:
			push_warning("Joueur : Marker2D introuvable → " + Global.spawn_point)
			corps.position = Vector2(Global.spawn_x, Global.spawn_y)
		Global.spawn_point = ""
	else:
		corps.position = Vector2(Global.spawn_x, Global.spawn_y)
	$Corps/SpriteKakushi.visible = Global.kakushi_visible

func _physics_process(_delta) -> void:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		sprite.animation = "walk_right"
		sprite.flip_h    = false
		sprite.play()
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		sprite.animation = "walk_right"
		sprite.flip_h    = true
		sprite.play()
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
		sprite.animation = "walk_down"
		sprite.flip_h    = false
		sprite.play()
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		sprite.animation = "walk_up"
		sprite.flip_h    = false
		sprite.play()
	else:
		sprite.stop()
		sprite.flip_h = false
		sprite.frame  = 0
	corps.velocity = direction.normalized() * VITESSE
	corps.move_and_slide()
