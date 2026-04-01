extends "res://scripts/BaseTrigger.gd"

func condition_activation() -> bool:
	return true

func on_activation() -> void:
	StoryManager.avancer(StoryManager.Etape.JIROU_VU)
	DialogueManager.show_dialogue([
		["Jirou", "Tu vas à l'école ?"],
		["Ren",   "Apporter le carnet de maman."],
		["Jirou", "Par la forêt ou par la route ?"],
	], _choix_chemin)

func _choix_chemin() -> void:
	DialogueManager.show_choix(
		"Par la route, c'est plus court. (O)
		 Par la forêt, c'est plus beau. (N)",
		func(): StoryManager.choix_chemin_jirou = "route"; _suite_jirou(),
		func(): StoryManager.choix_chemin_jirou = "foret"; _suite_jirou()
	)

func _suite_jirou() -> void:
	DialogueManager.show_dialogue([
		["Jirou", "Si tu croises quelque chose qui te regarde sans fuir... reste immobile. Laisse-le venir à toi."],
		["Ren",   "Pourquoi tu me dis ça ?"],
		["Jirou", "Cette forêt... elle a changé depuis la Chute. Les animaux ordinaires ne regardent plus les humains en face. Mais certains, oui. Ceux-là sont différents."],
		["Ren",   "Différents comment ?"],
		["Jirou", "Quand tu le verras, tu comprendras. Va."],
		["",      "Des choses étranges. Comme d'habitude avec lui."],
	], Callable())
