# res://Scripts/balloon.gd (CORREGIDO)
extends CanvasLayer

@onready var character_label = %CharacterLabel
@onready var dialogue_label = %DialogueLabel
@onready var responses_menu = %ResponsesMenu
@onready var main_dialogue_ui_container: Control = $Balloon # <--- AQUI la ruta a tu nodo 'Balloon' Control

# NUEVA SEÑAL: para notificar a la escena principal que se necesita el numpad
signal request_numpad_input(resource: DialogueResource, current_key: String, extra_game_states: Array)

var dialogue_resource: DialogueResource
var current_dialogue_key: String
var current_game_states: Array

var can_advance_dialogue: bool = false
var is_dialogue_paused_for_external_input: bool = false # NUEVA bandera para pausar el diálogo

func _ready():
	# Conectamos a la señal 'mutated' de Dialogue Manager
	DialogueManager.mutated.connect(_on_dialogue_mutated)

func start(resource_obj: DialogueResource, start_title: String = "", extra_game_states_arr: Array = []):
	self.dialogue_resource = resource_obj
	self.current_dialogue_key = start_title
	self.current_game_states = extra_game_states_arr
	
	can_advance_dialogue = true
	is_dialogue_paused_for_external_input = false
	
	show() # Asegura que el CanvasLayer (el globo) sea visible
	main_dialogue_ui_container.show() # Asegura que el contenido del diálogo sea visible
	_get_and_display_next_line()

func _on_balloon_gui_input(event: InputEvent):
	if is_dialogue_paused_for_external_input:
		get_tree().set_input_as_handled()
		return

	if event.is_action_pressed("ui_accept"):
		if can_advance_dialogue:
			_get_and_display_next_line()
			get_tree().set_input_as_handled()
		elif responses_menu.visible:
			pass 
		else:
			pass

func _get_and_display_next_line():
	if is_dialogue_paused_for_external_input:
		return

	main_dialogue_ui_container.show() # Asegura que el contenido del diálogo sea visible

	var dialogue_line = await DialogueManager.get_next_dialogue_line(
		dialogue_resource, 
		current_dialogue_key, 
		current_game_states
	)

	if dialogue_line == null:
		hide() # Oculta todo el CanvasLayer cuando el diálogo termina
		main_dialogue_ui_container.hide()
		return

	# Aquí NO procesamos directamente tags como #NumpadRequest
	# La lógica para el numpad ahora está en _on_dialogue_mutated

	dialogue_label.text = dialogue_line.text
	character_label.text = dialogue_line.character

	current_dialogue_key = dialogue_line.next_id

	if dialogue_line.responses.size() > 0:
		responses_menu.responses = dialogue_line.responses
		responses_menu.show()
		can_advance_dialogue = false
	else:
		responses_menu.hide()
		can_advance_dialogue = true

# NUEVO MÉTODO: Se conecta a la señal 'mutated' de Dialogue Manager
func _on_dialogue_mutated(mutation: Dictionary):
	# Verificamos si la mutación es nuestro comando especial para el numpad
	# La mutación tiene una estructura { "expression": [ { "type": 1, "function": "mi_funcion" } ] }
	if mutation.has("expression") and mutation.expression.size() > 0:
		var first_token = mutation.expression[0]
		if first_token.has("type") and first_token.type == DMConstants.TOKEN_FUNCTION and first_token.function == "request_numpad_input":
			is_dialogue_paused_for_external_input = true # Pausa el avance del diálogo
			main_dialogue_ui_container.hide() # Oculta la UI del diálogo
			
			# Emitimos nuestra señal para que la escena principal muestre el numpad
			request_numpad_input.emit(dialogue_resource, current_dialogue_key, current_game_states)
			
			# Es crucial no llamar a _get_and_display_next_line() aquí, ya que el diálogo
			# está pausado y esperará la entrada del numpad.

# NUEVO MÉTODO: Llamado por la escena principal (dialogue.gd) para reanudar el diálogo
func resume_dialogue_flow(res: DialogueResource, title_key: String, states: Array):
	self.dialogue_resource = res
	self.current_dialogue_key = title_key
	self.current_game_states = states
	
	is_dialogue_paused_for_external_input = false # Desactivamos la pausa
	show() # Asegura que el CanvasLayer sea visible
	main_dialogue_ui_container.show() # Asegura que el contenido del diálogo sea visible
	_get_and_display_next_line() # Continuamos el flujo de diálogo
