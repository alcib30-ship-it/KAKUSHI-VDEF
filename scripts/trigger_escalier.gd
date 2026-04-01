extends "res://scripts/BaseTrigger.gd"

func condition_activation() -> bool:
	return not StoryManager.est_a_partir_de(StoryManager.Etape.LIEN_CREE)

func on_activation() -> void:
	Global.derniere_position_monde = Vector2(Global.spawn_x, Global.spawn_y)
	Global.spawn_x = 100
	Global.spawn_y = 324
	StoryManager.avancer(StoryManager.Etape.FORET_ENTREE)
	Transition.vers_foret()
