extends Node2D

@onready var cristal = $Artefact/Cristal
var temps_pulse : float = 0.0

func _ready() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	StoryManager.avancer(StoryManager.Etape.ARTEFACT_VU)
	Global.ren_est_tisseur  = true
	Global.resonance_active = true
	DialogueManager.show_dialogue([
		["",      "C'est chaud. Pas le cristal — moi. Comme si quelque chose se réveillait."],
		["VOIX",  "Tiens... on dirait que le cristal réagit à ta présence."],
		["VOIX",  "Il s'illumine et t'éblouit."],
		["VOIX",  "Une sensation bizarre parcourt tout ton corps et ton esprit... comme si l'artefact te faisait passer un message."],
		["VOIX",  "Cela voudrait peut-être dire que tu es un... Tisseur."],
		["",      "Un Tisseur. Comme papa."],
	], _apres_dialogue)

func _apres_dialogue() -> void:
	Global.spawn_x = Global.derniere_position_monde.x
	Global.spawn_y = Global.derniere_position_monde.y
	Transition.vers_monde()

func _process(delta: float) -> void:
	temps_pulse += delta
	var luminosite = (sin(temps_pulse * 2.0) + 1.0) / 2.0
	cristal.color = Color(
		0.6 + luminosite * 0.2,
		0.4 + luminosite * 0.2,
		1.0,
		0.7 + luminosite * 0.3
	)
