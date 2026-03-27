extends Area2D

var declenche : bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D and !declenche:
		if Global.starter_choisi == "":
			return
		declenche = true
		DialogueManager.show_dialogue([
			["Mère", "Tu as trouvé l'escalier."],
			["Ren", "Tu savais ?"],
			["Mère", "Je savais que ça arriverait. Depuis le jour où tu es né."],
			["Mère", "Ton père aussi a ressenti ça. Au même âge. Au même endroit."],
			["Ren", "Il était Tisseur ?"],
			["Mère", "Il l'est encore. Quelque part."],
			["Mère", "Va voir Yamoto au port. Il t'expliquera ce que tu es maintenant."],
		], _apres_dialogue)

func _apres_dialogue():
	Global.set_spawn_point("apres_ecole")
	DialogueManager.change_scene("res://scenes/monde.tscn")
