# globals/Transition.gd
# AUTOLOAD — Nom : Transition
extends Node

# Charge une scène et place Ren sur le point d'entrée nommé
# point_entree : nom du Marker2D dans la scène de destination
# Si point_entree vide → utilise Global.spawn_x/y comme fallback
func vers(scene_path: String, point_entree: String = "") -> void:
	if point_entree != "":
		Global.spawn_point = point_entree
	get_tree().call_deferred("change_scene_to_file", scene_path)
