extends Node

enum Etape {
	DEBUT,
	PERSONNAGE_CREE,
	JIROU_VU,
	MAISON_VUE,
	FORET_ENTREE,
	ARTEFACT_VU,
	LIEN_CREE,
	COMBAT_GAGNE,
	ECOLE_VUE,
	YAMOTO_VU,
	BALISE_ACTIVEE,
	ROUTE1_DEBLOQUEE,
	CONSORTIUM_VU,
	CHAPITRE_1_TERMINE
}

var etape_actuelle    : Etape  = Etape.DEBUT
var choix_consortium  : String = ""   # "nom" ou "refuse"
var choix_chemin_jirou: String = ""   # "route" ou "foret"

func avancer(nouvelle_etape: Etape) -> void:
	if nouvelle_etape > etape_actuelle:
		etape_actuelle = nouvelle_etape
		print("StoryManager → étape : ", Etape.keys()[etape_actuelle])
		SaveManager.sauvegarder()

func est_a_partir_de(etape: Etape) -> bool:
	return etape_actuelle >= etape

func reset() -> void:
	etape_actuelle     = Etape.DEBUT
	choix_consortium   = ""
	choix_chemin_jirou = ""
