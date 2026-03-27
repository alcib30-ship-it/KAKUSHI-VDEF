extends Area2D

var declenche : bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D and !declenche:
		declenche = true
		DialogueManager.show_dialogue([
			["Jirou", "Tu vas à l'école ?"],
			["Ren", "Apporter le carnet de maman."],
			["Jirou", "Si tu croises quelque chose qui te regarde sans fuir... reste immobile. Laisse-le venir à toi."],
			["Ren", "Pourquoi tu me dis ça ?"],
			["Jirou", "Fais attention. Il se passe des choses étranges dans cette forêt en ce moment."],
		], Callable())
