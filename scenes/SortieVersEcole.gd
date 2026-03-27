extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		if Global.starter_choisi == "":
			return
		call_deferred("_changer_scene")

func _changer_scene():
	Global.spawn_x = 1100
	Global.spawn_y = 430
	get_tree().change_scene_to_file("res://scenes/monde.tscn")
