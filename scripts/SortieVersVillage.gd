extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		Global.spawn_x = Global.derniere_position_monde.x
		Global.spawn_y = Global.derniere_position_monde.y
		call_deferred("_changer_scene")

func _changer_scene():
	Transition.vers_monde()
