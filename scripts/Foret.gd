extends Node2D

@onready var zone_kitsufi = $ZonesResonance/ZoneKitsufi
@onready var zone_ondrak = $ZonesResonance/ZoneOndrak
@onready var zone_moshu = $ZonesResonance/ZoneMoshu
@onready var zone_zappiko = $ZonesResonance/ZoneZappiko
@onready var zone_kagemi = $ZonesResonance/ZoneKagemi

var starter_actuel : String = ""
var timer_lien : float = 0.0
var lien_en_cours : bool = false
var joueur_dans_zone : bool = false
var DUREE_LIEN : float = 3.0

func _ready():
	await get_tree().process_frame
	await get_tree().process_frame
	await get_tree().process_frame
	WorldLoader.charger("foret")   # ← ajouter cette ligne
	if Global.starter_choisi != "":
		_connecter_zones()
		return
	DialogueManager.show_dialogue([
		["", "La pulsion de l'artefact te guide. Des présences t'entourent."],
		["", "Si l'une d'elles te regarde sans fuir... reste immobile 3 secondes pour créer un Lien."],
		["", "Tu peux continuer à marcher pour en rencontrer d'autres."]
	], _connecter_zones)

func _connecter_zones():
	zone_kitsufi.body_entered.connect(_entrer_kitsufi)
	zone_kitsufi.body_exited.connect(_quitter_zone)
	zone_ondrak.body_entered.connect(_entrer_ondrak)
	zone_ondrak.body_exited.connect(_quitter_zone)
	zone_moshu.body_entered.connect(_entrer_moshu)
	zone_moshu.body_exited.connect(_quitter_zone)
	zone_zappiko.body_entered.connect(_entrer_zappiko)
	zone_zappiko.body_exited.connect(_quitter_zone)
	zone_kagemi.body_entered.connect(_entrer_kagemi)
	zone_kagemi.body_exited.connect(_quitter_zone)

func _entrer_kitsufi(body):
	if body is CharacterBody2D:
		_demarrer_lien("kitsufi", "Un renard aux queues enflammées te fixe sans bouger. Il attend quelque chose.")

func _entrer_ondrak(body):
	if body is CharacterBody2D:
		_demarrer_lien("ondrak", "Un petit dragon marin lève les yeux vers toi depuis le bord d'une mare. Il ne fuit pas.")

func _entrer_moshu(body):
	if body is CharacterBody2D:
		_demarrer_lien("moshu", "Dans l'ombre d'un grand arbre, un cerf aux bois fleuris te regarde. Il sent tes émotions.")

func _entrer_zappiko(body):
	if body is CharacterBody2D:
		_demarrer_lien("zappiko", "Un tanuki électrique tourne en rond devant toi, impatient. Il n'attendait que toi.")

func _entrer_kagemi(body):
	if body is CharacterBody2D:
		_demarrer_lien("kagemi", "Deux yeux violets observent depuis l'ombre d'un torii. Reste immobile.")

func _demarrer_lien(starter: String, texte: String):
	if Global.starter_choisi != "":
		return
	starter_actuel = starter
	lien_en_cours = true
	joueur_dans_zone = true
	timer_lien = 0.0
	DialogueManager.show_dialogue([
		["", texte],
		["", "[Reste immobile 3 secondes = Lien confirmé]   [Continue à marcher = starter suivant]"]
	], Callable())

func _quitter_zone(body):
	if body is CharacterBody2D and Global.starter_choisi == "":
		joueur_dans_zone = false
		lien_en_cours = false
		timer_lien = 0.0
		starter_actuel = ""

func _process(delta):
	if lien_en_cours and joueur_dans_zone and Global.starter_choisi == "":
		timer_lien += delta
		if timer_lien >= DUREE_LIEN:
			_confirmer_lien()

func _confirmer_lien():
	lien_en_cours = false
	DialogueManager.show_choix(
		"Un Lien fort vient de naître. Voulez-vous confirmer ce Lien ? (Ce choix est définitif)",
		_oui_lien,
		_non_lien
	)

func _oui_lien():
	Global.starter_choisi = starter_actuel
	Global.kakushi_visible = true
	Global.augmenter_fiabilite()
	StoryManager.avancer(StoryManager.Etape.LIEN_CREE)
	DialogueManager.show_dialogue([
		["", "Un Lien vient de naître."],
		["", "Tu sens une connexion profonde — comme si vous vous connaissiez depuis toujours."]
	], _apres_lien)

func _non_lien():
	Global.diminuer_fiabilite()
	starter_actuel = ""
	timer_lien = 0.0

func _apres_lien():
	await get_tree().create_timer(0.5).timeout
	StoryManager.avancer(StoryManager.Etape.FORET_ENTREE)
	Global.derniere_position_foret = Vector2(Global.spawn_x, Global.spawn_y)
	Transition.vers_battle()
