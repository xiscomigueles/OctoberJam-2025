# res://tu_escena_Dialogue.gd (CORREGIDO)
extends Node2D

@onready var balloon: CanvasLayer = $ExampleBalloon
@onready var numpad_ui = $NumpadUI 

var dialogue_paused_state: Dictionary = {}

func _ready():
	var dialogue_res = load("res://DialogueView/Dialogues/scene2.dialogue")
	
	numpad_ui.input_submitted.connect(_on_numpad_input_submitted)
	numpad_ui.numpad_cancelled.connect(_on_numpad_cancelled)
	
	numpad_ui.hide() # Asegura que el numpad esté oculto al inicio

	balloon.numpad_requested.connect(_on_balloon_numpad_requested)

	balloon.start(dialogue_res, "amador_test", [self])

func _on_balloon_numpad_requested(resource: DialogueResource, title_key: String, extra_game_states: Array):
	# El script del globo de diálogo (balloon.gd) ya ocultó su contenido
	numpad_ui.show() # Ahora solo mostramos el numpad
	numpad_ui.line_edit_input.text = "" # Limpia el input del numpad
	
	dialogue_paused_state = {
		"resource": resource,
		"title": title_key,
		"extra_game_states": extra_game_states
	}

func _on_numpad_input_submitted(value: String):
	numpad_ui.hide() # Oculta el numpad
	
	if not dialogue_paused_state.is_empty():
		DialogueManager.set_variable("numpad_input", value)
		_resume_dialogue_flow()
	else:
		# Fallback: Si no hay estado guardado, simplemente muestra el globo de diálogo
		balloon.show() 

func _on_numpad_cancelled():
	numpad_ui.hide() # Oculta el numpad

	if not dialogue_paused_state.is_empty():
		DialogueManager.set_variable("numpad_input", "") # Asigna vacío si se cancela
		_resume_dialogue_flow()
	else:
		# Fallback
		balloon.show() 

func _resume_dialogue_flow():
	# El script del globo de diálogo (balloon.gd) es quien reanudará su contenido
	balloon.continue_from_state(
		dialogue_paused_state.resource,
		dialogue_paused_state.title,
		dialogue_paused_state.extra_game_states
	)
	dialogue_paused_state = {}
