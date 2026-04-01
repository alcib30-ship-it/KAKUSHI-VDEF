# scripts/PnjBase.gd
# Script de base pour tous les PNJ
# Gère le sprite + animation + direction face au joueur
extends Node2D

var data : Dictionary = {}
var sprite : AnimatedSprite2D = null

func setup(d: Dictionary) -> void:
	data = d
	position = d.get("position", Vector2.ZERO)
	_creer_sprite()

func _creer_sprite() -> void:
	sprite = AnimatedSprite2D.new()
	var sprite_id = data.get("sprite", "")
	var chemin = "res://sprites/personnages/" + sprite_id + ".png"
	if not ResourceLoader.exists(chemin):
		# Sprite manquant — carré coloré de remplacement
		var rect = ColorRect.new()
		rect.size = Vector2(32, 48)
		rect.position = Vector2(-16, -48)
		rect.color = Color(0.4, 0.6, 1.0, 0.8)
		add_child(rect)
		return
	add_child(sprite)
	sprite.animation = "walk_down"

func regarder_joueur(joueur_pos: Vector2) -> void:
	if sprite == null:
		return
	var diff = joueur_pos - global_position
	if abs(diff.x) > abs(diff.y):
		sprite.animation = "walk_right"
		sprite.flip_h = diff.x < 0
	else:
		sprite.animation = "walk_down" if diff.y > 0 else "walk_up"
		sprite.flip_h = false
