extends Node2D

@onready var balloon: CanvasLayer = $ExampleBalloon

func _ready():
	# Carga tu recurso de diálogo
	var dialogue_res = load("res://DialogueView/Dialogues/prueba.dialogue")
	# Inicia el diálogo en el nodo Balloon
	balloon.start(dialogue_res, "amador_intro")
