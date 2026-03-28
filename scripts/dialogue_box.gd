extends CanvasLayer

@onready var nom = $Box/NomPersonnage
@onready var texte = $Box/Texte
@onready var continuer = $Box/Continuer

var dialogue_complet : String = ""
var index : int = 0
var timer : float = 0.0
var vitesse : float = 0.04
var en_cours : bool = false
var sequence : Array = []
var sequence_index : int = 0
var callback : Callable
var en_choix : bool = false
var callback_oui : Callable
var callback_non : Callable

func afficher(nom_personnage: String, phrase: String):
	nom.text = nom_personnage
	dialogue_complet = phrase
	texte.text = ""
	index = 0
	en_cours = true
	continuer.visible = false
	$Box.visible = true

func afficher_sequence(phrases: Array, rappel: Callable = Callable()):
	sequence = phrases
	sequence_index = 0
	callback = rappel
	var premier = phrases[0]
	afficher(premier[0], premier[1])

func afficher_choix(phrase: String, cb_oui: Callable, cb_non: Callable):
	en_choix = true
	callback_oui = cb_oui
	callback_non = cb_non
	nom.text = ""
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
			if en_choix:
				continuer.text = "O = Oui     N = Non"
			else:
				continuer.text = "▶ Continuer"
			continuer.visible = true

func _input(event):
	if not $Box.visible:
		return
	if en_choix and not en_cours:
		if event is InputEventKey and event.pressed:
			if event.keycode == KEY_O:
				en_choix = false
				$Box.visible = false
				continuer.text = "▶ Continuer"
				if callback_oui.is_valid():
					callback_oui.call()
			elif event.keycode == KEY_N:
				en_choix = false
				$Box.visible = false
				continuer.text = "▶ Continuer"
				if callback_non.is_valid():
					callback_non.call()
		return
	if event.is_action_pressed("ui_accept"):
		if en_cours:
			texte.text = dialogue_complet
			index = dialogue_complet.length()
			en_cours = false
			continuer.text = "▶ Continuer"
			continuer.visible = true
		else:
			sequence_index += 1
			if sequence_index < sequence.size():
				var suivant = sequence[sequence_index]
				afficher(suivant[0], suivant[1])
			else:
				$Box.visible = false
				sequence = []
				if callback.is_valid():
					callback.call()
func _ready():
	DialogueManager.register(self)
	$Box.visible = false
	continuer.text = "▶ Continuer"
