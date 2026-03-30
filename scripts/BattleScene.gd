extends Node2D

var embrix_pv_max : int = 38
var embrix_pv : int = 38
var embrix_atk : int = 58
var embrix_def : int = 28

var starter_pv_max : int = 45
var starter_pv : int = 45
var starter_atk : int = 52
var starter_def : int = 38
var starter_je : int = 100

var attaques = [
	{"nom": "Morsure de Braise", "je": 10, "puissance": 25},
	{"nom": "Queue Enflammée",   "je": 15, "puissance": 35},
	{"nom": "Rugissement",       "je": 10, "puissance": 0},
]

var tour_joueur : bool = true
var combat_termine : bool = false

@onready var ennemi_pv_bar = $EnnemiPanel/EnnemiPV
@onready var joueur_pv_bar = $JoueurPanel/JoueurPV
@onready var joueur_je_bar = $JoueurPanel/JoueurJE
@onready var battle_log = $BattleLog
@onready var starter_nom = $JoueurPanel/StarterNom
@onready var btn1 = $Boutons/BtnAttaque1
@onready var btn2 = $Boutons/BtnAttaque2
@onready var btn3 = $Boutons/BtnAttaque3

func _ready():
	starter_nom.text = Global.starter_choisi.capitalize()
	btn1.pressed.connect(func(): attaquer(0))
	btn2.pressed.connect(func(): attaquer(1))
	btn3.pressed.connect(func(): attaquer(2))
	battle_log.text = "Embrix bloque le chemin !"
	maj_barres()

func attaquer(index: int):
	if !tour_joueur or combat_termine:
		return
	var attaque = attaques[index]
	if starter_je < attaque["je"]:
		battle_log.text = "Pas assez d'Éclat !"
		return
	starter_je -= attaque["je"]
	var degats = 0
	if attaque["puissance"] > 0:
		degats = int((float(starter_atk) / float(embrix_def)) * attaque["puissance"] * randf_range(0.88, 1.0))
		embrix_pv -= degats
		embrix_pv = max(0, embrix_pv)
		battle_log.text = attaque["nom"] + " inflige " + str(degats) + " dégâts !"
	else:
		battle_log.text = "Rugissement ! L'ATK d'Embrix baisse !"
		embrix_atk = int(embrix_atk * 0.85)
	maj_barres()
	if embrix_pv <= 0:
		victoire()
		return
	tour_joueur = false
	_desactiver_boutons()
	await get_tree().create_timer(1.2).timeout
	tour_embrix()

func tour_embrix():
	var degats = int((float(embrix_atk) / float(starter_def)) * 30 * randf_range(0.88, 1.0))
	starter_pv -= degats
	starter_pv = max(0, starter_pv)
	battle_log.text = "Embrix attaque et inflige " + str(degats) + " dégâts !"
	maj_barres()
	starter_je = min(100, starter_je + 5)
	if starter_pv <= 0:
		defaite()
		return
	tour_joueur = true
	_activer_boutons()

func maj_barres():
	ennemi_pv_bar.value = embrix_pv
	joueur_pv_bar.value = starter_pv
	joueur_je_bar.value = starter_je

func victoire():
	combat_termine = true
	_desactiver_boutons()
	battle_log.text = "Embrix a fui. On a fait ça."
	StoryManager.avancer(StoryManager.Etape.COMBAT_GAGNE)
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://scenes/Foret.tscn")

func defaite():
	combat_termine = true
	_desactiver_boutons()
	battle_log.text = "Aïe. Accroche-toi."
	await get_tree().create_timer(2.0).timeout
	get_tree().reload_current_scene()

func _desactiver_boutons():
	btn1.disabled = true
	btn2.disabled = true
	btn3.disabled = true

func _activer_boutons():
	btn1.disabled = false
	btn2.disabled = false
	btn3.disabled = false
