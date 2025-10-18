# res://tu_escena_Dialogue.gd (ARQUITECTURA FINAL Y SIMPLIFICADA)
extends Node2D

@onready var balloon: CanvasLayer = $ExampleBalloon
@onready var numpad_ui: CanvasLayer = $NumpadUI

var dialogue_resource: DialogueResource

func _ready():
	#SceneManager.spawn_player_in_current_scene()
	
	dialogue_resource = load("res://DialogueView/Dialogues/scene2.dialogue")
	
	numpad_ui.get_node("Numpad").input_submitted.connect(_on_numpad_input_submitted)
	numpad_ui.get_node("Numpad").numpad_cancelled.connect(_on_numpad_cancelled)
	
	numpad_ui.hide()

	# Nos conectamos a la señal GLOBAL.
	GLOBAL.numpad_requested_by_dialogue.connect(_on_numpad_requested_by_dialogue)

	# Iniciamos el primer diálogo.
	start_dialogue("amador_test")

# Función para iniciar cualquier diálogo por su título
func start_dialogue(title: String):
	# Pasamos 'GLOBAL' como host.
	balloon.start(dialogue_resource, title, [GLOBAL])

# Esta función se ejecuta CUANDO el script GLOBAL emite su señal.
func _on_numpad_requested_by_dialogue():
	# El diálogo 'amador_intro' ha terminado. Ahora mostramos el numpad.
	numpad_ui.show()
	numpad_ui.get_node("Numpad").line_edit_input.text = ""

func _on_numpad_input_submitted(value: String):
	numpad_ui.hide()
	
	# Guardamos el resultado en la variable global.
	GLOBAL.numpad_input = value
	
	# Iniciamos el SEGUNDO diálogo para reaccionar al resultado.
	start_dialogue("reaccionar_a_pin")

func _on_numpad_cancelled():
	numpad_ui.hide()
	
	# Guardamos un resultado vacío.
	GLOBAL.numpad_input = ""
	
	# También iniciamos el segundo diálogo para que pueda decir "Incorrecto".
	start_dialogue("reaccionar_a_pin")

func _unhandled_input(event):
	if numpad_ui.visible and event.is_action_pressed("ui_accept"):
		get_tree().set_input_as_handled()
