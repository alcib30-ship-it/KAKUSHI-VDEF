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
			["Agent", "Inventaire de routine. Le Consortium recense tous les Kakushi de la zone."],
			["Agent", "Intéressant. Un Tisseur. Ton nom ?"],
			["", "[Appuie sur Entrée pour continuer]"],
			["Agent", "Peu importe. On se reverra."],
			["Jirou", "Ces gens ne recensent pas. Ils prennent."],
		], Callable())
