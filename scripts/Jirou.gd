extends Node2D

@onready var dialogue = $DialogueBox

func _ready():
	await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	dialogue.afficher_sequence([
		["Jirou", "Tu vas à l'école ?"],
		["Ren", "Apporter le carnet de maman."],
		["Jirou", "Si tu croises quelque chose qui te regarde sans fuir... reste immobile. Laisse-le venir à toi."],
		["Ren", "Pourquoi tu me dis ça ?"],
		["Jirou", "Fais attention. Il se passe des choses étranges dans cette forêt en ce moment."],
	], Callable())
