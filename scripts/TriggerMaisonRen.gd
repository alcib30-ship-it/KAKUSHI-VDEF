extends Area2D

var declenche : bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D and !declenche:
		declenche = true
		call_deferred("_changer_scene")

func _changer_scene():
	get_tree().change_scene_to_file("res://scenes/MaisonRen.tscn")
