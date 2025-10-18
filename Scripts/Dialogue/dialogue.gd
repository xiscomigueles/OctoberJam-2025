# res://tu_escena_Dialogue.gd (CORREGIDO)
extends Node2D

@onready var balloon: CanvasLayer = $ExampleBalloon
@onready var numpad_ui: CanvasLayer = $NumpadUI

var dialogue_state_for_resume: Dictionary = {}

func _ready():
	#SceneManager.spawn_player_in_current_scene()
	
	var dialogue_res = load("res://DialogueView/Dialogues/scene2.dialogue")
	
	numpad_ui.get_node("Numpad").input_submitted.connect(_on_numpad_input_submitted)
	numpad_ui.get_node("Numpad").numpad_cancelled.connect(_on_numpad_cancelled)
	
	numpad_ui.hide()

	# Nos conectamos a la señal GLOBAL.
	GLOBAL.numpad_requested_by_dialogue.connect(_on_numpad_requested_by_dialogue)

	# ¡¡CAMBIO CRÍTICO!! Ya NO pasamos un host.
	# Dejamos que Dialogue Manager busque en todos los Autoloads registrados.
	balloon.start(dialogue_res, "amador_test")

# Esta función se ejecuta CUANDO el script GLOBAL emite su señal.
func _on_numpad_requested_by_dialogue():
	dialogue_state_for_resume = balloon.pause_and_get_state()
	numpad_ui.show()
	numpad_ui.get_node("Numpad").line_edit_input.text = ""

# ... el resto del script se mantiene exactamente igual ...
func _on_numpad_input_submitted(value: String):
	numpad_ui.hide()
	if not dialogue_state_for_resume.is_empty():
		DialogueManager.set_variable("numpad_input", value)
		balloon.resume_dialogue(dialogue_state_for_resume)
		dialogue_state_for_resume = {}

func _on_numpad_cancelled():
	numpad_ui.hide()
	if not dialogue_state_for_resume.is_empty():
		DialogueManager.set_variable("numpad_input", "")
		balloon.resume_dialogue(dialogue_state_for_resume)
		dialogue_state_for_resume = {}

func _unhandled_input(event):
	if numpad_ui.visible and event.is_action_pressed("ui_accept"):
		get_tree().set_input_as_handled()
