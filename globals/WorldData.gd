# globals/WorldData.gd

extends Node

# ═══════════════════════════════════════════════
# DIALOGUES
# ═══════════════════════════════════════════════

const DIALOGUES = {

"maison_ren": [
	{"speaker": "", "text": "La maison de Ren. Simple, chaleureuse."},
	{"speaker": "", "text": "Sur la table --- le carnet de maman."},
	{"speaker": "", "text": "Elle oublie toujours ses affaires quand elle est pressée."},
	{"speaker": "Père", "text": "Tu as dormi dehors encore."},
	{"speaker": "Ren", "text": "..."},
	{"speaker": "Père", "text": "Fais attention sur la route."},
	{"speaker": "", "text": "Il repart sans attendre. Une habitude entre eux."},
],

"jirou_ch1": [
	{"speaker": "Jirou", "text": "Tu vas à l'école ?"},
	{"speaker": "Ren", "text": "Oui je dois apporter le carnet de maman."},
	{"speaker": "Jirou", "text": "Par la forêt ou par la route ?"},
],

"jirou_suite": [
	{"speaker": "Jirou", "text": "Si tu croises quelque chose qui te regarde sans fuir... reste immobile. Laisse-le venir à toi."},
	{"speaker": "Ren", "text": "Pourquoi tu me dis ça ?"},
	{"speaker": "Jirou", "text": "Cette forêt... elle a changé depuis la Chute comme tu le sais. La tempête de la semaine dernière n'a pas arrangé les choses. Les Kakushi sont très réceptifs au Lien ces derniers temps. Certains pourraient se montrer agressifs..."},
	{"speaker": "Ren", "text": "Réceptifs au Lien, c'est à dire ?"},
	{"speaker": "Jirou", "text": "Les Tisseurs ayant reçu le don de l'éveil ressentent davantage d'activité ces derniers temps."},
	{"speaker": "Ren", "text": "Aucune chance que je sois un Tisseur, je l'aurais su depuis longtemps !"},
	{"speaker": "Jirou", "text": "Haha, ça oui tu es trop dans les nuages pour ça. Mais des choses étranges se produisent sur l'île ces derniers temps."},
	{"speaker": "", "text": "Des choses étranges. Comme d'habitude avec lui."},
],

"starters": [
	{"speaker": "", "text": "La pulsion de l'artefact te guide. Des présences t'entourent."},
	{"speaker": "", "text": "Si l'une d'elles te regarde sans fuir... reste immobile quelques secondes pour créer un Lien."},
	{"speaker": "", "text": "Tu peux continuer à marcher pour en rencontrer d'autres."},
],

"torii": [
	{"speaker": "", "text": "C'est bizarre. D'habitude je passe devant cet artefact ancien sans y penser."},
	{"speaker": "", "text": "Ces petites particules bleues... c'est nouveau."},
],

"escalier": [
	{"speaker": "Ren", "text": "Hé --- !"},
	{"speaker": "", "text": "Qu'est-ce que... un escalier ? Il était là depuis combien de temps ?"},
],

"artefact": [
	{"speaker": "", "text": "C'est chaud. Pas le cristal, quelque chose en moi. Comme si quelque chose se réveillait."},
	{"speaker": "Voix", "text": "Tiens... on dirait que le cristal réagit à ta présence."},
	{"speaker": "Voix", "text": "Il s'illumine et t'éblouit."},
	{"speaker": "Voix", "text": "Une sensation bizarre parcourt tout ton corps et ton esprit... comme si l'artefact te faisait passer un message."},
	{"speaker": "Voix", "text": "Cela voudrait peut-être dire que tu es un... Tisseur."},
	{"speaker": "Ren", "text": "Un Tisseur. Comme papa ? Non c'est impossible, je suis juste mal réveillé."},
],

"embrix_avant": [
	{"speaker": "Ren", "text": "Un Embrix agressif nous regarde méchamment. Maintenant qu'on a un Kakushi, combattons-le."},
],

"embrix_apres": [
	{"speaker": "", "text": "Embrix a fui."},
	{"speaker": "Ren", "text": "On a vraiment fait ça."},
	{"speaker": "", "text": "Combat gagné ! Le Lien avec le Kakushi est renforcé."},
	{"speaker": "", "text": "Combattez et gagnez des combats pour renforcer le Lien, débloquer des aptitudes et compétences spécifiques."},
	{"speaker": "", "text": "Certains Kakushi peuvent même évoluer quand le Lien est suffisamment fort !"},
	{"speaker": "Ren", "text": "Je devrais peut-être aller voir Jirou, il s'y connaît en Kakushi. Il m'enseignera tout ce qu'il y a à savoir."},
],

"mere_ecole": [
	{"speaker": "Mère", "text": "Tu as trouvé l'escalier."},
	{"speaker": "Ren", "text": "Tu savais ?"},
	{"speaker": "Mère", "text": "Je savais que ça arriverait. Depuis le jour où tu es né."},
	{"speaker": "Ren", "text": "Depuis ma naissance ? Tu... tu aurais pu me dire quelque chose, non ?"},
	{"speaker": "Mère", "text": "Non. Ça doit arriver naturellement. Si on te dit avant, tu cherches. Et si tu cherches, tu forces. Et on ne force pas un Lien."},
	{"speaker": "Mère", "text": "Ton père aussi a ressenti ça. Au même âge. Au même endroit."},
	{"speaker": "Ren", "text": "Il était Tisseur ?"},
	{"speaker": "Mère", "text": "Il l'est encore. Quelque part."},
	{"speaker": "Ren", "text": "Quelque part... tu sais où il est ?"},
	{"speaker": "Mère", "text": "Va voir Yamoto au port. Il t'expliquera ce que tu es maintenant."},
	{"speaker": "Mère", "text": "Prends soin de lui."},
	{"speaker": "Ren", "text": "Ah, ton carnet."},
	{"speaker": "Mère", "text": "Merci !"},
],

"yamoto_ch1": [
	{"speaker": "Yamoto", "text": "Alors c'est toi."},
	{"speaker": "Ren", "text": "Ma mère m'a dit de venir vous voir."},
	{"speaker": "Yamoto", "text": "Je sais. Je t'attendais depuis un moment."},
	{"speaker": "Yamoto", "text": "Un Tisseur c'est quelqu'un qui peut créer un Lien avec un Kakushi. Pas les dresser. Pas les capturer. Créer un Lien. C'est différent."},
	{"speaker": "Ren", "text": "C'est quoi la différence ?"},
	{"speaker": "Yamoto", "text": "La différence c'est que l'on ne peut pas choisir de tisser un Lien, on naît avec cette faculté ou pas."},
	{"speaker": "Ren", "text": "Il m'a choisi sans me connaître ?"},
	{"speaker": "Yamoto", "text": "...Rigole... Tu connais quelqu'un qui t'a choisi en te connaissant d'abord ?"},
	{"speaker": "Yamoto", "text": "Prends soin de ce Lien. C'est la chose la plus fragile et la plus solide que tu auras jamais."},
	{"speaker": "Yamoto", "text": "La salamandre sur la route de la forêt, elle gardait une Balise de l'Éclat. Des pierres qui soignent. Des pierres qui parlent. Certains disent qu'elles racontent l'histoire de la Chute, fragment par fragment."},
	{"speaker": "Yamoto", "text": "Y en a huit. Au cas où tu serais curieux."},
],

"balise_1": [
	{"speaker": "", "text": "Une pierre ancienne gravée de symboles pulse d'une lumière bleue."},
	{"speaker": "", "text": "Ren pose la main dessus. Flash bleu. Toute l'équipe soignée. ✨"},
	{"speaker": "", "text": "« La lumière qui tombe n'est pas toujours une catastrophe. Parfois c'est une réponse. --- Fragment 1/7 »"},
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
	{"speaker": "", "text": "Je m'en souviendrai."},
],

"jirou_sc13": [
	{"speaker": "Jirou", "text": "Tu es revenu. Avec lui."},
	{"speaker": "Ren", "text": "Tu savais que ça allait arriver, hein."},
	{"speaker": "Jirou", "text": "Je le savais depuis que tu es tout petit. Ton père aussi le savait."},
	{"speaker": "Ren", "text": "Tout le monde savait sauf moi."},
	{"speaker": "Jirou", "text": "C'est toujours comme ça. Le Lien ne se force pas, ne s'explique pas. Il arrive quand il doit arriver."},
	{"speaker": "", "text": "Pour la première fois, il regarde Ren vraiment."},
	{"speaker": "Jirou", "text": "Assieds-toi. Je vais te raconter ce que tu es maintenant."},
	{"speaker": "Jirou", "text": "Il y a longtemps, les animaux et les humains vivaient ensemble sur Terasu. Pas comme des animaux domestiques. Comme des égaux."},
	{"speaker": "Jirou", "text": "Les Tisseurs étaient les gens comme toi et moi, ils n'existaient pas encore."},
	{"speaker": "Ren", "text": "Donc pas de Kakushi ?"},
	{"speaker": "Jirou", "text": "Non. Les Kakushi n'existaient pas encore. C'était des animaux qui transmettaient des émotions, des images, des sensations."},
	{"speaker": "Jirou", "text": "Tu l'as déjà senti non ? Quand tu regardes ton compagnon tu ressens quelque chose d'indéfinissable ?"},
	{"speaker": "Ren", "text": "...Oui. C'est difficile à décrire."},
	{"speaker": "Jirou", "text": "C'est le début du Lien. Il grandit avec le temps, avec les épreuves, avec la confiance."},
	{"speaker": "", "text": "Un silence. Le vent dans les arbres."},
	{"speaker": "Jirou", "text": "Puis la Chute est arrivée."},
	{"speaker": "Ren", "text": "La Chute... tu en parles souvent mais tu n'expliques jamais vraiment."},
	{"speaker": "Jirou", "text": "Parce que personne ne sait exactement ce qui s'est passé. Il y a trois cents ans, quelque chose a brisé l'équilibre de Terasu."},
	{"speaker": "Jirou", "text": "Le ciel a changé de couleur pendant sept jours. Les animaux ont changé de forme dans les forêts et les profondeurs. Les Tisseurs ont reçu leurs dons du jour au lendemain."},
	{"speaker": "Jirou", "text": "Certains disent qu'un Tisseur a voulu prendre le contrôle des Kakushi plutôt que tisser un Lien. C'est là qu'est apparu le Consortium."},
	{"speaker": "Ren", "text": "Et les Balises de l'Éclat ?"},
	{"speaker": "Jirou", "text": "Des fragments de mémoire. L'archipel a tout enregistré. La Chute, ce qui l'a précédée, ce qui s'en est suivi. Les huit Balises racontent cette histoire... pour ceux qui savent écouter."},
	{"speaker": "Ren", "text": "Yamoto m'a dit qu'il y en a huit."},
	{"speaker": "Jirou", "text": "..."},
	{"speaker": "Jirou", "text": "Yamoto a dit ça ?"},
	{"speaker": "", "text": "Quelque chose passe dans ses yeux. Une ombre."},
	{"speaker": "Jirou", "text": "Va en trouver une. Tu comprendras par toi-même."},
	{"speaker": "Jirou", "text": "Ton Lien... il est jeune. Fragile. Pour le renforcer, tu dois faire des choses ensemble. Des combats, des épreuves, du temps partagé."},
	{"speaker": "Ren", "text": "C'est tout ?"},
	{"speaker": "Jirou", "text": "Non. Il existe un objet. Un bracelet de résonance. Forgé par un vieil ami à moi qui vit sur le continent."},
	{"speaker": "Ren", "text": "Un bracelet ?"},
	{"speaker": "Jirou", "text": "Il amplifie le Lien. Capte les vibrations entre toi et ton compagnon quand vous bougez ensemble, quand tu cours, quand ton cœur s'accélère."},
	{"speaker": "Jirou", "text": "Mon ami s'appelle Edmond. Il vit à Rivalia, la première ville que tu traverseras en quittant l'île."},
	{"speaker": "Jirou", "text": "Dis-lui que c'est moi qui t'envoie. Il te donnera le bracelet."},
	{"speaker": "Ren", "text": "Pourquoi tu ne me le donnes pas toi-même ?"},
	{"speaker": "Jirou", "text": "Parce que le chemin jusqu'à lui fait partie du voyage. Et parce qu'Edmond doit voir ton Lien de ses propres yeux avant de te faire confiance."},
	{"speaker": "", "text": "Il tire sur une maille du filet. Elle cède enfin."},
	{"speaker": "Jirou", "text": "Une dernière chose."},
	{"speaker": "Jirou", "text": "Ce qui se réveille sur Terasu en ce moment... ce n'est pas que les Kakushi."},
	{"speaker": "Jirou", "text": "Pars. Apprends. Reviens plus fort."},
	{"speaker": "Ren", "text": "Tu me fais peur quand tu parles comme ça."},
	{"speaker": "Jirou", "text": "Bien. La peur rend attentif."},
	{"speaker": "", "text": "Il reprend son filet. La conversation est terminée."},
	{"speaker": "Ren", "text": "Des choses étranges. Comme toujours avec lui. Mais cette fois... je crois qu'il a raison."},
],

"depart_ch1": [
	{"speaker": "", "text": "'Parfois c'est une réponse.' Une réponse à quoi ?"},
	{"speaker": "", "text": "Il y a d'autres balises. D'autres fragments. Les réponses sont ailleurs."},
	{"speaker": "Mère", "text": "Tu pars ce soir ?"},
	{"speaker": "Ren", "text": "Oui."},
	{"speaker": "Mère", "text": "Des Potions. Pour toi et... pour lui."},
	{"speaker": "Père", "text": "Fais attention."},
	{"speaker": "", "text": "Il sait. Il a toujours su."},
	{"speaker": "Jirou", "text": "Donne ça à Akemi. Elle sait qui je suis."},
	{"speaker": "Jirou", "text": "La Chute de la Kakusei-sei... ce n'était pas un accident."},
	{"speaker": "", "text": "Ce matin j'étais personne. Ce soir je suis Tisseur."},
	{"speaker": "", "text": "--- Chapitre 1 --- L'Éveil --- Terminé ---"},
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

"route1_bloquee": [
	{"speaker": "", "text": "Un arbre massif barre la route. Il vient de tomber."},
	{"speaker": "", "text": "Impossible de passer par là pour l'instant."},
],

"route1_deblocable": [
	{"speaker": "", "text": "Un éboulement bloque la suite. Les pierres sont trop lourdes."},
	{"speaker": "", "text": "Il faudra revenir avec du renfort. ▶ Débloqué au Chapitre 4"},
],

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
# KAKUSHI
# ═══════════════════════════════════════════════

const KAKUSHI = {

"kitsufi": {
	"rarete": "commun",
	"couleur_particules": Color(0.2, 0.8, 0.2, 1),
	"comportement": "curieux",
	"periode": "toujours",
	"poids": 40,
},

"ondrak": {
	"rarete": "commun",
	"couleur_particules": Color(0.2, 0.2, 0.8, 1),
	"comportement": "mefiant",
	"periode": "toujours",
	"poids": 30,
},

"moshu": {
	"rarete": "peu_commun",
	"couleur_particules": Color(0.2, 0.5, 0.8, 1),
	"comportement": "mefiant",
	"periode": "toujours",
	"poids": 20,
},

"zappiko": {
	"rarete": "peu_commun",
	"couleur_particules": Color(0.2, 0.5, 0.8, 1),
	"comportement": "curieux",
	"periode": "toujours",
	"poids": 8,
},

"kagemi": {
	"rarete": "rare",
	"couleur_particules": Color(1.0, 0.4, 0.7, 1),
	"comportement": "mefiant",
	"periode": "nuit",
	"poids": 2,
},

"embrix": {
	"rarete": "legendaire",
	"couleur_particules": Color(1.0, 0.2, 0.2, 1),
	"comportement": "agressif",
	"periode": "toujours",
	"poids": 0,
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
			"position": Vector2(200, 250),
			"dialogue_id": "jirou_ch1",
			"condition": "not:JIROU_VU",
			"has_choix": true,
			"choix_texte": "Par la route, c'est plus court. (O) --- Par la forêt, c'est plus beau. (N)",
			"on_oui": "jirou_route",
			"on_non": "jirou_foret",
			"suite_dialogue_id": "jirou_suite",
			"avance_etape": "JIROU_VU",
		},
		{
			"id": "jirou_sc13",
			"sprite": "jirou",
			"position": Vector2(250, 580),
			"dialogue_id": "jirou_sc13",
			"condition": "YAMOTO_VU",
			"avance_etape": "BALISE_ACTIVEE",
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
	"id": "retour_foret_balise",
	"type": "transition",
	"position": Vector2(1550, 0),
	"size": Vector2(80, 32),
	"destination": "foret",
	"condition": "YAMOTO_VU",
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
		{
			"id": "consortium",
			"type": "dialogue_choix",
			"position": Vector2(700, 575),
			"size": Vector2(48, 48),
			"dialogue_id": "consortium_ch1",
			"condition": "YAMOTO_VU",
			"avance_etape": "CONSORTIUM_VU",
			"choix_texte": "Donner ton nom ? (O) --- Refuser. (N)",
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
	"kakushi_zones": [
		{
			"id": "route1_zone",
			"nom": "Route 1 --- Hautes herbes",
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
			"id": "escalier_chambre",
			"type": "transition",
			"position": Vector2(600, 324),
			"size": Vector2(48, 48),
			"destination": "chambre",
			"condition": "not:ARTEFACT_VU",
			"sauvegarde_position": "foret",
		},
		{
	"id": "torii",
	"type": "dialogue",
	"position": Vector2(300, 324),
	"size": Vector2(80, 48),
	"dialogue_id": "torii",
	"condition": "not:ARTEFACT_VU",
	"repeatable": false,
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
"surchauffe":         {"label":"Surchauffe",         "source":"feu",    "duree":3, "effet":"je_max_50"},
"dilution":           {"label":"Dilution",            "source":"eau",    "duree":4, "effet":"cout_je_plus10"},
"court_circuit":      {"label":"Court-Circuit",       "source":"foudre", "duree":1, "effet":"reset_tempo"},
"entrave":            {"label":"Entrave",             "source":"nature", "duree":3, "effet":"spd_div2"},
"miroir_brise":       {"label":"Miroir Brise",        "source":"ombre",  "duree":4, "effet":"reflet_10pct"},
"cristallisation":    {"label":"Cristallisation",     "source":"glace",  "duree":2, "effet":"def_plus25_spd_div2"},
"dissipation":        {"label":"Dissipation",         "source":"plasma", "duree":3, "effet":"lien_zero"},
"resonance_inversee": {"label":"Resonance Inversee",  "source":"spectre","duree":2, "effet":"soins_degats"},
"eclat_sature":       {"label":"Eclat Sature",        "source":"lune",   "duree":3, "effet":"je_vide_15"},
"turbulence":         {"label":"Turbulence",          "source":"vent",   "duree":3, "effet":"tempo_aleatoire"},
}

# ═══════════════════════════════════════════════
# ATTAQUES --- Ch.1
# ═══════════════════════════════════════════════

const ATTAQUES = {
"morsure_braise":    {"nom":"Morsure de Braise", "element":"feu",    "type":"physique", "puissance":25, "je":0,  "alteration":"surchauffe",    "proba_alt":0.08, "esquivabilite":0.20},
"queue_enflammee":   {"nom":"Queue Enflammee",   "element":"feu",    "type":"special",  "puissance":35, "je":20, "alteration":"surchauffe",    "proba_alt":0.25, "esquivabilite":0.15},
"rugissement":       {"nom":"Rugissement",       "element":"neutre", "type":"statut",   "puissance":0,  "je":10, "alteration":"",              "proba_alt":0.00, "esquivabilite":0.00},
"canaliser":         {"nom":"Canaliser",         "element":"neutre", "type":"recharge", "puissance":0,  "je":0,  "alteration":"",              "proba_alt":0.00, "esquivabilite":0.00},
"jet_eau":           {"nom":"Jet d'Eau",         "element":"eau",    "type":"physique", "puissance":20, "je":0,  "alteration":"dilution",      "proba_alt":0.08, "esquivabilite":0.25},
"vague_froide":      {"nom":"Vague Froide",      "element":"eau",    "type":"special",  "puissance":28, "je":20, "alteration":"dilution",      "proba_alt":0.20, "esquivabilite":0.15},
"fouet_vegetal":     {"nom":"Fouet Vegetal",     "element":"nature", "type":"physique", "puissance":25, "je":0,  "alteration":"entrave",       "proba_alt":0.08, "esquivabilite":0.20},
"pollen_endormi":    {"nom":"Pollen Endormi",    "element":"nature", "type":"statut",   "puissance":0,  "je":20, "alteration":"entrave",       "proba_alt":1.00, "esquivabilite":0.00},
"eclair_rapide":     {"nom":"Eclair Rapide",     "element":"foudre", "type":"special",  "puissance":30, "je":20, "alteration":"court_circuit", "proba_alt":0.20, "esquivabilite":0.30},
"surcharge":         {"nom":"Surcharge",         "element":"foudre", "type":"special",  "puissance":50, "je":35, "alteration":"court_circuit", "proba_alt":0.10, "esquivabilite":0.05},
"reflet_brise":      {"nom":"Reflet Brise",      "element":"ombre",  "type":"special",  "puissance":28, "je":20, "alteration":"miroir_brise",  "proba_alt":0.25, "esquivabilite":0.20},
"disparition":       {"nom":"Disparition",       "element":"ombre",  "type":"statut",   "puissance":0,  "je":15, "alteration":"",              "proba_alt":0.00, "esquivabilite":0.00},
"crachat_lave":      {"nom":"Crachat de Lave",   "element":"feu",    "type":"special",  "puissance":40, "je":0,  "alteration":"surchauffe",    "proba_alt":0.30, "esquivabilite":0.25},
"charge_volcanique": {"nom":"Charge Volcanique", "element":"feu",    "type":"physique", "puissance":45, "je":0,  "alteration":"",              "proba_alt":0.00, "esquivabilite":0.15},
}

# ═══════════════════════════════════════════════
# KAKUSHI_STATS --- Ch.1
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

const DIALOGUES_CLAIRIERE = {
"telephone_pere": [
	["Père", "% Tu dors encore ? Ta mère te cherche."],
	["Père", "% Tu m'entends ?"],
	["Père", "J'ai besoin que tu me rendes un service, apporte le carnet à ta mère, elle se trouve à l'école au bout de la forêt."],
	["Père", "Fais attention sur la route."],
],
"reveil": [
	["", "Encore endormi dehors. Jirou dirait que c'est comme ça qu'on apprend à écouter la mer."],
],
"objectif": [
	["", "[ Objectif : Rentre à la maison. Le carnet de ta mère est sur la table. ]"],
],
}

# ═══════════════════════════════════════════════
# DIALOGUES COMBAT
# ═══════════════════════════════════════════════

const DIALOGUES_COMBAT = {
"intro_sauvage":          "Le kakushi te regarde pour combattre !.",
"intro_embrix":           "Embrix bloque le passage. Il a l'air agressif.",
"intro_tisseur":          "Son Kakushi se met en position.",
"intro_consortium":       "L'Agent sort un Pisto-Lien. Pas pour capturer.",
"victoire_sauvage":       "Il recule. Victoire, tu as gagné le combat !",
"victoire_embrix":        "Embrix s'arrête. Il te regarde une dernière fois. Puis il disparaît.",
"victoire_tisseur":       "Un signe de tête. Respect discret.",
"victoire_consortium":    "L'Agent range son matériel. Il note quelque chose.",
"defaite":                "Tu as perdu ce combat, la prochaine sera la bonne !",
"defaite_embrix":         "Embrix t'a épargné. Pourquoi ?",
"fuite_reussie":          "Tu as réussi à t'échapper ! Le Lien tremble légèrement.",
"fuite_echouee":          "Impossible de passer. Il te garde en face de lui.",
"super_efficace":         "Cette attaque fait vraiment mal !",
"peu_efficace":           "Cette attaque ne fait pas très mal.",
"immunite":               "Aucun effet. Rien.",
"je_vide":                "Plus d'Eclat. Attaque de base uniquement.",
"canaliser":              "L'Eclat se recharge.",
"esquive_reussie":        "Esquivé de justesse.",
"esquive_ratee":          "Pas assez rapide.",
"alt_surchauffe":         "Trop d'Eclat d'un coup. La jauge déborde.",
"alt_dilution":           "L'Eclat se disperse. Chaque attaque coûte plus.",
"alt_court_circuit":      "Court-circuit. Le Tempo repart de zéro.",
"alt_entrave":            "Les membres refusent. Mouvement réduit.",
"alt_miroir_brise":       "Ce que tu infliges... tu le ressens aussi.",
"alt_cristallisation":    "Le froid fige. Défense renforcée. Mais plus rien ne bouge.",
"alt_dissipation":        "Le Lien s'efface temporairement. Tu es seul.",
"alt_resonance_inversee": "Quelque chose est inversé. Les soins brûlent.",
"alt_eclat_sature":       "Trop plein. L'Eclat fuit tout seul.",
"alt_turbulence":         "Le Tempo déraille. Impossible à prévoir.",
"immunite_court_circuit": "Déjà frappé là. Ça ne prend plus.",
"alt_dissipe":            "L'effet se dissipe.",
}
