# TriggerEcole.gd — INUTILISÉ — supprimé de monde.tscn
# Le passage vers l'école se fait via SortieVersEcole dans Foret.tscn
extends "res://scripts/BaseTrigger.gd"

func condition_activation() -> bool:
	return false
	
	return StoryManager.est_a_partir_de(StoryManager.Etape.COMBAT_GAGNE)

func on_activation() -> void:
	StoryManager.avancer(StoryManager.Etape.ECOLE_VUE)
	DialogueManager.show_dialogue([
		["Mère", "Tu as trouvé l'escalier."],
		["Ren",  "Tu savais ?"],
		["Mère", "Je savais que ça arriverait. Depuis le jour où tu es né."],
		["Ren",  "Depuis ma naissance ? Tu... tu aurais pu me dire quelque chose, non ?"],
		["Mère", "Non. Ça doit arriver naturellement. Si on te dit avant, tu cherches. Et si tu cherches, tu forces. Et on ne force pas un Lien."],
		["Mère", "Ton père aussi a ressenti ça. Au même âge. Au même endroit."],
		["Ren",  "Il était Tisseur ?"],
		["Mère", "Il l'est encore. Quelque part."],
		["Ren",  "Quelque part... tu sais où il est ?"],
		["Mère", "Va voir Yamoto au port. Il t'expliquera ce que tu es maintenant."],
		["Mère", "Prends soin de lui."],
		["Ren",  "Ah — ton carnet."],
		["Mère", "Merci."],
	], _apres_dialogue)

func _apres_dialogue() -> void:
	Global.spawn_x = Global.derniere_position_foret.x
	Global.spawn_y = Global.derniere_position_foret.y
	Transition.vers_foret()
