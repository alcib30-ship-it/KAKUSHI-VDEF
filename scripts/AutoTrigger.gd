# scripts/AutoTrigger.gd
extends Area2D

var data : Dictionary = {}
var declenche : bool = false

func setup(d: Dictionary) -> void:
	data = d
	position = d.get("position", Vector2.ZERO)
	var shape = CollisionShape2D.new()
	var rect = RectangleShape2D.new()
	rect.size = d.get("size", Vector2(48, 48))
	shape.shape = rect
	add_child(shape)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	if not body is CharacterBody2D:
		return
	if declenche and not data.get("repeatable", false):
		return
	if not _condition_ok():
		return
	declenche = true
	_executer()

func _condition_ok() -> bool:
	var cond = data.get("condition", "")
	if cond == "":
		return true
	if cond.begins_with("not:"):
		var etape_str = cond.substr(4)
		if not StoryManager.Etape.has(etape_str):
			return true
		return not StoryManager.est_a_partir_de(StoryManager.Etape[etape_str])
	if not StoryManager.Etape.has(cond):
		return false
	var cond_extra = data.get("condition_extra", "")
	if cond_extra != "":
		if cond_extra.begins_with("not:"):
			var flag = cond_extra.substr(4)
			if Global.get(flag) == true:
				return false
	return StoryManager.est_a_partir_de(StoryManager.Etape[cond])

func _executer() -> void:
	var etape_str = data.get("avance_etape", "")
	if etape_str != "" and StoryManager.Etape.has(etape_str):
		StoryManager.avancer(StoryManager.Etape[etape_str])

	match data.get("type", "dialogue"):
		"dialogue":
			_faire_dialogue(data.get("dialogue_id", ""), Callable())
		"dialogue_choix":
			_faire_dialogue_puis_choix()
		"dialogue_fin":
			_faire_dialogue(data.get("dialogue_id", ""), _apres_fin)
		"transition":
			_faire_transition()
		"balise":
			_faire_balise()
		"indice":
			_faire_indice()

# ─── DIALOGUE SIMPLE ───────────────────────────
func _faire_dialogue(dialogue_id: String, callback: Callable) -> void:
	var lignes = WorldData.DIALOGUES.get(dialogue_id, [])
	if lignes.is_empty():
		push_warning("AutoTrigger : dialogue_id introuvable → " + dialogue_id)
		return
	var sequences = lignes.map(func(l): return [l["speaker"], l["text"]])
	DialogueManager.show_dialogue(sequences, callback)

# ─── DIALOGUE PUIS CHOIX ───────────────────────
func _faire_dialogue_puis_choix() -> void:
	_faire_dialogue(data.get("dialogue_id", ""), _ouvrir_choix)

func _ouvrir_choix() -> void:
	DialogueManager.show_choix(
		data.get("choix_texte", "Oui (O) / Non (N)"),
		func(): _apres_choix(data.get("on_oui", "")),
		func(): _apres_choix(data.get("on_non", ""))
	)

func _apres_choix(resultat: String) -> void:
	var trigger_id = data.get("id", "")
	if trigger_id == "jirou":
		StoryManager.choix_chemin_jirou = resultat
	elif trigger_id == "consortium":
		StoryManager.choix_consortium = resultat
		Global.nom_donne_consortium = (resultat == "consortium_nom")
	var suite_id = data.get("suite_dialogue_id", "")
	if suite_id != "":
		_faire_dialogue(suite_id, Callable())

# ─── FIN DE CHAPITRE ───────────────────────────
func _apres_fin() -> void:
	var inventaire = data.get("inventaire", {})
	for key in inventaire:
		Global.set(key, inventaire[key])
	SaveManager.sauvegarder()

# ─── TRANSITION ────────────────────────────────
func _faire_transition() -> void:
	var sauvegarde = data.get("sauvegarde_position", "")
	if sauvegarde == "monde":
		Global.derniere_position_monde = Vector2(Global.spawn_x, Global.spawn_y)
	elif sauvegarde == "foret":
		Global.derniere_position_foret = Vector2(Global.spawn_x, Global.spawn_y)
	var dest = data.get("destination", "monde")
	match dest:
		"monde":  Transition.vers_monde()
		"foret":  Transition.vers_foret()
		"ecole":  Transition.vers_ecole()
		"battle": Transition.vers_battle()
		_: push_warning("AutoTrigger : destination inconnue → " + dest)

# ─── BALISE ────────────────────────────────────
func _faire_balise() -> void:
	var flag = data.get("flag", "")
	if flag != "":
		Global.set(flag, true)
	_faire_dialogue(data.get("dialogue_id", ""), Callable())

# ─── INDICE AU SOL ─────────────────────────────
# Plumes, écailles, traces — indices narratifs sur les Kakushi rares
# Se déclenche une seule fois, donne un hint sur quand/où revenir
func _faire_indice() -> void:
	var texte = data.get("texte", "Des traces mystérieuses au sol...")
	DialogueManager.show_dialogue([
		["", texte]
	], Callable())
