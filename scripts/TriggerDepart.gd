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
			["Jirou", "Donne ça à Akemi. Elle sait qui je suis."],
			["Jirou", "La Chute de la Kakusei-sei... ce n'était pas un accident."],
			["Père", "Fais attention."],
			["Père", "Et si tu trouves des réponses... reviens me les dire."],
			["", "Ce matin j'étais personne. Ce soir je suis Tisseur."],
			["", "— Chapitre 1 — L'Éveil — Terminé —"],
		], Callable())
