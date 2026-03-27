extends Area2D

var utilise : bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D and !utilise:
		if Global.starter_choisi != "":
			return
		utilise = true
		Global.spawn_x = 32
		Global.spawn_y = 200
		call_deferred("_changer_scene")

func _changer_scene():
	get_tree().change_scene_to_file("res://scenes/Foret.tscn")
