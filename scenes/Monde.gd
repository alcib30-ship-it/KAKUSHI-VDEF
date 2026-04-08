# scenes/Monde.gd
extends Node2D

func _ready() -> void:
	await get_tree().process_frame
	WorldLoader.charger("monde")
	
	if StoryManager.etape_actuelle == StoryManager.Etape.DEBUT:
		_lancer_creation_personnage()

# ─── ÉTAPE 1 : CRÉATION PERSONNAGE ─────────────────────────

func _lancer_creation_personnage() -> void:
	$Joueur.visible = false
	_demander_genre()

func _demander_genre() -> void:
	DialogueManager.show_choix(
		"Qui es-tu ?  →  Lui  /  Elle",
		func(): _confirmer_genre("Lui"),
		func(): _confirmer_genre("Elle")
	)

func _confirmer_genre(genre: String) -> void:
	Global.player_genre = genre
	DialogueManager.show_choix(
		"Comment t'appelles-tu ?  →  Ren  /  Ren",
		func(): _confirmer_prenom("Ren"),
		func(): _confirmer_prenom("Ren")
	)

func _confirmer_prenom(prenom: String) -> void:
	Global.player_name = prenom
	StoryManager.avancer(StoryManager.Etape.PERSONNAGE_CREE)
	_decouvrir_falaise()

# ─── ÉTAPE 2 : RÉVEIL SUR LA FALAISE ───────────────────────

func _decouvrir_falaise() -> void:
	$Joueur.visible = true
	DialogueManager.show_dialogue(
		WorldData.DIALOGUES_CLAIRIERE["telephone_pere"],
		_afficher_objectif
	)

# ─── ÉTAPE 3 : OBJECTIF ────────────────────────────────────

func _afficher_objectif() -> void:
	$Label.text = WorldData.DIALOGUES_CLAIRIERE["objectif"][0][1]
	$Label.visible = true
	await get_tree().create_timer(3.0).timeout
	$Label.visible = false
