extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		Global.spawn_x = 1550
		Global.spawn_y = 0
		call_deferred("_changer_scene")

func _changer_scene():
	get_tree().change_scene_to_file("res://scenes/monde.tscn")
