extends "res://scripts/BaseTrigger.gd"

func condition_activation() -> bool:
	return StoryManager.est_a_partir_de(StoryManager.Etape.CONSORTIUM_VU)

func on_activation() -> void:
	StoryManager.avancer(StoryManager.Etape.CHAPITRE_1_TERMINE)
	DialogueManager.show_dialogue([
		["",      "'Parfois c'est une réponse.' Une réponse à quoi ?"],
		["",      "Il y a d'autres balises. D'autres fragments. Les réponses sont ailleurs."],
		["Mère",  "Tu pars ce soir ?"],
		["Ren",   "Oui."],
		["Mère",  "Des Potions. Pour toi et... pour lui."],
		["Père",  "Fais attention."],
		["",      "Il sait. Il a toujours su."],
		["Jirou", "Donne ça à Akemi. Elle sait qui je suis."],
		["Jirou", "La Chute de la Kakusei-sei... ce n'était pas un accident."],
		["",      "Ce matin j'étais personne. Ce soir je suis Tisseur."],
		["",      "— Chapitre 1 — L'Éveil — Terminé —"],
	], _apres_depart)

func _apres_depart() -> void:
	Global.a_lettre_jirou = true
	Global.a_potions      = 3
	SaveManager.sauvegarder()
