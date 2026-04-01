extends "res://scripts/BaseTrigger.gd"

func condition_activation() -> bool:
	return not StoryManager.est_a_partir_de(StoryManager.Etape.MAISON_VUE)

func on_activation() -> void:
	StoryManager.avancer(StoryManager.Etape.MAISON_VUE)
	DialogueManager.show_dialogue([
		["",     "La maison de Ren. Simple, chaleureuse."],
		["",     "Sur la table — le carnet de maman."],
		["",     "Elle oublie toujours ses affaires quand elle est pressée."],
		["Père", "Tu as dormi dehors encore."],
		["Ren",  "..."],
		["Père", "Fais attention sur la route."],
		["",     "Il repart sans attendre. Une habitude entre eux."],
	], Callable())
