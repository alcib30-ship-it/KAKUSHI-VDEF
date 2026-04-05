# scripts/MenuJoueur.gd
extends CanvasLayer

var onglet_actuel : String = "compagnons"
var sous_onglet_inventaire : String = "cles"
var sous_onglet_memoires : String = "actives"
var visible_menu : bool = false

var zone_contenu : VBoxContainer

func _ready() -> void:
	_construire_ui()
	visible = false

func _construire_ui() -> void:
	var fond = ColorRect.new()
	fond.set_anchors_preset(Control.PRESET_FULL_RECT)
	fond.color = Color(0.06, 0.04, 0.08, 0.95)
	$Fond.add_child(fond)

	var conteneur = VBoxContainer.new()
	conteneur.set_anchors_preset(Control.PRESET_FULL_RECT)
	conteneur.add_theme_constant_override("separation", 0)
	$Fond.add_child(conteneur)

	var entete = _creer_label("— LIVRE DU TISSEUR —", 22, Color(0.8, 0.65, 0.2))
	entete.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	entete.custom_minimum_size = Vector2(0, 44)
	conteneur.add_child(entete)

	var onglets = HBoxContainer.new()
	onglets.alignment = BoxContainer.ALIGNMENT_CENTER
	onglets.custom_minimum_size = Vector2(0, 44)
	conteneur.add_child(onglets)

	var noms_onglets = {
		"compagnons": "Compagnons",
		"lien":       "Lien",
		"inventaire": "Inventaire",
		"memoires":   "Mémoires",
		"bestiaire":  "Carte des Liens",
	}
	for id in noms_onglets:
		var btn = Button.new()
		btn.text = noms_onglets[id]
		btn.custom_minimum_size = Vector2(160, 40)
		btn.pressed.connect(func(): _changer_onglet(id))
		onglets.add_child(btn)

	var sep = HSeparator.new()
	conteneur.add_child(sep)

	var scroll = ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	conteneur.add_child(scroll)

	zone_contenu = VBoxContainer.new()
	zone_contenu.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	zone_contenu.add_theme_constant_override("separation", 10)
	zone_contenu.custom_minimum_size = Vector2(1100, 0)
	scroll.add_child(zone_contenu)

	var pied = _creer_label("[ M ] Fermer le carnet", 15, Color(0.4, 0.4, 0.4))
	pied.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	pied.custom_minimum_size = Vector2(0, 32)
	conteneur.add_child(pied)

# ═══════════════════════════════════════════════
# NAVIGATION
# ═══════════════════════════════════════════════
func _changer_onglet(id: String) -> void:
	onglet_actuel = id
	_rafraichir_contenu()

func _rafraichir_contenu() -> void:
	for child in zone_contenu.get_children():
		child.queue_free()
	match onglet_actuel:
		"compagnons":  _afficher_compagnons()
		"lien":        _afficher_lien()
		"inventaire":  _afficher_inventaire()
		"memoires":    _afficher_memoires()
		"bestiaire":   _afficher_bestiaire()

# ═══════════════════════════════════════════════
# ONGLET 1 — COMPAGNONS
# ═══════════════════════════════════════════════
func _afficher_compagnons() -> void:
	_titre("Compagnons")
	if Global.starter_choisi == "":
		_ligne("Aucun Lien créé pour l'instant.", Color(0.6, 0.6, 0.6))
		_ligne("Entre dans la forêt de Bernis-Kawa.", Color(0.5, 0.7, 0.5))
		return
	var kdata = WorldData.KAKUSHI.get(Global.starter_choisi, {})
	var lore  = WorldData.KAKUSHI_LORE.get(Global.starter_choisi, {})
	_sous_titre("Actif — " + Global.starter_choisi.capitalize())
	_ligne("Rareté : " + _rarete_str(kdata.get("rarete", "")), kdata.get("couleur_particules", Color.WHITE))
	_ligne("Tempérament : " + kdata.get("comportement", "?").capitalize(), Color.WHITE)
	_ligne("Fiabilité du Lien : " + str(snappedf(Global.fiabilite, 0.01)) + " — " + _label_fiabilite(), _couleur_fiabilite())
	_ligne("État : " + _statut_emotionnel(), Color(0.8, 0.8, 0.5))
	_separateur()
	var historique = lore.get("historique", [])
	if historique.size() > 0:
		_sous_titre("Souvenirs")
		for moment in historique:
			_ligne("• " + moment, Color(0.7, 0.7, 0.8))
	else:
		_ligne("Aucun souvenir encore. Vis des aventures.", Color(0.5, 0.5, 0.5))
	_separateur()
	_ligne("Condition d'échange : Lien >= 0.2 + Kakushi non KO", Color(0.5, 0.5, 0.5))

func _statut_emotionnel() -> String:
	if Global.fiabilite >= 1.6: return "En confiance"
	if Global.fiabilite >= 1.0: return "Serein"
	if Global.fiabilite >= 0.6: return "Agité"
	return "Fatigué"

# ═══════════════════════════════════════════════
# ONGLET 2 — LIEN
# ═══════════════════════════════════════════════
func _afficher_lien() -> void:
	_titre("Le Lien")
	if Global.starter_choisi == "":
		_ligne("Aucun Lien actif.", Color(0.6, 0.6, 0.6))
		return
	var spirale = _creer_spirale_lien()
	zone_contenu.add_child(spirale)
	var pct = int((Global.fiabilite / 2.0) * 100)
	_ligne(str(pct) + "% — " + _label_fiabilite(), _couleur_fiabilite())
	_separateur()
	_sous_titre("Paliers du Lien")
	var paliers = [
		{"seuil": 0.2,  "label": "Lien Naissant",  "desc": "Le Lien existe. Il est fragile."},
		{"seuil": 0.5,  "label": "Lien Etabli",    "desc": "Il te reconnait. Il te suit volontiers."},
		{"seuil": 1.0,  "label": "Lien Stable",    "desc": "Confiance mutuelle. Premiere evolution possible."},
		{"seuil": 1.5,  "label": "Lien Fort",      "desc": "Resonance active. Deuxieme evolution possible."},
		{"seuil": 2.0,  "label": "Lien Parfait",   "desc": "Troisieme evolution. Capacite ultime debloquee."},
	]
	for palier in paliers:
		var atteint = Global.fiabilite >= palier["seuil"]
		var couleur = Color(0.3, 0.9, 0.3) if atteint else Color(0.4, 0.4, 0.4)
		var prefixe = "✓ " if atteint else "○ "
		_ligne(prefixe + palier["label"] + " (" + str(palier["seuil"]) + ")", couleur)
		_ligne("  " + palier["desc"], Color(0.6, 0.6, 0.6))
	_separateur()
	_sous_titre("Resonances actives")
	_ligne("Aucune resonance active — systeme disponible au Ch.2.", Color(0.5, 0.5, 0.5))
	_separateur()
	_sous_titre("Comment progresser")
	_ligne("Rester immobile face a un Kakushi  →  +Fiabilite", Color(0.5, 0.8, 0.5))
	_ligne("Gagner un combat avec ton Kakushi   →  +Fiabilite", Color(0.5, 0.8, 0.5))
	_ligne("Fuir ou refuser un Kakushi          →  -Fiabilite", Color(0.8, 0.4, 0.4))

func _creer_spirale_lien() -> Control:
	var ctrl = Control.new()
	ctrl.custom_minimum_size = Vector2(1100, 120)
	ctrl.draw.connect(func():
		var centre = Vector2(ctrl.size.x / 2.0, 60)
		var rayon  = 50.0
		var angle_max = Global.fiabilite / 2.0 * TAU
		ctrl.draw_arc(centre, rayon, 0, TAU, 64, Color(0.2, 0.2, 0.2), 6.0)
		if angle_max > 0:
			ctrl.draw_arc(centre, rayon, -PI / 2.0, -PI / 2.0 + angle_max, 64, _couleur_fiabilite(), 6.0)
		ctrl.draw_circle(centre, 6.0, _couleur_fiabilite())
	)
	return ctrl

# ═══════════════════════════════════════════════
# ONGLET 3 — INVENTAIRE
# ═══════════════════════════════════════════════
func _afficher_inventaire() -> void:
	_titre("Inventaire")
	var sous_onglets = HBoxContainer.new()
	sous_onglets.alignment = BoxContainer.ALIGNMENT_CENTER
	zone_contenu.add_child(sous_onglets)
	var sections = {
		"cles":      "Cles",
		"potions":   "Soins",
		"cristaux":  "Cristaux",
		"fragments": "Fragments",
		"artefacts": "Artefacts",
	}
	for id in sections:
		var btn = Button.new()
		btn.text = sections[id]
		btn.custom_minimum_size = Vector2(120, 36)
		btn.pressed.connect(func(): _changer_sous_inventaire(id))
		sous_onglets.add_child(btn)
	_separateur()
	var zone_sous = VBoxContainer.new()
	zone_sous.name = "ZoneSousInventaire"
	zone_sous.add_theme_constant_override("separation", 10)
	zone_contenu.add_child(zone_sous)
	_afficher_sous_inventaire()

func _changer_sous_inventaire(id: String) -> void:
	sous_onglet_inventaire = id
	var zone_sous = zone_contenu.get_node_or_null("ZoneSousInventaire")
	if zone_sous:
		for child in zone_sous.get_children():
			child.free()
		_afficher_sous_inventaire()

func _afficher_sous_inventaire() -> void:
	var zone = zone_contenu.get_node_or_null("ZoneSousInventaire")
	if not zone:
		return
	match sous_onglet_inventaire:
		"cles":
			_ligne_dans("Objets Cles", zone, 18, Color(0.7, 0.6, 0.9))
			if Global.a_lettre_jirou:
				_ligne_dans("Lettre cachetee — De : Jirou", zone, 16, Color(0.8, 0.65, 0.2))
				_ligne_dans("  Donne ca a Akemi. Elle sait qui je suis.", zone, 16, Color(0.6, 0.6, 0.6))
			else:
				_ligne_dans("Aucun objet cle pour l'instant.", zone, 16, Color(0.5, 0.5, 0.5))
		"potions":
			_ligne_dans("Soins", zone, 18, Color(0.7, 0.6, 0.9))
			if Global.a_potions > 0:
				_ligne_dans("Potion  x" + str(Global.a_potions), zone, 16, Color(0.4, 0.8, 0.9))
				_ligne_dans("  Restaure les PV de ton Kakushi en combat.", zone, 16, Color(0.6, 0.6, 0.6))
			else:
				_ligne_dans("Aucune potion.", zone, 16, Color(0.5, 0.5, 0.5))
		"cristaux":
			_ligne_dans("Cristaux d'Eclat", zone, 18, Color(0.7, 0.6, 0.9))
			_ligne_dans("Systeme disponible au Chapitre 2.", zone, 16, Color(0.5, 0.5, 0.5))
		"fragments":
			_ligne_dans("Fragments de Resonance", zone, 18, Color(0.7, 0.6, 0.9))
			_ligne_dans("Systeme disponible au Chapitre 2.", zone, 16, Color(0.5, 0.5, 0.5))
		"artefacts":
			_ligne_dans("Artefacts", zone, 18, Color(0.7, 0.6, 0.9))
			_ligne_dans("Le cristal de la chambre de pierre.", zone, 16, Color(0.7, 0.5, 1.0))
			_ligne_dans("  Une chaleur etrange. Comme si quelque chose se reveillait.", zone, 16, Color(0.6, 0.6, 0.6))

# ═══════════════════════════════════════════════
# ONGLET 4 — MEMOIRES
# ═══════════════════════════════════════════════
func _afficher_memoires() -> void:
	_titre("Memoires")
	var sous_onglets = HBoxContainer.new()
	sous_onglets.alignment = BoxContainer.ALIGNMENT_CENTER
	zone_contenu.add_child(sous_onglets)
	var sections = {
		"actives":   "Quetes actives",
		"passees":   "Souvenirs",
		"fragments": "Fragments de la Chute",
	}
	for id in sections:
		var btn = Button.new()
		btn.text = sections[id]
		btn.custom_minimum_size = Vector2(200, 36)
		btn.pressed.connect(func(): _changer_sous_memoires(id))
		sous_onglets.add_child(btn)
	_separateur()
	var zone_sous = VBoxContainer.new()
	zone_sous.name = "ZoneSousMemoires"
	zone_sous.add_theme_constant_override("separation", 10)
	zone_contenu.add_child(zone_sous)
	_afficher_sous_memoires()

func _changer_sous_memoires(id: String) -> void:
	sous_onglet_memoires = id
	var zone_sous = zone_contenu.get_node_or_null("ZoneSousMemoires")
	if zone_sous:
		for child in zone_sous.get_children():
			child.free()
		_afficher_sous_memoires()

func _afficher_sous_memoires() -> void:
	var zone = zone_contenu.get_node_or_null("ZoneSousMemoires")
	if not zone:
		return
	match sous_onglet_memoires:
		"actives":
			_ligne_dans("Quetes actives", zone, 18, Color(0.7, 0.6, 0.9))
			_afficher_quetes_dans(zone)
		"passees":
			_ligne_dans("Souvenirs de Ren", zone, 18, Color(0.7, 0.6, 0.9))
			_afficher_souvenirs_dans(zone)
		"fragments":
			_ligne_dans("Fragments de la Chute", zone, 18, Color(0.7, 0.6, 0.9))
			_afficher_fragments_dans(zone)

func _afficher_quetes_dans(zone: VBoxContainer) -> void:
	var etape = StoryManager.etape_actuelle
	if etape < StoryManager.Etape.JIROU_VU:
		_ligne_dans("Explore le village de Bernis-Kawa.", zone, 16, Color(0.8, 0.8, 0.5))
		_ligne_dans("  Derniere piste : Tu vas a l'ecole ?", zone, 16, Color(0.5, 0.5, 0.5))
	elif etape < StoryManager.Etape.LIEN_CREE:
		_ligne_dans("Entre dans la foret de Bernis-Kawa.", zone, 16, Color(0.8, 0.8, 0.5))
		_ligne_dans("  Derniere piste : Reste immobile. Laisse-le venir.", zone, 16, Color(0.5, 0.5, 0.5))
	elif etape < StoryManager.Etape.COMBAT_GAGNE:
		_ligne_dans("Quelque chose bloque le passage vers l'ecole.", zone, 16, Color(0.8, 0.8, 0.5))
		_ligne_dans("  Derniere piste : Embrix bloque le chemin.", zone, 16, Color(0.5, 0.5, 0.5))
	elif etape < StoryManager.Etape.ECOLE_VUE:
		_ligne_dans("Rejoins l'ecole par la foret.", zone, 16, Color(0.8, 0.8, 0.5))
		_ligne_dans("  Derniere piste : Le passage est libre.", zone, 16, Color(0.5, 0.5, 0.5))
	elif etape < StoryManager.Etape.YAMOTO_VU:
		_ligne_dans("Va voir Yamoto au port.", zone, 16, Color(0.8, 0.8, 0.5))
		_ligne_dans("  Derniere piste : Va voir Yamoto. Il t'expliquera.", zone, 16, Color(0.5, 0.5, 0.5))
	elif etape < StoryManager.Etape.BALISE_ACTIVEE:
		_ligne_dans("Trouve la Balise de l'Eclat dans la foret.", zone, 16, Color(0.8, 0.8, 0.5))
		_ligne_dans("  Derniere piste : La salamandre gardait une Balise.", zone, 16, Color(0.5, 0.5, 0.5))
	elif etape < StoryManager.Etape.CHAPITRE_1_TERMINE:
		_ligne_dans("Prepare ton depart.", zone, 16, Color(0.8, 0.8, 0.5))
		_ligne_dans("  Derniere piste : Les reponses sont ailleurs.", zone, 16, Color(0.5, 0.5, 0.5))
	else:
		_ligne_dans("Chapitre 1 termine. La route s'ouvre.", zone, 16, Color(0.5, 0.9, 0.5))

func _afficher_souvenirs_dans(zone: VBoxContainer) -> void:
	var souvenirs = [
		{"etape": StoryManager.Etape.JIROU_VU,           "texte": "Jirou m'a dit de rester immobile si quelque chose me regardait sans fuir."},
		{"etape": StoryManager.Etape.MAISON_VUE,         "texte": "Le carnet de maman etait sur la table. Papa est reparti sans un mot de plus."},
		{"etape": StoryManager.Etape.LIEN_CREE,          "texte": "Il m'a choisi. Pas moi. Je suis reste immobile et quelque chose s'est cree."},
		{"etape": StoryManager.Etape.COMBAT_GAGNE,       "texte": "Embrix a fui. On a fait ca ensemble. Mon premier combat."},
		{"etape": StoryManager.Etape.ECOLE_VUE,          "texte": "Maman savait. Depuis ma naissance. On ne force pas un Lien."},
		{"etape": StoryManager.Etape.YAMOTO_VU,          "texte": "Yamoto : tu connais quelqu'un qui t'a choisi en te connaissant d'abord ?"},
		{"etape": StoryManager.Etape.BALISE_ACTIVEE,     "texte": "La pierre s'est eteinte. Parfois c'est une reponse. Une reponse a quoi ?"},
		{"etape": StoryManager.Etape.CONSORTIUM_VU,      "texte": "Ces gens ne recensent pas. Ils prennent. Je m'en souviendrai."},
		{"etape": StoryManager.Etape.CHAPITRE_1_TERMINE, "texte": "Ce matin j'etais personne. Ce soir je suis Tisseur."},
	]
	var a_souvenirs = false
	for s in souvenirs:
		if StoryManager.est_a_partir_de(s["etape"]):
			_ligne_dans("• " + s["texte"], zone, 16, Color(0.85, 0.85, 0.9))
			a_souvenirs = true
	if not a_souvenirs:
		_ligne_dans("Aucun souvenir encore.", zone, 16, Color(0.5, 0.5, 0.5))

func _afficher_fragments_dans(zone: VBoxContainer) -> void:
	var fragments = WorldData.FRAGMENTS_BALISE
	var trouves = 0
	for i in range(1, 8):
		var texte = fragments.get(i, "")
		if texte != "":
			trouves += 1
			_ligne_dans("Fragment " + str(i) + "/7", zone, 16, Color(0.5, 0.7, 1.0))
			_ligne_dans("  " + texte, zone, 16, Color(0.8, 0.8, 0.9))
		else:
			_ligne_dans("Fragment " + str(i) + "/7 — Non decouvert", zone, 16, Color(0.3, 0.3, 0.3))
	if trouves == 7:
		_ligne_dans("La verite sur la Kakusei-sei se revele...", zone, 16, Color(0.8, 0.65, 0.2))

# ═══════════════════════════════════════════════
# ONGLET 5 — CARTE DES LIENS
# ═══════════════════════════════════════════════
func _afficher_bestiaire() -> void:
	_titre("Carte des Liens")
	_ligne("Filtre par element — disponible au Ch.2", Color(0.4, 0.4, 0.4))
	_separateur()
	var tous = ["kitsufi", "ondrak", "moshu", "zappiko", "kagemi", "ondami", "embrix"]
	for id in tous:
		var kdata = WorldData.KAKUSHI.get(id, {})
		var lore  = WorldData.KAKUSHI_LORE.get(id, {})
		var etat  = _etat_decouverte(id)
		match etat:
			"inconnu":
				_ligne("??? — Inconnu", Color(0.3, 0.3, 0.3))
				_ligne("  Une silhouette apercue. Peut-etre.", Color(0.25, 0.25, 0.25))
			"apercu":
				var couleur = kdata.get("couleur_particules", Color.WHITE)
				_ligne(id.capitalize() + " — Apercu", couleur)
				_ligne("  Rarete : " + _rarete_str(kdata.get("rarete", "")), Color(0.6, 0.6, 0.6))
				_ligne("  Periode : " + kdata.get("periode", "toujours").capitalize(), Color(0.6, 0.6, 0.6))
				_ligne("  [ Artwork a venir ]", Color(0.3, 0.3, 0.3))
			"lie":
				var couleur = kdata.get("couleur_particules", Color.WHITE)
				_ligne(id.capitalize() + " — Lie", couleur)
				_ligne("  Rarete : " + _rarete_str(kdata.get("rarete", "")), Color(0.7, 0.7, 0.7))
				_ligne("  Temperament : " + kdata.get("comportement", "").capitalize(), Color(0.7, 0.7, 0.7))
				_ligne("  Periode : " + kdata.get("periode", "toujours").capitalize(), Color(0.7, 0.7, 0.7))
				var auteur = lore.get("auteur", "")
				var texte  = lore.get("texte", "")
				if texte != "":
					_ligne("  — " + auteur + " : " + texte, Color(0.75, 0.75, 0.85))
		_separateur()

func _etat_decouverte(id: String) -> String:
	if Global.starter_choisi == id:
		return "lie"
	if id == "ondami" and StoryManager.est_a_partir_de(StoryManager.Etape.ROUTE1_DEBLOQUEE):
		return "apercu"
	if id == "embrix" and StoryManager.est_a_partir_de(StoryManager.Etape.COMBAT_GAGNE):
		return "apercu"
	var starters_foret = ["kitsufi", "ondrak", "moshu", "zappiko", "kagemi"]
	if id in starters_foret and StoryManager.est_a_partir_de(StoryManager.Etape.FORET_ENTREE):
		return "apercu"
	return "inconnu"

# ═══════════════════════════════════════════════
# HELPERS
# ═══════════════════════════════════════════════
func _label_fiabilite() -> String:
	if Global.fiabilite >= 1.8: return "Lien Parfait"
	if Global.fiabilite >= 1.4: return "Lien Fort"
	if Global.fiabilite >= 1.0: return "Lien Stable"
	if Global.fiabilite >= 0.6: return "Lien Fragile"
	return "Lien Brise"

func _couleur_fiabilite() -> Color:
	if Global.fiabilite >= 1.4: return Color(0.3, 0.9, 0.3)
	if Global.fiabilite >= 1.0: return Color(0.8, 0.65, 0.2)
	if Global.fiabilite >= 0.6: return Color(0.9, 0.5, 0.2)
	return Color(0.9, 0.2, 0.2)

func _rarete_str(rarete: String) -> String:
	match rarete:
		"commun":      return "Commun"
		"peu_commun":  return "Peu commun"
		"rare":        return "Rare"
		"legendaire":  return "Legendaire"
		_:             return rarete.capitalize()

func _creer_label(texte: String, taille: int, couleur: Color) -> Label:
	var l = Label.new()
	l.text = texte
	l.add_theme_color_override("font_color", couleur)
	l.add_theme_font_size_override("font_size", taille)
	return l

func _titre(texte: String) -> void:
	var l = _creer_label(texte, 22, Color(0.8, 0.65, 0.2))
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	zone_contenu.add_child(l)

func _sous_titre(texte: String) -> void:
	zone_contenu.add_child(_creer_label(texte, 18, Color(0.7, 0.6, 0.9)))

func _ligne(texte: String, couleur: Color = Color.WHITE) -> void:
	var l = _creer_label(texte, 16, couleur)
	l.autowrap_mode = TextServer.AUTOWRAP_WORD
	l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	zone_contenu.add_child(l)

func _ligne_dans(texte: String, zone: VBoxContainer, taille: int = 16, couleur: Color = Color.WHITE) -> void:
	var l = _creer_label(texte, taille, couleur)
	l.autowrap_mode = TextServer.AUTOWRAP_WORD
	l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	zone.add_child(l)

func _separateur() -> void:
	var sep = HSeparator.new()
	sep.custom_minimum_size = Vector2(0, 8)
	zone_contenu.add_child(sep)

func _unhandled_input(event) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_M or event.keycode == KEY_ESCAPE:
			basculer()

func basculer() -> void:
	visible_menu = not visible_menu
	visible = visible_menu
	if visible_menu:
		_rafraichir_contenu()
