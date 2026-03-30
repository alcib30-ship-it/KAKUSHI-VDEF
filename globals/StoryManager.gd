# globals/StoryManager.gd
# AUTOLOAD — Nom : StoryManager
extends Node

enum Etape {
	DEBUT,
	JIROU_VU,
	MAISON_VUE,
	FORET_ENTREE,
	LIEN_CREE,
	COMBAT_GAGNE,
	ECOLE_VUE,
	YAMOTO_VU,
	BALISE_ACTIVEE,
	CONSORTIUM_VU,
	CHAPITRE_1_TERMINE
}

var etape_actuelle : Etape = Etape.DEBUT

func avancer(nouvelle_etape: Etape) -> void:
	if nouvelle_etape > etape_actuelle:
		etape_actuelle = nouvelle_etape

func est_a_partir_de(etape: Etape) -> bool:
	return etape_actuelle >= etape

func reset() -> void:
	etape_actuelle = Etape.DEBUT
