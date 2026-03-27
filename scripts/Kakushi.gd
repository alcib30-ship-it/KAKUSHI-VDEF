extends AnimatedSprite2D

var positions_precedentes : Array = []
var delai_suiveur : int = 15

func _ready():
	positions_precedentes.resize(delai_suiveur)
	for i in delai_suiveur:
		positions_precedentes[i] = get_parent().global_position + Vector2(0, 40)

func _physics_process(_delta):
	var corps = get_parent()
	
	positions_precedentes.append(corps.global_position)
	positions_precedentes.pop_front()
	
	global_position = positions_precedentes[0]
	
	var diff = positions_precedentes[-1] - positions_precedentes[0]
	if diff.length() > 0.5:
		if abs(diff.x) > abs(diff.y):
			animation = "walk_right"
			flip_h = diff.x < 0
		else:
			if diff.y > 0:
				animation = "walk_down"
			else:
				animation = "walk_up"
			flip_h = false
		play()
	else:
		stop()
		frame = 0
