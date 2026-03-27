extends Node

var _box : Node = null

func register(dialogue_box: Node) -> void:
	_box = dialogue_box

func is_ready() -> bool:
	return _box != null and is_instance_valid(_box)

func show_dialogue(sequences: Array, on_done: Callable = Callable()) -> void:
	if not is_ready():
		push_warning("DialogueManager : aucune DialogueBox enregistrée.")
		return
	_box.afficher_sequence(sequences, on_done)

func show_choix(texte: String, on_oui: Callable, on_non: Callable) -> void:
	if not is_ready():
		push_warning("DialogueManager : aucune DialogueBox enregistrée.")
		return
	_box.afficher_choix(texte, on_oui, on_non)

func change_scene(path: String) -> void:
	if not is_instance_valid(get_tree()):
		push_error("DialogueManager.change_scene : get_tree() null.")
		return
	get_tree().call_deferred("change_scene_to_file", path)

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		_box = null
