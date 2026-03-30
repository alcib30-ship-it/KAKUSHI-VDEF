extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)
	if Global.balise_1_activee:
		$ColorRect.visible = false

func _on_body_entered(body):
	if body is CharacterBody2D and !Global.balise_1_activee:
		if not StoryManager.est_a_partir_de(StoryManager.Etape.YAMOTO_VU):
			return
		Global.balise_1_activee = true
		$ColorRect.visible = false
		StoryManager.avancer(StoryManager.Etape.BALISE_ACTIVEE)
		DialogueManager.show_dialogue([
			["", "Une pierre ancienne gravée de symboles pulse d'une lumière bleue."],
			["", "Tu poses la main dessus."],
			["", "La lumière qui tombe n'est pas toujours une catastrophe. Parfois c'est une réponse. — Fragment 1/?"],
			["", "La pierre s'éteint doucement. Elle ne pulsera plus jamais."],
		], Callable())
