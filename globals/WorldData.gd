# globals/WorldData.gd
# AUTOLOAD — Nom : WorldData
# Toutes les données du jeu — PNJ, triggers, dialogues, transitions
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

	# PNJ de décor — dialogues bateau
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
	"route1_bloquee": [
		{"speaker": "", "text": "Un arbre massif barre la route. Il vient de tomber."},
		{"speaker": "", "text": "Impossible de passer par là pour l'instant."},
	],
	"route1_deblocable": [
		{"speaker": "", "text": "Un éboulement bloque la suite. Les pierres sont trop lourdes."},
		{"speaker": "", "text": "Il faudra revenir avec du renfort. ▶ Débloqué au Chapitre 4"},
	],
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
				"condition_extra": "not:BALISE_1_ACTIVEE",
				"avance_etape": "BALISE_ACTIVEE",
				"flag": "balise_1_activee",
			},
			{
				"id": "consortium",
				"type": "dialogue_choix",
				"position": Vector2(700, 575),
				"size": Vector2(48, 48),
				"dialogue_id": "consortium_ch1",
				"condition": "BALISE_ACTIVEE",
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
			{
				"id": "route1_arbre",
				"type": "dialogue",
				"position": Vector2(1600, 300),
				"size": Vector2(32, 64),
				"dialogue_id": "route1_bloquee",
				"condition": "not:ROUTE1_DEBLOQUEE",
				"repeatable": true,
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

	"route1": {
		"pnj": [],
		"triggers": [
			{
				"id": "route1_fin",
				"type": "dialogue",
				"position": Vector2(800, 300),
				"size": Vector2(32, 64),
				"dialogue_id": "route1_deblocable",
				"condition": "",
				"repeatable": true,
			},
		],
	},
}
