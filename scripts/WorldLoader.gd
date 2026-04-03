# scripts/WorldLoader.gd
extends Node

func charger(scene_id: String) -> void:
	if not WorldData.SCENES.has(scene_id):
		push_warning("WorldLoader : scène inconnue → " + scene_id)
		return
	var data = WorldData.SCENES[scene_id]
	var parent = get_tree().current_scene
	await parent.get_tree().process_frame

	_instancier_triggers(data.get("triggers", []), parent)
	_instancier_pnj(data.get("pnj", []), parent)
	_instancier_kakushi_zones(data.get("kakushi_zones", []), parent)

func _instancier_triggers(liste: Array, parent: Node) -> void:
	for t in liste:
		var trigger = load("res://scripts/AutoTrigger.gd").new()
		trigger.name = "AutoTrigger_" + t.get("id", "unknown")
		parent.add_child(trigger)
		trigger.setup(t)

func _instancier_pnj(liste: Array, parent: Node) -> void:
	for pnj_data in liste:
		if not _condition_pnj_ok(pnj_data):
			continue
		var pnj = Node2D.new()
		pnj.name = "PNJ_" + pnj_data.get("id", "unknown")
		pnj.position = pnj_data.get("position", Vector2.ZERO)
		parent.add_child(pnj)
		var trigger_data = {
			"id": pnj_data["id"],
			"type": "dialogue",
			"position": Vector2.ZERO,
			"size": Vector2(48, 48),
			"dialogue_id": pnj_data.get("dialogue_id", ""),
			"condition": pnj_data.get("condition", ""),
			"avance_etape": pnj_data.get("avance_etape", ""),
			"repeatable": pnj_data.get("repeatable", false),
		}
		if pnj_data.get("has_choix", false):
			trigger_data["type"] = "dialogue_choix"
			trigger_data["choix_texte"] = pnj_data.get("choix_texte", "")
			trigger_data["on_oui"] = pnj_data.get("on_oui", "")
			trigger_data["on_non"] = pnj_data.get("on_non", "")
			trigger_data["suite_dialogue_id"] = pnj_data.get("suite_dialogue_id", "")
		var trigger = load("res://scripts/AutoTrigger.gd").new()
		trigger.name = "Trigger_" + pnj_data.get("id", "unknown")
		pnj.add_child(trigger)
		trigger.setup(trigger_data)

func _instancier_kakushi_zones(zones: Array, parent: Node) -> void:
	for zone in zones:
		# Indices au sol — instanciés maintenant
		for indice in zone.get("indices", []):
			var t = load("res://scripts/AutoTrigger.gd").new()
			t.name = "AutoTrigger_" + indice.get("id", "indice")
			parent.add_child(t)
			t.setup(indice)
		# Mur de fin de zone
		var mur = zone.get("mur_fin", {})
		if not mur.is_empty():
			var t = load("res://scripts/AutoTrigger.gd").new()
			t.name = "AutoTrigger_" + mur.get("id", "mur")
			parent.add_child(t)
			t.setup(mur)
		# Silhouettes Kakushi — déférées à la session sprites
		# WorldLoader.instancier_silhouettes(zone) sera appelé ici plus tard

func _condition_pnj_ok(pnj_data: Dictionary) -> bool:
	var cond = pnj_data.get("condition", "")
	if cond == "":
		return true
	if not StoryManager.Etape.has(cond):
		return false
	return StoryManager.est_a_partir_de(StoryManager.Etape[cond])
