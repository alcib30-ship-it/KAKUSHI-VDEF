extends "res://scripts/BaseTrigger.gd"

func _ready() -> void:
	super._ready()
	if Global.balise_1_activee:
		$ColorRect.visible = false

func condition_activation() -> bool:
	return StoryManager.est_a_partir_de(StoryManager.Etape.YAMOTO_VU) and !Global.balise_1_activee

func on_activation() -> void:
	Global.balise_1_activee = true
	$ColorRect.visible      = false
	StoryManager.avancer(StoryManager.Etape.BALISE_ACTIVEE)
	DialogueManager.show_dialogue([
		["", "Une pierre ancienne gravée de symboles pulse d'une lumière bleue."],
		["", "Ren pose la main dessus. Flash bleu. Toute l'équipe soignée. ✨"],
		["", "« La lumière qui tombe n'est pas toujours une catastrophe. Parfois c'est une réponse. — Fragment 1/7 »"],
		["", "Qu'est-ce que ça veut dire."],
		["", "La pierre s'éteint doucement. Elle ne pulsera plus jamais."],
	], Callable())
