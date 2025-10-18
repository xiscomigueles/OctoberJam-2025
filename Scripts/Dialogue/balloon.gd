# res://Scripts/balloon.gd (SIMPLIFICADO Y FINAL)
extends CanvasLayer

@onready var character_label = %CharacterLabel
@onready var dialogue_label = %DialogueLabel
@onready var responses_menu = %ResponsesMenu
@onready var main_dialogue_ui_container: Control = $Balloon

var dialogue_resource: DialogueResource
var current_dialogue_key: String
var current_game_states: Array

var can_advance_dialogue: bool = false
var is_dialogue_paused: bool = false

func start(resource_obj: DialogueResource, start_title: String = "", extra_game_states_arr: Array = []):
	self.dialogue_resource = resource_obj
	self.current_dialogue_key = start_title
	self.current_game_states = extra_game_states_arr
	
	is_dialogue_paused = false
	
	show()
	main_dialogue_ui_container.show()
	_get_and_display_next_line()

func _on_balloon_gui_input(event: InputEvent):
	if is_dialogue_paused:
		get_tree().set_input_as_handled()
		return

	if event.is_action_pressed("ui_accept"):
		if can_advance_dialogue:
			_get_and_display_next_line()
			get_tree().set_input_as_handled()

func _get_and_display_next_line():
	if is_dialogue_paused:
		return

	var dialogue_line = await DialogueManager.get_next_dialogue_line(dialogue_resource, current_dialogue_key, current_game_states)

	if dialogue_line == null:
		hide()
		return

	main_dialogue_ui_container.show()
	dialogue_label.text = dialogue_line.text
	character_label.text = dialogue_line.character

	current_dialogue_key = dialogue_line.next_id

	if dialogue_line.responses.size() > 0:
		balloon.focus_mode = Control.FOCUS_NONE
		responses_menu.show()
	elif dialogue_line.time != "":
		var time = dialogue_line.text.length() * 0.02 if dialogue_line.time == "auto" else dialogue_line.time.to_float()
		await get_tree().create_timer(time).timeout
		next(dialogue_line.next_id)
	else:
		responses_menu.hide()
		can_advance_dialogue = true

# NUEVAS FUNCIONES DE CONTROL SIMPLE
func pause_dialogue():
	is_dialogue_paused = true
	main_dialogue_ui_container.hide()

func resume_dialogue(resource: DialogueResource, key: String, states: Array):
	self.dialogue_resource = resource
	self.current_dialogue_key = key
	self.current_game_states = states
	
	is_dialogue_paused = false
	_get_and_display_next_line()
