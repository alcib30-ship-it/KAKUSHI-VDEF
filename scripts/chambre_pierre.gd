extends Node2D

@onready var dialogue = $DialogueBox
@onready var cristal = $Artefact/Cristal

var temps_pulse : float = 0.0

func _ready():
	await get_tree().create_timer(1.0).timeout
	dialogue.afficher_sequence([
		["", "Tiens... on dirait que le cristal réagit à ta présence."],
		["", "Le cristal s'illumine et t'éblouit."],
		["", "Une sensation bizarre parcourt tout ton corps et ton esprit, comme si l'artefact te faisait passer un message."],
		["", "Cela voudrait peut-être dire que tu es un... Tisseur !"]
	], _apres_dialogue)
	Global.ren_est_tisseur = true
	Global.resonance_active = true

func _apres_dialogue():
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/monde.tscn")

func _process(delta):
	temps_pulse += delta
	var luminosite = (sin(temps_pulse * 2.0) + 1.0) / 2.0
	cristal.color = Color(
		0.6 + luminosite * 0.2,
		0.4 + luminosite * 0.2,
		1.0,
		0.7 + luminosite * 0.3
	)
