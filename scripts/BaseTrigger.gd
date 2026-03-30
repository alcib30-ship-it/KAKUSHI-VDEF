# scripts/BaseTrigger.gd
# Script parent pour tous les triggers du jeu
# Hériter avec : extends BaseTrigger
extends Area2D

var declenche : bool = false

# Surcharger cette fonction dans chaque trigger enfant
func condition_activation() -> bool:
	return true

# Surcharger cette fonction dans chaque trigger enfant
func on_activation() -> void:
	pass

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D and !declenche:
		if not condition_activation():
			return
		declenche = true
		on_activation()
