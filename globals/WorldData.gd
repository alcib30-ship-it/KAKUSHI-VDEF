# globals/WorldData.gd
extends Node

# ═══════════════════════════════════════════════
# DIALOGUES
# ═══════════════════════════════════════════════
const DIALOGUES = {

	"maison_ren": [
		{"speaker": "",      "text": "La maison de Ren. Simple, chaleureuse."},
		{"speaker": "",      "text": "Sur la table — le carnet de maman."},
		{"speaker": "",      "text": "Elle oublie toujours ses affaires quand elle est pressée."},
		{"speaker": "Père",  "text": "Tu as dormi dehors encore."},
		{"speaker": "Ren",   "text": "..."},
		{"speaker": "Père",  "text": "Fais attention sur la route."},
		{"speaker": "",      "text": "Il repart sans attendre. Une habitude entre eux."},
	],

	"jirou_ch1": [
		{"speaker": "Jirou", "text": "Tu vas à l'école ?"},
		{"speaker": "Ren",   "text": "Apporter le carnet de maman."},
		{"speaker": "Jirou", "text": "Par la forêt ou par la route ?"},
	],

	"jirou_suite": [
		{"speaker": "Jirou", "text": "Si tu croises quelque chose qui te regarde sans fuir... reste immobile. Laisse-le venir à toi."},
		{"speaker": "Ren",   "text": "Pourquoi tu me dis ça ?"},
		{"speaker": "Jirou", "text": "Cette forêt... elle a changé depuis la Chute. Les animaux ordinaires ne regardent plus les humains en face. Mais certains, oui. Ceux-là sont différents."},
		{"speaker": "Ren",   "text": "Différents comment ?"},
		{"speaker": "Jirou", "text": "Quand tu le verras, tu comprendras. Va."},
		{"speaker": "",      "text": "Des choses étranges. Comme d'habitude avec lui."},
	],

	"yamoto_ch1": [
		{"speaker": "Yamoto", "text": "Alors c'est toi."},
		{"speaker": "Ren",    "text": "Ma mère m'a dit de venir vous voir."},
		{"speaker": "Yamoto", "text": "Je sais. Je t'attendais depuis un moment."},
		{"speaker": "Yamoto", "text": "Un Tisseur c'est quelqu'un qui peut créer un Lien avec un Kakushi. Pas les dresser. Pas les capturer. Créer un Lien. C'est différent."},
		{"speaker": "Ren",    "text": "C'est quoi la différence ?"},
		{"speaker": "Yamoto", "text": "La différence c'est que lui... il a choisi. Pas toi."},
		{"speaker": "Ren",    "text": "Il m'a choisi sans me connaître ?"},
		{"speaker": "Yamoto", "text": "Tu connais quelqu'un qui t'a choisi en te connaissant d'abord ?"},
		{"speaker": "Yamoto", "text": "Prends soin de ce Lien. C'est la chose la plus fragile et la plus solide que tu auras jamais."},
		{"speaker": "Yamoto", "text": "La salamandre sur la route de la forêt — elle gardait une Balise de l'Éclat. Des pierres qui soignent. Des pierres qui parlent."},
		{"speaker": "Yamoto", "text": "Certains disent qu'elles racontent l'histoire de la Chute, fragment par fragment."},
		{"speaker": "Yamoto", "text": "Y en a sept. Au cas où tu serais curieux."},
	],

	"balise_1": [
		{"speaker": "", "text": "Une pierre ancienne gravée de symboles pulse d'une lumière bleue."},
		{"speaker": "", "text": "Ren pose la main dessus. Flash bleu. Toute l'équipe soignée. ✨"},
		{"speaker": "", "text": "« La lumière qui tombe n'est pas toujours une catastrophe. Parfois c'est une réponse. — Fragment 1/7 »"},
		{"speaker": "", "text": "Qu'est-ce que ça veut dire."},
		{"speaker": "", "text": "La pierre s'éteint doucement. Elle ne pulsera plus jamais."},
	],

	"consortium_ch1": [
		{"speaker": "Agent", "text": "Inventaire de routine. Le Consortium recense tous les Kakushi de la zone. C'est pour votre sécurité."},
		{"speaker": "Agent", "text": "Intéressant. Un Tisseur. Ton nom ?"},
	],

	"consortium_suite": [
		{"speaker": "Agent", "text": "Joli spécimen. Le Consortium s'intéresse beaucoup aux nouveaux Liens."},
		{"speaker": "Jirou", "text": "Ces gens ne recensent pas. Ils prennent."},
		{"speaker": "",      "text": "Je m'en souviendrai."},
	],

	"depart_ch1": [
		{"speaker": "",      "text": "'Parfois c'est une réponse.' Une réponse à quoi ?"},
		{"speaker": "",      "text": "Il y a d'autres balises. D'autres fragments. Les réponses sont ailleurs."},
		{"speaker": "Mère",  "text": "Tu pars ce soir ?"},
		{"speaker": "Ren",   "text": "Oui."},
		{"speaker": "Mère",  "text": "Des Potions. Pour toi et... pour lui."},
		{"speaker": "Père",  "text": "Fais attention."},
		{"speaker": "",      "text": "Il sait. Il a toujours su."},
		{"speaker": "Jirou", "text": "Donne ça à Akemi. Elle sait qui je suis."},
		{"speaker": "Jirou", "text": "La Chute de la Kakusei-sei... ce n'était pas un accident."},
		{"speaker": "",      "text": "Ce matin j'étais personne. Ce soir je suis Tisseur."},
		{"speaker": "",      "text": "— Chapitre 1 — L'Éveil — Terminé —"},
	],

	"pecheur_01": [
		{"speaker": "Pêcheur", "text": "La mer est calme ce matin. Trop calme."},
	],
	"pecheur_02": [
		{"speaker": "Vieille femme", "text": "Tu ressembles à ton père quand il avait ton âge."},
	],
	"enfant_01": [
		{"speaker": "Enfant", "text": "T'as vu ? Un Kakushi a traversé la place hier soir !"},
	],
	"marchand_01": [
		{"speaker": "Marchand", "text": "Potions, herbes, équipement. Je suis là si t'as besoin."},
	],

	# Route 1
	"route1_bloquee": [
		{"speaker": "", "text": "Un arbre massif barre la route. Il vient de tomber."},
		{"speaker": "", "text": "Impossible de passer par là pour l'instant."},
	],
	"route1_deblocable": [
		{"speaker": "", "text": "Un éboulement bloque la suite. Les pierres sont trop lourdes."},
		{"speaker": "", "text": "Il faudra revenir avec du renfort. ▶ Débloqué au Chapitre 4"},
	],

	# Indices au sol — hints narratifs sur les Kakushi
	"indice_plumes_kagemi": [
		{"speaker": "", "text": "Des plumes noires au sol. Légères, presque translucides."},
		{"speaker": "Ren", "text": "Une créature nocturne rôde ici. Elle doit revenir la nuit."},
	],
	"indice_traces_moshu": [
		{"speaker": "", "text": "Des empreintes profondes dans la terre. Un cerf, peut-être. Mais trop grandes."},
		{"speaker": "Ren", "text": "Ça sent les fleurs. Bizarre pour une forêt comme celle-là."},
	],
}

# ═══════════════════════════════════════════════
# KAKUSHI — données complètes pour le système silhouettes
# Sera lu par WorldLoader quand les sprites seront disponibles
# ═══════════════════════════════════════════════
const KAKUSHI = {
	"kitsufi": {
		"rarete": "commun",
		"couleur_particules": Color(0.2, 0.8, 0.2, 1),   # vert
		"comportement": "curieux",   # se déplace vers Ren
		"periode": "toujours",
		"poids": 40,
	},
	"ondrak": {
		"rarete": "commun",
		"couleur_particules": Color(0.2, 0.2, 0.8, 1),   # bleu
		"comportement": "mefiant",   # s'éloigne si Ren court
		"periode": "toujours",
		"poids": 30,
	},
	"moshu": {
		"rarete": "peu_commun",
		"couleur_particules": Color(0.2, 0.5, 0.8, 1),   # bleu
		"comportement": "mefiant",
		"periode": "toujours",
		"poids": 20,
	},
	"zappiko": {
		"rarete": "peu_commun",
		"couleur_particules": Color(0.2, 0.5, 0.8, 1),   # bleu
		"comportement": "curieux",
		"periode": "toujours",
		"poids": 8,
	},
	"kagemi": {
		"rarete": "rare",
		"couleur_particules": Color(1.0, 0.4, 0.7, 1),   # rose
		"comportement": "mefiant",
		"periode": "nuit",           # uniquement 21h-6h réel
		"poids": 2,
	},
	"embrix": {
		"rarete": "legendaire",
		"couleur_particules": Color(1.0, 0.2, 0.2, 1),   # rouge
		"comportement": "agressif",  # fonce sur Ren
		"periode": "toujours",
		"poids": 0,                  # jamais en rencontre aléatoire
	},
	"ondami": {
		"rarete": "rare",
		"couleur_particules": Color(1.0, 0.4, 0.7, 1),
		"comportement": "fuite",
		"periode": "toujours",
		"poids": 0,
		"capturable": false,
	},
}

const FRAGMENTS_BALISE = {
	1: "La lumière qui tombe n'est pas toujours une catastrophe. Parfois c'est une réponse.",
	2: "", 3: "", 4: "", 5: "", 6: "", 7: "",
}

const KAKUSHI_LORE = {
	"kitsufi": {
		"auteur": "Jirou",
		"texte": "Un renard aux queues enflammées. Curieux de nature, il choisit toujours quelqu'un qui n'a pas peur du feu. On dit qu'il teste le courage avant de se laisser approcher.",
		"historique": [],
	},
	"ondrak": {
		"auteur": "Yamoto",
		"texte": "Dragon marin discret. Il ne fait confiance qu'aux patients. J'en ai vu un attendre trois jours immobile avant de créer un Lien. Trois jours.",
		"historique": [],
	},
	"moshu": {
		"auteur": "Yamoto",
		"texte": "Le cerf aux bois fleuris sent les émotions avant que tu les ressentes toi-même. Il ne choisit pas les forts. Il choisit les honnêtes.",
		"historique": [],
	},
	"zappiko": {
		"auteur": "Jirou",
		"texte": "Tanuki électrique, impatient, imprévisible. Si tu restes immobile trop longtemps il s'en va. Il veut quelqu'un qui bouge autant que lui.",
		"historique": [],
	},
	"kagemi": {
		"auteur": "Inconnu",
		"texte": "Personne ne sait qui a écrit cette entrée. Elle était là un matin dans le carnet de Yamoto. Il jure qu'il ne l'a pas écrite.",
		"historique": [],
	},
	"ondami": {
		"auteur": "Jirou",
		"texte": "Une loutre. Rapide. Insaisissable. J'en ai vu une une fois, sur la Route 1. Elle m'a regardé exactement deux secondes puis elle a disparu. Je ne l'ai jamais revue.",
		"historique": [],
	},
	"embrix": {
		"auteur": "Yamoto",
		"texte": "Embrix ne crée pas de Lien. Il teste. Si tu le bats, il te respecte. Si tu fuis, il te méprise. Et il s'en souvient.",
		"historique": [],
	},
}
# ═══════════════════════════════════════════════
# SCÈNES
# ═══════════════════════════════════════════════
const SCENES = {

	"monde": {
		"pnj": [
			{
				"id": "jirou",
				"sprite": "jirou",
				"position": Vector2(336, 640),
				"dialogue_id": "jirou_ch1",
				"condition": "",
				"has_choix": true,
				"choix_texte": "Par la route, c'est plus court. (O) — Par la forêt, c'est plus beau. (N)",
				"on_oui": "jirou_route",
				"on_non": "jirou_foret",
				"suite_dialogue_id": "jirou_suite",
				"avance_etape": "JIROU_VU",
			},
			{
				"id": "yamoto",
				"sprite": "yamoto",
				"position": Vector2(80, 976),
				"dialogue_id": "yamoto_ch1",
				"condition": "ECOLE_VUE",
				"avance_etape": "YAMOTO_VU",
			},
			{
				"id": "pecheur_nord",
				"sprite": "pecheur",
				"position": Vector2(200, 900),
				"dialogue_id": "pecheur_01",
				"condition": "",
				"repeatable": true,
			},
			{
				"id": "vieille_femme",
				"sprite": "mere",
				"position": Vector2(400, 750),
				"dialogue_id": "pecheur_02",
				"condition": "",
				"repeatable": true,
			},
			{
				"id": "enfant_place",
				"sprite": "enfant",
				"position": Vector2(600, 600),
				"dialogue_id": "enfant_01",
				"condition": "",
				"repeatable": true,
			},
		],
		"triggers": [
			{
				"id": "maison_ren",
				"type": "dialogue",
				"position": Vector2(315, 450),
				"size": Vector2(48, 48),
				"dialogue_id": "maison_ren",
				"condition": "not:MAISON_VUE",
				"avance_etape": "MAISON_VUE",
			},
			{
				"id": "escalier_foret",
				"type": "transition",
				"position": Vector2(1550, 0),
				"size": Vector2(80, 32),
				"destination": "foret",
				"condition": "not:LIEN_CREE",
				"avance_etape": "FORET_ENTREE",
				"sauvegarde_position": "monde",
			},
			{
				"id": "balise_1",
				"type": "balise",
				"position": Vector2(1550, 325),
				"size": Vector2(48, 48),
				"dialogue_id": "balise_1",
				"condition": "YAMOTO_VU",
				"condition_extra": "not:balise_1_activee",
				"avance_etape": "BALISE_ACTIVEE",
				"flag": "balise_1_activee",
			},
			# Route 1 — débloquée après YAMOTO_VU
			# L'arbre est tombé avant — bloque jusqu'à ce qu'on parle à Yamoto
			{
			   "id": "route1_arbre_bloque",
				"type": "dialogue",
				"position": Vector2(755, 130),
				"size": Vector2(130, 48),
				"dialogue_id": "route1_bloquee",
				"condition": "not:YAMOTO_VU",
				"repeatable": true,
},
{
				"id": "route1_entree",
				"type": "transition",
				"position": Vector2(755, 130),
				"size": Vector2(130, 48),
				"destination": "route1_zone",
				"condition": "YAMOTO_VU",
				"avance_etape": "ROUTE1_DEBLOQUEE",
				"sauvegarde_position": "monde",
},
			# Consortium — apparaît en même temps que la Route 1
			{
				"id": "consortium",
				"type": "dialogue_choix",
				"position": Vector2(700, 575),
				"size": Vector2(48, 48),
				"dialogue_id": "consortium_ch1",
				"condition": "YAMOTO_VU",
				"avance_etape": "CONSORTIUM_VU",
				"choix_texte": "Donner ton nom ? (O) — Refuser. (N)",
				"on_oui": "consortium_nom",
				"on_non": "consortium_refuse",
				"suite_dialogue_id": "consortium_suite",
			},
			{
				"id": "depart",
				"type": "dialogue_fin",
				"position": Vector2(1475, 525),
				"size": Vector2(48, 48),
				"dialogue_id": "depart_ch1",
				"condition": "CONSORTIUM_VU",
				"avance_etape": "CHAPITRE_1_TERMINE",
				"inventaire": {"a_lettre_jirou": true, "a_potions": 3},
			},
		],
		# Route 1 intégrée dans monde — zone accessible depuis monde.tscn
		# WorldLoader instanciera les silhouettes ici quand les sprites seront prêts
		"kakushi_zones": [
			{
				"id": "route1_zone",
				"nom": "Route 1 — Hautes herbes",
				"position": Vector2(1700, 100),
				"size": Vector2(800, 600),
				"texture": "hautes_herbes",
				"kakushi": ["kitsufi", "ondrak", "moshu", "zappiko", "kagemi"],
				"indices": [
					{
						"id": "indice_plumes",
						"type": "indice",
						"position": Vector2(2000, 250),
						"size": Vector2(32, 32),
						"texte": "Des plumes noires au sol. Légères, presque translucides. Une créature nocturne rôde ici la nuit.",
						"repeatable": false,
					},
					{
						"id": "indice_traces",
						"type": "indice",
						"position": Vector2(2200, 400),
						"size": Vector2(32, 32),
						"texte": "Des empreintes profondes dans la terre. Ça sent les fleurs. Bizarre pour une route comme celle-là.",
						"repeatable": false,
					},
				],
				"mur_fin": {
					"id": "route1_fin",
					"type": "dialogue",
					"position": Vector2(2500, 300),
					"size": Vector2(32, 400),
					"dialogue_id": "route1_deblocable",
					"condition": "",
					"repeatable": true,
				},
			},
		],
	},

	"foret": {
		"pnj": [],
		"triggers": [
			{
				"id": "sortie_village",
				"type": "transition",
				"position": Vector2(32, 200),
				"size": Vector2(80, 38),
				"destination": "monde",
				"condition": "",
				"sauvegarde_position": "foret",
			},
			{
				"id": "sortie_ecole",
				"type": "transition",
				"position": Vector2(0, 0),
				"size": Vector2(200, 32),
				"destination": "ecole",
				"condition": "COMBAT_GAGNE",
				"sauvegarde_position": "foret",
			},
		],
	},
}
# ═══════════════════════════════════════════════
# TABLE DES 12 TYPES
# ═══════════════════════════════════════════════
const TYPE_TABLE = {
	"feu":    {"feu":0.5,"eau":0.5,"foudre":1.0,"nature":2.0,"ombre":1.0,"glace":1.0,"terre":1.0,"lune":1.0,"cristal":2.0,"vent":1.0,"plasma":1.0,"spectre":1.0},
	"eau":    {"feu":2.0,"eau":0.5,"foudre":0.5,"nature":1.0,"ombre":1.0,"glace":2.0,"terre":1.0,"lune":1.0,"cristal":1.0,"vent":1.0,"plasma":1.0,"spectre":1.0},
	"foudre": {"feu":1.0,"eau":2.0,"foudre":1.0,"nature":0.5,"ombre":1.0,"glace":1.0,"terre":0.5,"lune":1.0,"cristal":1.0,"vent":2.0,"plasma":1.0,"spectre":1.0},
	"nature": {"feu":0.5,"eau":1.0,"foudre":1.0,"nature":1.0,"ombre":0.5,"glace":1.0,"terre":2.0,"lune":1.0,"cristal":0.5,"vent":1.0,"plasma":1.0,"spectre":1.0},
	"ombre":  {"feu":1.0,"eau":1.0,"foudre":1.0,"nature":0.5,"ombre":0.5,"glace":1.0,"terre":1.0,"lune":2.0,"cristal":1.0,"vent":1.0,"plasma":1.0,"spectre":2.0},
	"glace":  {"feu":0.5,"eau":1.0,"foudre":1.0,"nature":2.0,"ombre":1.0,"glace":0.5,"terre":1.0,"lune":1.0,"cristal":1.0,"vent":2.0,"plasma":1.0,"spectre":1.0},
	"terre":  {"feu":2.0,"eau":1.0,"foudre":0.5,"nature":1.0,"ombre":1.0,"glace":1.0,"terre":0.5,"lune":1.0,"cristal":2.0,"vent":1.0,"plasma":1.0,"spectre":1.0},
	"lune":   {"feu":1.0,"eau":1.0,"foudre":1.0,"nature":1.0,"ombre":2.0,"glace":1.0,"terre":1.0,"lune":0.5,"cristal":1.0,"vent":1.0,"plasma":0.5,"spectre":2.0},
	"cristal":{"feu":0.5,"eau":1.0,"foudre":1.0,"nature":1.0,"ombre":1.0,"glace":2.0,"terre":0.5,"lune":1.0,"cristal":1.0,"vent":2.0,"plasma":1.0,"spectre":1.0},
	"vent":   {"feu":1.0,"eau":1.0,"foudre":0.5,"nature":2.0,"ombre":1.0,"glace":1.0,"terre":1.0,"lune":1.0,"cristal":0.5,"vent":0.5,"plasma":1.0,"spectre":1.0},
	"plasma": {"feu":1.0,"eau":1.0,"foudre":1.0,"nature":1.0,"ombre":1.0,"glace":1.0,"terre":1.0,"lune":2.0,"cristal":2.0,"vent":1.0,"plasma":0.5,"spectre":0.0},
	"spectre":{"feu":1.0,"eau":1.0,"foudre":1.0,"nature":1.0,"ombre":0.5,"glace":1.0,"terre":1.0,"lune":2.0,"cristal":1.0,"vent":1.0,"plasma":0.0,"spectre":0.5},
	"neutre": {"feu":1.0,"eau":1.0,"foudre":1.0,"nature":1.0,"ombre":1.0,"glace":1.0,"terre":1.0,"lune":1.0,"cristal":1.0,"vent":1.0,"plasma":1.0,"spectre":1.0},
}

# ═══════════════════════════════════════════════
# ALTÉRATIONS D'ÉCLAT
# ═══════════════════════════════════════════════
const ALTERATIONS = {
	"surchauffe":        {"label":"Surchauffe",        "source":"feu",    "duree":3, "effet":"je_max_50"},
	"dilution":          {"label":"Dilution",          "source":"eau",    "duree":4, "effet":"cout_je_plus10"},
	"court_circuit":     {"label":"Court-Circuit",     "source":"foudre", "duree":1, "effet":"reset_tempo"},
	"entrave":           {"label":"Entrave",           "source":"nature", "duree":3, "effet":"spd_div2"},
	"miroir_brise":      {"label":"Miroir Brise",      "source":"ombre",  "duree":4, "effet":"reflet_10pct"},
	"cristallisation":   {"label":"Cristallisation",   "source":"glace",  "duree":2, "effet":"def_plus25_spd_div2"},
	"dissipation":       {"label":"Dissipation",       "source":"plasma", "duree":3, "effet":"lien_zero"},
	"resonance_inversee":{"label":"Resonance Inversee","source":"spectre","duree":2, "effet":"soins_degats"},
	"eclat_sature":      {"label":"Eclat Sature",      "source":"lune",   "duree":3, "effet":"je_vide_15"},
	"turbulence":        {"label":"Turbulence",        "source":"vent",   "duree":3, "effet":"tempo_aleatoire"},
}

# ═══════════════════════════════════════════════
# ATTAQUES — Ch.1
# ═══════════════════════════════════════════════
const ATTAQUES = {
	"morsure_braise":   {"nom":"Morsure de Braise", "element":"feu",    "type":"physique","puissance":25,"je":0,  "alteration":"surchauffe",    "proba_alt":0.08, "esquivabilite":0.20},
	"queue_enflammee":  {"nom":"Queue Enflammee",   "element":"feu",    "type":"special", "puissance":35,"je":20, "alteration":"surchauffe",    "proba_alt":0.25, "esquivabilite":0.15},
	"rugissement":      {"nom":"Rugissement",       "element":"neutre", "type":"statut",  "puissance":0, "je":10, "alteration":"",              "proba_alt":0.00, "esquivabilite":0.00},
	"canaliser":        {"nom":"Canaliser",         "element":"neutre", "type":"recharge","puissance":0, "je":0,  "alteration":"",              "proba_alt":0.00, "esquivabilite":0.00},
	"jet_eau":          {"nom":"Jet d'Eau",         "element":"eau",    "type":"physique","puissance":20,"je":0,  "alteration":"dilution",      "proba_alt":0.08, "esquivabilite":0.25},
	"vague_froide":     {"nom":"Vague Froide",      "element":"eau",    "type":"special", "puissance":28,"je":20, "alteration":"dilution",      "proba_alt":0.20, "esquivabilite":0.15},
	"fouet_vegetal":    {"nom":"Fouet Vegetal",     "element":"nature", "type":"physique","puissance":25,"je":0,  "alteration":"entrave",       "proba_alt":0.08, "esquivabilite":0.20},
	"pollen_endormi":   {"nom":"Pollen Endormi",    "element":"nature", "type":"statut",  "puissance":0, "je":20, "alteration":"entrave",       "proba_alt":1.00, "esquivabilite":0.00},
	"eclair_rapide":    {"nom":"Eclair Rapide",     "element":"foudre", "type":"special", "puissance":30,"je":20, "alteration":"court_circuit", "proba_alt":0.20, "esquivabilite":0.30},
	"surcharge":        {"nom":"Surcharge",         "element":"foudre", "type":"special", "puissance":50,"je":35, "alteration":"court_circuit", "proba_alt":0.10, "esquivabilite":0.05},
	"reflet_brise":     {"nom":"Reflet Brise",      "element":"ombre",  "type":"special", "puissance":28,"je":20, "alteration":"miroir_brise",  "proba_alt":0.25, "esquivabilite":0.20},
	"disparition":      {"nom":"Disparition",       "element":"ombre",  "type":"statut",  "puissance":0, "je":15, "alteration":"",              "proba_alt":0.00, "esquivabilite":0.00},
	"crachat_lave":     {"nom":"Crachat de Lave",   "element":"feu",    "type":"special", "puissance":40,"je":0,  "alteration":"surchauffe",    "proba_alt":0.30, "esquivabilite":0.25},
	"charge_volcanique":{"nom":"Charge Volcanique", "element":"feu",    "type":"physique","puissance":45,"je":0,  "alteration":"",              "proba_alt":0.00, "esquivabilite":0.15},
}

# ═══════════════════════════════════════════════
# KAKUSHI_STATS — Ch.1
# ═══════════════════════════════════════════════
const KAKUSHI_STATS = {
	"kitsufi": {
		"pv":45,"atk":52,"def":38,"spd":60,"je_max":100,
		"element":"feu",
		"attaques":["morsure_braise","queue_enflammee","rugissement","canaliser"],
		"bonus_lien":{"atk":0.10,"spd":0.05},
	},
	"ondrak": {
		"pv":50,"atk":40,"def":45,"spd":45,"je_max":100,
		"element":"eau",
		"attaques":["jet_eau","vague_froide","rugissement","canaliser"],
		"bonus_lien":{"def":0.15,"pv":0.05},
	},
	"moshu": {
		"pv":55,"atk":38,"def":50,"spd":40,"je_max":100,
		"element":"nature",
		"attaques":["fouet_vegetal","pollen_endormi","rugissement","canaliser"],
		"bonus_lien":{"pv":0.10,"def":0.10},
	},
	"zappiko": {
		"pv":38,"atk":58,"def":28,"spd":80,"je_max":100,
		"element":"foudre",
		"attaques":["eclair_rapide","surcharge","rugissement","canaliser"],
		"bonus_lien":{"spd":0.20,"atk":0.05},
	},
	"kagemi": {
		"pv":35,"atk":55,"def":32,"spd":70,"je_max":100,
		"element":"ombre",
		"attaques":["reflet_brise","disparition","rugissement","canaliser"],
		"bonus_lien":{"atk":0.15,"spd":0.05},
	},
	"embrix": {
		"pv":38,"atk":58,"def":28,"spd":50,"je_max":100,
		"element":"feu",
		"attaques":["crachat_lave","charge_volcanique","rugissement"],
		"bonus_lien":{},
	},
}

# ═══════════════════════════════════════════════
# DIALOGUES COMBAT
# ═══════════════════════════════════════════════
const DIALOGUES_COMBAT = {
	"intro_sauvage":         "Le kakushi te regarde pour combattre !.",
	"intro_embrix":          "Embrix bloque le passage. Il a l'air agressif.",
	"intro_tisseur":         "Son Kakushi se met en position.",
	"intro_consortium":      "L'Agent sort un Pisto-Lien. Pas pour capturer.",
	"victoire_sauvage":      "Il recule. Vcitoite tu as gagné le combat !",
	"victoire_embrix":       "Embrix s'arrete. Il te regarde une derniere fois. Puis il disparait.",
	"victoire_tisseur":      "Un signe de tete. Respect discret.",
	"victoire_consortium":   "L'Agent range son materiel. Il note quelque chose.",
	"defaite":               "Tu as perdu ce combat, la prochaine sera la bonne !",
	"defaite_embrix":        "Embrix t'a epargné. Pourquoi ?",
	"fuite_reussie":         "Tu as réussi à t'échappe ! Le Lien tremble legerement.",
	"fuite_echouee":         "Impossible de passer. Il te garde en face de lui.",
	"super_efficace":        "Cette attaque fait vraiment mal !",
	"peu_efficace":          "Cette attaque ne fait pas très mal.",
	"immunite":              "Aucun effet. Rien.",
	"je_vide":               "Plus d'Eclat. Attaque de base uniquement.",
	"canaliser":             "L'Eclat se recharge.",
	"esquive_reussie":       "Esquivé de justesse.",
	"esquive_ratee":         "Pas assez rapide.",
	"alt_surchauffe":        "Trop d'Eclat d'un coup. La jauge deborde.",
	"alt_dilution":          "L'Eclat se disperse. Chaque attaque coute plus.",
	"alt_court_circuit":     "Court-circuit. Le Tempo repart de zero.",
	"alt_entrave":           "Les membres refusent. Mouvement reduit.",
	"alt_miroir_brise":      "Ce que tu infliges... tu le ressens aussi.",
	"alt_cristallisation":   "Le froid fige. Defense renforcee. Mais plus rien ne bouge.",
	"alt_dissipation":       "Le Lien s'efface temporairement. Tu es seul.",
	"alt_resonance_inversee":"Quelque chose est inversé. Les soins brulent.",
	"alt_eclat_sature":      "Trop plein. L'Eclat fuit tout seul.",
	"alt_turbulence":        "Le Tempo deraille. Impossible a prevoir.",
	"immunite_court_circuit":"Deja frappé la. Ca ne prend plus.",
	"alt_dissipe":           "L'effet se dissipe.",
	
}
