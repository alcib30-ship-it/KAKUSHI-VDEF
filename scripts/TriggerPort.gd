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
			["Yamoto", "Alors c'est toi."],
			["Ren", "Ma mère m'a dit de venir vous voir."],
			["Yamoto", "Je sais. Je t'attendais depuis un moment."],
			["Yamoto", "Un Tisseur c'est quelqu'un qui peut créer un Lien avec un Kakushi. Pas les dresser. Pas les capturer. Créer un Lien. C'est différent."],
			["Ren", "C'est quoi la différence ?"],
			["Yamoto", "La différence c'est que lui... il a choisi. Pas toi."],
			["Yamoto", "Prends soin de ce Lien. C'est la chose la plus fragile et la plus solide que tu auras jamais."],
			["Yamoto", "Oh — et la salamandre sur la route de la forêt. Elle garde une Balise de l'Éclat."],
			["Yamoto", "Tu peux y retourner maintenant que t'as un compagnon."],
		], Callable())
