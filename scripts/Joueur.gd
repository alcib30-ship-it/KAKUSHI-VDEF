extends Node2D

const VITESSE = 80

@onready var corps = $Corps
@onready var sprite : AnimatedSprite2D = $Corps/SpriteRen

func _ready():
	await get_tree().process_frame
	corps.position = Vector2(Global.spawn_x, Global.spawn_y)
	var spr = get_node_or_null("Corps/SpriteRen")
	print("SpriteRen trouvé : ", spr)
	if spr == null:
		print("Enfants de Corps : ")
		for child in $Corps.get_children():
			print(" - ", child.name)

func _physics_process(_delta):
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		sprite.animation = "walk_right"
		sprite.flip_h = false
		sprite.play()
	elif Input.is_action_pressed("ui_left"):
		direction.x -= 1
		sprite.animation = "walk_right"
		sprite.flip_h = true
		sprite.play()
	elif Input.is_action_pressed("ui_down"):
		direction.y += 1
		sprite.animation = "walk_down"
		sprite.flip_h = false
		sprite.play()
	elif Input.is_action_pressed("ui_up"):
		direction.y -= 1
		sprite.animation = "walk_up"
		sprite.flip_h = false
		sprite.play()
	else:
		sprite.stop()
		sprite.flip_h = false
		sprite.frame = 0
	corps.velocity = direction.normalized() * VITESSE
	corps.move_and_slide()
