extends Node2D

@onready var dialogue = $DialogueBox

func _ready():
	await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	dialogue.afficher_sequence([
		["", "La maison de Ren. Simple, chaleureuse."],
		["", "Sur la table — le carnet de maman."],
		["", "Elle oublie toujours ses affaires quand elle est pressée."],
	], _apres_dialogue)

func _apres_dialogue():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/monde.tscn")
