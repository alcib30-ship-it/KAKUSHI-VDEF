extends Node2D

@onready var dialogue = $DialogueBox

func _ready():
	await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	dialogue.afficher_sequence([
		["Mère", "Tu as trouvé l'escalier."],
		["Ren", "Tu savais ?"],
		["Mère", "Je savais que ça arriverait. Depuis le jour où tu es né."],
		["Mère", "Ton père aussi a ressenti ça. Au même âge. Au même endroit."],
		["Ren", "Il était Tisseur ?"],
		["Mère", "Il l'est encore. Quelque part."],
		["Mère", "Va voir Yamoto au port. Il t'expliquera ce que tu es maintenant."],
		["Mère", "Prends soin de lui."],
	], _fermer)

func _fermer():
	Global.spawn_x = 1100
	Global.spawn_y = 430
	get_tree().change_scene_to_file("res://scenes/monde.tscn")
