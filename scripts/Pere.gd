extends Node2D

@onready var dialogue = $DialogueBox

func _ready():
	await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	dialogue.afficher_sequence([
		["Père", "Tu as dormi dehors encore."],
		["Ren", "..."],
		["Père", "Fais attention sur la route."],
	], _apres_dialogue)

func _apres_dialogue():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/monde.tscn")
