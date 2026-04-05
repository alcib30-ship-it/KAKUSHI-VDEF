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
