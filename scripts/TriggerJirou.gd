extends "res://scripts/BaseTrigger.gd"
func condition_activation() -> bool:
	return true   # Jirou parle toujours

func on_activation() -> void:
	StoryManager.avancer(StoryManager.Etape.JIROU_VU)
	DialogueManager.show_dialogue([
		["Jirou", "Tu vas à l'école ?"],
		["Ren", "Apporter le carnet de maman."],
		["Jirou", "Si tu croises quelque chose qui te regarde sans fuir... reste immobile. Laisse-le venir à toi."],
		["Ren", "Pourquoi tu me dis ça ?"],
		["Jirou", "Fais attention. Il se passe des choses étranges dans cette forêt en ce moment."],
	], Callable())
