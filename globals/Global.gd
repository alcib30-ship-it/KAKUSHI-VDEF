extends Node

# ─── JOUEUR ───────────────────────────────────────────────
var player_name   : String = "Ren"
var player_genre  : String = "neutre"
var hair_color    : String = "noir"
var skin_tone     : String = "matte"
var eye_color     : String = "brun"
var outfit        : String = "pecheur"

# ─── PROGRESSION ──────────────────────────────────────────
var starter_choisi              : String = ""
var ren_est_tisseur             : bool   = false
var resonance_active            : bool   = false
var identite_revelee_consortium : bool   = false
var balise_1_activee            : bool   = false
var kakushi_visible             : bool   = false
var kakushi_sauvage             : String = ""
var tisseur_rank                : int    = 0
var fiabilite                   : float  = 1.0

# ─── SPAWN ────────────────────────────────────────────────
var spawn_x     : float  = 144.0
var spawn_y     : float  = 200.0
var spawn_point : String = ""

# ─── HELPERS ──────────────────────────────────────────────
func il_elle() -> String:
	match player_genre:
		"garcon": return "il"
		"fille":  return "elle"
		_:        return "iel"

func augmenter_rang() -> void:
	tisseur_rank += 1

func augmenter_fiabilite(montant: float = 0.1) -> void:
	fiabilite = min(fiabilite + montant, 2.0)

func diminuer_fiabilite(montant: float = 0.05) -> void:
	fiabilite = max(fiabilite - montant, 0.1)

func set_spawn(x: float, y: float) -> void:
	spawn_x = x
	spawn_y = y
	spawn_point = ""

func set_spawn_point(nom: String) -> void:
	spawn_point = nom
	match nom:
		"clairiere":
			spawn_x = 144.0;  spawn_y = 200.0
		"avant_escalier":
			spawn_x = 1550.0; spawn_y = 0.0
		"apres_ecole":
			spawn_x = 1100.0; spawn_y = 430.0
		"port":
			spawn_x = 480.0;  spawn_y = 1088.0
		"consortium":
			spawn_x = 700.0;  spawn_y = 700.0
		_:
			push_warning("Global.set_spawn_point : point inconnu → " + nom)
			
# INVENTAIRE
var a_lettre_jirou       : bool  = false
var a_potions            : int   = 0

# FLAGS NARRATIFS
var nom_donne_consortium : bool  = false

# _ready pour charger la save au démarrage
func _ready() -> void:
	SaveManager.charger()
var derniere_position_monde : Vector2 = Vector2(128, 192)
var derniere_position_foret : Vector2 = Vector2(100, 324)
