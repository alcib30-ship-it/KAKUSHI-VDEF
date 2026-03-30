extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		if not StoryManager.est_a_partir_de(StoryManager.Etape.COMBAT_GAGNE):
			return
		call_deferred("_changer_scene")

func _changer_scene():
	Transition.vers("res://scenes/monde.tscn", "entree_apres_ecole")
