extends Node

func vers_monde() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/monde.tscn")

func vers_foret() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/Foret.tscn")

func vers_ecole() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/Ecole.tscn")

func vers_battle() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/BattleScene.tscn")

func vers_chambre() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://scenes/ChambrePierre.tscn")
