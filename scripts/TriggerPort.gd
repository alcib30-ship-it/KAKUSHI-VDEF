extends "res://scripts/BaseTrigger.gd"

func condition_activation() -> bool:
	return StoryManager.est_a_partir_de(StoryManager.Etape.ECOLE_VUE)

func on_activation() -> void:
	StoryManager.avancer(StoryManager.Etape.YAMOTO_VU)
	DialogueManager.show_dialogue([
		["Yamoto", "Alors c'est toi."],
		["Ren",    "Ma mère m'a dit de venir vous voir."],
		["Yamoto", "Je sais. Je t'attendais depuis un moment."],
		["Yamoto", "Un Tisseur c'est quelqu'un qui peut créer un Lien avec un Kakushi. Pas les dresser. Pas les capturer. Créer un Lien. C'est différent."],
		["Ren",    "C'est quoi la différence ?"],
		["Yamoto", "La différence c'est que lui... il a choisi. Pas toi."],
		["Ren",    "Il m'a choisi sans me connaître ?"],
		["Yamoto", "Tu connais quelqu'un qui t'a choisi en te connaissant d'abord ?"],
		["Yamoto", "Prends soin de ce Lien. C'est la chose la plus fragile et la plus solide que tu auras jamais."],
		["Yamoto", "La salamandre sur la route de la forêt — elle gardait une Balise de l'Éclat. Des pierres qui soignent. Des pierres qui parlent."],
		["Yamoto", "Certains disent qu'elles racontent l'histoire de la Chute, fragment par fragment."],
		["Yamoto", "Y en a sept. Au cas où tu serais curieux."],
	], Callable())
