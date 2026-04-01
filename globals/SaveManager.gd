extends Node

const SAVE_PATH = "user://kakusei_save.json"

func sauvegarder() -> void:
	var data = {
		"starter_choisi":        Global.starter_choisi,
		"kakushi_visible":       Global.kakushi_visible,
		"balise_1_activee":      Global.balise_1_activee,
		"tisseur_rank":          Global.tisseur_rank,
		"fiabilite":             Global.fiabilite,
		"spawn_x":               Global.spawn_x,
		"spawn_y":               Global.spawn_y,
		"kakushi_sauvage":       Global.kakushi_sauvage,
		"nom_donne_consortium":  Global.nom_donne_consortium,
		"a_lettre_jirou":        Global.a_lettre_jirou,
		"a_potions":             Global.a_potions,
		"etape":                 StoryManager.etape_actuelle,
		"choix_consortium":      StoryManager.choix_consortium,
		"choix_chemin_jirou":    StoryManager.choix_chemin_jirou,
	}
	var fichier = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if fichier:
		fichier.store_string(JSON.stringify(data))
		fichier.close()
	else:
		push_error("SaveManager : impossible d'écrire le fichier")

func charger() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	var fichier = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not fichier:
		return false
	var data = JSON.parse_string(fichier.get_as_text())
	fichier.close()
	if data == null:
		return false
	Global.starter_choisi       = data.get("starter_choisi", "")
	Global.kakushi_visible      = data.get("kakushi_visible", false)
	Global.balise_1_activee     = data.get("balise_1_activee", false)
	Global.tisseur_rank         = data.get("tisseur_rank", 0)
	Global.fiabilite            = data.get("fiabilite", 1.0)
	Global.spawn_x              = data.get("spawn_x", 144.0)
	Global.spawn_y              = data.get("spawn_y", 200.0)
	Global.kakushi_sauvage      = data.get("kakushi_sauvage", "")
	Global.nom_donne_consortium = data.get("nom_donne_consortium", false)
	Global.a_lettre_jirou       = data.get("a_lettre_jirou", false)
	Global.a_potions            = data.get("a_potions", 0)
	StoryManager.etape_actuelle     = data.get("etape", StoryManager.Etape.DEBUT)
	StoryManager.choix_consortium   = data.get("choix_consortium", "")
	StoryManager.choix_chemin_jirou = data.get("choix_chemin_jirou", "")
	return true

func supprimer() -> void:
	if FileAccess.file_exists(SAVE_PATH):
		DirAccess.remove_absolute(SAVE_PATH)
