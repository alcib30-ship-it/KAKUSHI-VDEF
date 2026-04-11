# scripts/BattleScene.gd
extends Node2D

# ─── ÉTAT DU COMBAT ────────────────────────────
var joueur : Dictionary = {}
var ennemi : Dictionary = {}
var combat_termine        : bool = false
var en_attente_joueur     : bool = false
var esquive_preparee      : bool = false
var attaques_joueur       : Array = []
var actions_consecutives_joueur : int = 0
var actions_consecutives_ennemi : int = 0

# ─── NŒUDS UI ──────────────────────────────────
@onready var ennemi_pv_bar    = $UI/ZoneHaut/PanneauEnnemi/EnnemiPV
@onready var ennemi_atb_bar   = $UI/ZoneHaut/PanneauEnnemi/EnnemiATB
@onready var ennemi_etat      = $UI/ZoneHaut/PanneauEnnemi/EtatEnnemi
@onready var ennemi_nom_label = $UI/ZoneHaut/PanneauEnnemi/EnnemiNom
@onready var joueur_pv_bar    = $UI/ZoneBas/PanneauJoueur/JoueurPV
@onready var joueur_atb_bar   = $UI/ZoneBas/PanneauJoueur/JoueurATB
@onready var joueur_je_bar    = $UI/ZoneBas/PanneauJoueur/JoueurJE
@onready var joueur_etat      = $UI/ZoneBas/PanneauJoueur/EtatJoueur
@onready var starter_nom      = $UI/ZoneBas/PanneauJoueur/StarterNom
@onready var battle_log       = $UI/ZoneBas/BattleLog
@onready var btn_combat       = $UI/ZoneBas/Boutons/BtnCombat
@onready var btn_inventaire   = $UI/ZoneBas/Boutons/BtnInventaire
@onready var btn_fuir         = $UI/ZoneBas/Boutons/BtnFuir
@onready var sous_menu_combat = $UI/ZoneBas/SousMenuCombat
@onready var sous_menu_inv    = $UI/ZoneBas/SousMenuInventaire

# ─── INIT ──────────────────────────────────────
func _ready() -> void:
	joueur = _charger_stats(Global.starter_choisi)
	ennemi = _charger_stats("embrix")
	ennemi["nom"] = "Embrix"

	starter_nom.text      = Global.starter_choisi.capitalize()
	ennemi_nom_label.text = "Embrix"

	ennemi_pv_bar.max_value = ennemi["pv_max"]
	joueur_pv_bar.max_value = joueur["pv_max"]
	joueur_je_bar.max_value = joueur["je_max"]

	attaques_joueur = WorldData.KAKUSHI_STATS[Global.starter_choisi]["attaques"]
	_generer_sous_menu_combat()

	btn_combat.pressed.connect(_ouvrir_combat)
	btn_inventaire.pressed.connect(_ouvrir_inventaire)
	btn_fuir.pressed.connect(_action_fuir)

	_fermer_sous_menus()
	_desactiver_boutons()
	battle_log.text = WorldData.DIALOGUES_COMBAT["intro_embrix"]
	maj_barres()
	await get_tree().create_timer(1.5).timeout
	DialogueManager.show_dialogue(WorldData.DIALOGUES["embrix_avant"], Callable())

func _charger_stats(id: String) -> Dictionary:
	var base = WorldData.KAKUSHI_STATS[id].duplicate(true)
	var lien  = Global.fiabilite
	var bonus = base.get("bonus_lien", {})
	for stat in ["pv", "atk", "def", "spd"]:
		if stat in bonus:
			base[stat] = int(base[stat] * (1.0 + bonus[stat] * lien))
		else:
			base[stat] = int(base[stat] * (1.0 + 0.10 * lien))
	base["pv_max"] = base["pv"]
	base["je"]     = base["je_max"]
	base["tempo"]  = 0.0
	base["etats"]  = []
	base["immunite_court_circuit"] = 0
	base["nom"]    = id.capitalize()
	base["id"]     = id
	return base

func _generer_sous_menu_combat() -> void:
	for child in sous_menu_combat.get_children():
		child.queue_free()

	# Attaques depuis WorldData
	for att_id in attaques_joueur:
		var att = WorldData.ATTAQUES[att_id]
		if att["type"] == "recharge":
			continue  # Canaliser ajouté séparément en bas
		var btn = Button.new()
		var label = att["nom"]
		if att["je"] > 0:
			label += "  " + str(att["je"]) + " JE"
		btn.text = label
		btn.custom_minimum_size = Vector2(220, 40)
		btn.pressed.connect(func(): _action_attaquer(att_id))
		sous_menu_combat.add_child(btn)

	# Bouton Canaliser toujours présent
	var btn_canaliser = Button.new()
	btn_canaliser.text = "Canaliser  +20 JE"
	btn_canaliser.custom_minimum_size = Vector2(220, 40)
	btn_canaliser.pressed.connect(_action_canaliser)
	sous_menu_combat.add_child(btn_canaliser)

	# Bouton Esquive
	var btn_esquive = Button.new()
	btn_esquive.text = "Esquive"
	btn_esquive.custom_minimum_size = Vector2(220, 40)
	btn_esquive.pressed.connect(_action_esquive)
	sous_menu_combat.add_child(btn_esquive)

	# Retour
	var retour = Button.new()
	retour.text = "Retour"
	retour.custom_minimum_size = Vector2(220, 40)
	retour.pressed.connect(_fermer_sous_menus)
	sous_menu_combat.add_child(retour)

# ─── BOUCLE DE COMBAT ──────────────────────────
func _process(delta: float) -> void:
	if combat_termine or en_attente_joueur:
		return

	var spd_j = _spd_effective(joueur)
	var spd_e = _spd_effective(ennemi)

	joueur["tempo"] += (spd_j / 10.0) * delta * 100.0
	ennemi["tempo"]  += (spd_e  / 10.0) * delta * 100.0

	maj_barres()

	# Tour ennemi
	if ennemi["tempo"] >= 100.0:
		ennemi["tempo"] = 0.0
		_appliquer_etats_passifs(ennemi)
		if combat_termine:
			return
		if actions_consecutives_ennemi >= 2:
			actions_consecutives_ennemi = 0
		else:
			_tour_ennemi()

	# Tour joueur
	if joueur["tempo"] >= 100.0 and not en_attente_joueur:
		joueur["tempo"] = 0.0
		joueur["je"] = min(joueur["je_max"], joueur["je"] + 5)
		if Global.fiabilite >= 0.6:
			joueur["je"] = min(joueur["je_max"], joueur["je"] + 3)
		_appliquer_etats_passifs(joueur)
		if combat_termine:
			return
		if actions_consecutives_joueur >= 2:
			actions_consecutives_joueur = 0
		else:
			en_attente_joueur = true
			_activer_boutons()

func _spd_effective(combattant: Dictionary) -> float:
	var spd = float(combattant["spd"])
	for etat in combattant["etats"]:
		match WorldData.ALTERATIONS[etat["id"]]["effet"]:
			"spd_div2":             spd *= 0.5
			"def_plus25_spd_div2":  spd *= 0.5
			"tempo_aleatoire":      spd += randf_range(-20.0, 20.0)
	return max(1.0, spd)

# ─── NAVIGATION MENUS ──────────────────────────
func _ouvrir_combat() -> void:
	if not en_attente_joueur:
		return
	sous_menu_combat.visible = true
	sous_menu_inv.visible    = false

func _ouvrir_inventaire() -> void:
	if not en_attente_joueur:
		return
	sous_menu_inv.visible    = true
	sous_menu_combat.visible = false
	for child in sous_menu_inv.get_children():
		child.queue_free()
	var btn_potion = Button.new()
	btn_potion.text     = "Potion  x" + str(Global.a_potions)
	btn_potion.disabled = Global.a_potions <= 0
	btn_potion.custom_minimum_size = Vector2(220, 40)
	btn_potion.pressed.connect(_action_objet)
	sous_menu_inv.add_child(btn_potion)
	var retour = Button.new()
	retour.text = "Retour"
	retour.custom_minimum_size = Vector2(220, 40)
	retour.pressed.connect(_fermer_sous_menus)
	sous_menu_inv.add_child(retour)

func _fermer_sous_menus() -> void:
	sous_menu_combat.visible = false
	sous_menu_inv.visible    = false

# ─── ACTIONS JOUEUR ────────────────────────────
func _action_attaquer(att_id: String) -> void:
	if not en_attente_joueur or combat_termine:
		return
	var att = WorldData.ATTAQUES[att_id]

	if joueur["je"] < att["je"]:
		battle_log.text = WorldData.DIALOGUES_COMBAT["je_vide"]
		return

	en_attente_joueur = false
	_desactiver_boutons()
	_fermer_sous_menus()
	actions_consecutives_joueur += 1
	actions_consecutives_ennemi  = 0

	joueur["je"] -= att["je"]

	if att["type"] == "statut":
		_appliquer_alteration(ennemi, att)
		battle_log.text = att["nom"] + " !"
		maj_barres()
		_verifier_fin()
		return

	if _tenter_esquive(ennemi, att):
		battle_log.text = "Embrix " + WorldData.DIALOGUES_COMBAT["esquive_reussie"]
		maj_barres()
		return

	var degats = _calculer_degats(joueur, ennemi, att)
	ennemi["pv"] = max(0, ennemi["pv"] - degats)

	var multi = WorldData.TYPE_TABLE[att["element"]][ennemi["element"]]
	var msg   = att["nom"] + " — " + str(degats) + " degats."
	if multi >= 2.0:    msg += "  " + WorldData.DIALOGUES_COMBAT["super_efficace"]
	elif multi <= 0.0:  msg  = att["nom"] + " — " + WorldData.DIALOGUES_COMBAT["immunite"]
	elif multi < 1.0:   msg += "  " + WorldData.DIALOGUES_COMBAT["peu_efficace"]
	battle_log.text = msg

	_tenter_alteration(ennemi, att)
	maj_barres()
	_verifier_fin()

func _action_canaliser() -> void:
	if not en_attente_joueur or combat_termine:
		return
	en_attente_joueur = false
	_desactiver_boutons()
	_fermer_sous_menus()
	joueur["je"] = min(joueur["je_max"], joueur["je"] + 20)
	battle_log.text = joueur["nom"] + " — " + WorldData.DIALOGUES_COMBAT["canaliser"]
	maj_barres()

func _action_esquive() -> void:
	if not en_attente_joueur or combat_termine:
		return
	en_attente_joueur = false
	_desactiver_boutons()
	_fermer_sous_menus()
	esquive_preparee = true
	battle_log.text = joueur["nom"] + " se prepare a esquiver."

func _action_objet() -> void:
	if not en_attente_joueur or combat_termine:
		return
	if Global.a_potions <= 0:
		battle_log.text = "Aucune potion disponible."
		return
	var a_resonance = _a_etat(joueur, "resonance_inversee")
	if a_resonance:
		var degats_soin = 20
		joueur["pv"] = max(0, joueur["pv"] - degats_soin)
		battle_log.text = WorldData.DIALOGUES_COMBAT["alt_resonance_inversee"]
	else:
		joueur["pv"] = min(joueur["pv_max"], joueur["pv"] + 20)
		battle_log.text = "Potion utilisee. +20 PV."
	Global.a_potions -= 1
	en_attente_joueur = false
	_desactiver_boutons()
	_fermer_sous_menus()
	maj_barres()
	_verifier_fin()

func _action_fuir() -> void:
	if not en_attente_joueur or combat_termine:
		return
	# Fuite impossible contre Embrix boss
	battle_log.text = WorldData.DIALOGUES_COMBAT["fuite_echouee"]
	_fermer_sous_menus()

# ─── TOUR ENNEMI ───────────────────────────────
func _tour_ennemi() -> void:
	actions_consecutives_ennemi += 1
	actions_consecutives_joueur  = 0

	var att_ids = WorldData.KAKUSHI_STATS["embrix"]["attaques"]
	var att_id  = att_ids[randi() % att_ids.size()]
	var att     = WorldData.ATTAQUES[att_id]

	ennemi["je"] = min(ennemi["je_max"], ennemi["je"] + 5)

	if att["type"] == "statut":
		_appliquer_alteration(joueur, att)
		battle_log.text = "Embrix — " + att["nom"] + " !"
		maj_barres()
		return

	if esquive_preparee:
		esquive_preparee = false
		if _tenter_esquive(joueur, att):
			battle_log.text = joueur["nom"] + " " + WorldData.DIALOGUES_COMBAT["esquive_reussie"]
			maj_barres()
			return
		else:
			battle_log.text = WorldData.DIALOGUES_COMBAT["esquive_ratee"]

	var degats = _calculer_degats(ennemi, joueur, att)

	if _a_etat(joueur, "miroir_brise"):
		var retour = int(degats * 0.1)
		ennemi["pv"] = max(0, ennemi["pv"] - retour)

	joueur["pv"] = max(0, joueur["pv"] - degats)
	battle_log.text = "Embrix — " + att["nom"] + " — " + str(degats) + " degats."
	_tenter_alteration(joueur, att)
	maj_barres()
	_verifier_fin()

# ─── FORMULES ──────────────────────────────────
func _calculer_degats(att: Dictionary, def: Dictionary, attaque: Dictionary) -> int:
	var multi = WorldData.TYPE_TABLE[attaque["element"]][def["element"]]
	if multi == 0.0:
		return 0
	var atk        = float(att["atk"])
	var lien_bonus = 1.0 + (Global.fiabilite * 0.25) if att["id"] == Global.starter_choisi else 1.0
	var degats     = (atk / float(def["def"])) * attaque["puissance"] * multi * lien_bonus * randf_range(0.88, 1.0)
	return int(degats)

func _tenter_esquive(cible: Dictionary, attaque: Dictionary) -> bool:
	var esquivabilite = attaque.get("esquivabilite", 0.0)
	if esquivabilite <= 0.0:
		return false
	if _a_etat(cible, "entrave"):
		esquivabilite *= 0.5
	var spd_ratio = float(cible["spd"]) / 50.0
	var chance    = esquivabilite * spd_ratio * 0.5
	return randf() < chance

func _tenter_alteration(cible: Dictionary, attaque: Dictionary) -> void:
	var alt_id = attaque.get("alteration", "")
	var proba  = attaque.get("proba_alt", 0.0)
	if alt_id == "" or proba == 0.0:
		return
	if randf() > proba:
		return
	if alt_id == "court_circuit":
		if cible["immunite_court_circuit"] > 0:
			cible["immunite_court_circuit"] -= 1
			battle_log.text += "\n" + WorldData.DIALOGUES_COMBAT["immunite_court_circuit"]
			return
		else:
			cible["tempo"] = 0.0
			cible["immunite_court_circuit"] = 2
	_appliquer_alteration(cible, attaque)

func _appliquer_alteration(cible: Dictionary, attaque: Dictionary) -> void:
	var alt_id = attaque.get("alteration", "")
	if alt_id == "" or _a_etat(cible, alt_id):
		return
	var alt = WorldData.ALTERATIONS[alt_id]
	cible["etats"].append({"id": alt_id, "duree": alt["duree"]})
	var cle_msg = "alt_" + alt_id
	if cle_msg in WorldData.DIALOGUES_COMBAT:
		battle_log.text += "\n" + WorldData.DIALOGUES_COMBAT[cle_msg]

func _appliquer_etats_passifs(combattant: Dictionary) -> void:
	var a_supprimer = []
	for etat in combattant["etats"]:
		var alt = WorldData.ALTERATIONS[etat["id"]]
		match alt["effet"]:
			"je_max_50":
				combattant["je"] = min(combattant["je"], 50)
			"je_vide_15":
				combattant["je"] = max(0, combattant["je"] - 15)
		etat["duree"] -= 1
		if etat["duree"] <= 0:
			a_supprimer.append(etat)
			battle_log.text = combattant["nom"] + " — " + WorldData.DIALOGUES_COMBAT["alt_dissipe"]
	for e in a_supprimer:
		combattant["etats"].erase(e)
	if combattant["immunite_court_circuit"] > 0:
		combattant["immunite_court_circuit"] -= 1

func _a_etat(combattant: Dictionary, alt_id: String) -> bool:
	for etat in combattant["etats"]:
		if etat["id"] == alt_id:
			return true
	return false

# ─── FIN DE COMBAT ─────────────────────────────
func _verifier_fin() -> void:
	if ennemi["pv"] <= 0:
		victoire()
	elif joueur["pv"] <= 0:
		defaite()

func victoire() -> void:
	combat_termine = true
	_desactiver_boutons()
	var lignes = WorldData.DIALOGUES_COMBAT.get(Global.combat_dialogue_victoire, [])
	for ligne in lignes:
		battle_log.text = ligne
		await get_tree().create_timer(1.5).timeout
	StoryManager.avancer(StoryManager.Etape.COMBAT_GAGNE)
	Global.spawn_x = Global.derniere_position_foret.x
	Global.spawn_y = Global.derniere_position_foret.y
	Transition.vers_foret()


func defaite() -> void:
	combat_termine = true
	_desactiver_boutons()
	battle_log.text = WorldData.DIALOGUES_COMBAT["defaite_embrix"]
	await get_tree().create_timer(2.0).timeout
	Global.spawn_x = Global.derniere_position_foret.x
	Global.spawn_y = Global.derniere_position_foret.y
	Transition.vers_foret()

# ─── UI ────────────────────────────────────────
func maj_barres() -> void:
	ennemi_pv_bar.value  = ennemi["pv"]
	ennemi_atb_bar.value = ennemi["tempo"]
	joueur_pv_bar.value  = joueur["pv"]
	joueur_atb_bar.value = joueur["tempo"]
	joueur_je_bar.value  = joueur["je"]
	var etats_j = ""
	for e in joueur["etats"]:
		etats_j += WorldData.ALTERATIONS[e["id"]]["label"] + " " + str(e["duree"]) + "t  "
	joueur_etat.text = etats_j
	var etats_e = ""
	for e in ennemi["etats"]:
		etats_e += WorldData.ALTERATIONS[e["id"]]["label"] + " " + str(e["duree"]) + "t  "
	ennemi_etat.text = etats_e

func _activer_boutons() -> void:
	btn_combat.disabled     = false
	btn_inventaire.disabled = false
	btn_fuir.disabled       = false

func _desactiver_boutons() -> void:
	btn_combat.disabled     = true
	btn_inventaire.disabled = true
	btn_fuir.disabled       = true
	_fermer_sous_menus()
