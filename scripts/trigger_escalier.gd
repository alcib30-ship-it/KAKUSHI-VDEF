extends "res://scripts/BaseTrigger.gd"

func condition_activation() -> bool:
	return not StoryManager.est_a_partir_de(StoryManager.Etape.LIEN_CREE)

func on_activation() -> void:
	StoryManager.avancer(StoryManager.Etape.FORET_ENTREE)
	Transition.vers("res://scenes/Foret.tscn", "entree_foret_ouest")
