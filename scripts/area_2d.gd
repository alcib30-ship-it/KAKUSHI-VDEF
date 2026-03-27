extends Area2D

@onready var dialogue = get_node("../DialogueBox")

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body is CharacterBody2D:
		dialogue.afficher("Jirou", "Si tu croises quelque chose qui te regarde sans fuir... reste immobile. Laisse-le venir à toi.")
