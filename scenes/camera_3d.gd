extends Camera3D

func _process(delta):
	var joueur = get_parent()
	global_position = joueur.global_position + Vector3(0, 12, 8)
	look_at(joueur.global_position, Vector3.UP)
