extends "res://scripts/BaseTrigger.gd"

func condition_activation() -> bool:
	return StoryManager.est_a_partir_de(StoryManager.Etape.BALISE_ACTIVEE)

func on_activation() -> void:
	DialogueManager.show_dialogue([
		["Agent", "Inventaire de routine. Le Consortium recense tous les Kakushi de la zone. C'est pour votre sécurité."],
		["Agent", "Intéressant. Un Tisseur. Ton nom ?"],
	], _choix_identite)

func _choix_identite() -> void:
	DialogueManager.show_choix(
		"Donner ton nom ? (O) — Refuser. (N)",
		func(): _repondre_nom(),
		func(): _refuser_nom()
	)

func _repondre_nom() -> void:
	StoryManager.choix_consortium   = "nom"
	Global.nom_donne_consortium     = true
	_suite_consortium()

func _refuser_nom() -> void:
	StoryManager.choix_consortium   = "refuse"
	Global.nom_donne_consortium     = false
	_suite_consortium()

func _suite_consortium() -> void:
	StoryManager.avancer(StoryManager.Etape.CONSORTIUM_VU)
	DialogueManager.show_dialogue([
		["Agent", "Joli spécimen. Le Consortium s'intéresse beaucoup aux nouveaux Liens."],
		["Jirou", "Ces gens ne recensent pas. Ils prennent."],
		["",      "Je m'en souviendrai."],
	], Callable())
