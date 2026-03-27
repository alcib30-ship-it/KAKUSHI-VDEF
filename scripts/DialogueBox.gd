extends CanvasLayer

@onready var nom = $Box/NomPersonnage
@onready var texte = $Box/Texte
@onready var continuer = $Box/Continuer

var dialogue_complet : String = ""
var index : int = 0
var timer : float = 0.0
var vitesse : float = 0.04
var en_cours : bool = false

func afficher(nom_personnage: String, phrase: String):
	nom.text = nom_personnage
	dialogue_complet = phrase
	texte.text = ""
	index = 0
	en_cours = true
	continuer.visible = false
	$Box.visible = true

func _process(delta):
	if not en_cours:
		return
	timer += delta
	if timer >= vitesse:
		timer = 0.0
		if index < dialogue_complet.length():
			texte.text += dialogue_complet[index]
			index += 1
		else:
			en_cours = false
			continuer.visible = true

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if en_cours:
			texte.text = dialogue_complet
			index = dialogue_complet.length()
			en_cours = false
			continuer.visible = true
		else:
			$Box.visible = false

func _ready():
	$Box.visible = false
