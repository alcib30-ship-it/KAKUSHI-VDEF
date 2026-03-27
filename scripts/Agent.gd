extends Node2D

@onready var dialogue = $DialogueBox

func _ready():
	await get_tree().process_frame
	await get_tree().create_timer(0.5).timeout
	dialogue.afficher_sequence([
		["Agent", "Inventaire de routine. Le Consortium recense tous les Kakushi de la zone."],
		["Agent", "Intéressant. Un Tisseur. Ton nom ?"],
		["", "[Appuie sur Entrée pour continuer]"],
		["Agent", "Peu importe. On se reverra."],
		["Jirou", "Ces gens ne recensent pas. Ils prennent."],
	], _apres_dialogue)

func _apres_dialogue():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/monde.tscn")
