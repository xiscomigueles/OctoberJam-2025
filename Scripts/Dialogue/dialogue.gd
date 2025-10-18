# res://tu_escena_Dialogue.gd (ARQUITECTURA FINAL Y ROBUSTA)
extends Node2D

# Pre-cargamos la escena del globo para poder crear nuevas instancias.
const BALLOON_SCENE = preload("res://DialogueView/balloon.tscn")

# Esta variable ahora contendrá la instancia actual del globo. La inicializamos a null.
var balloon: CanvasLayer = null

@onready var numpad_ui: CanvasLayer = $NumpadUI

var dialogue_resource: DialogueResource

func _ready():
	SceneManager.spawn_player_in_current_scene()
	
	dialogue_resource = load("res://DialogueView/Dialogues/scene2.dialogue")
	
	numpad_ui.get_node("Numpad").input_submitted.connect(_on_numpad_input_submitted)
	numpad_ui.get_node("Numpad").numpad_cancelled.connect(_on_numpad_cancelled)
	
	numpad_ui.hide()

	GLOBAL.numpad_requested_by_dialogue.connect(_on_numpad_requested_by_dialogue)

	# Iniciamos el primer diálogo.
	start_dialogue("amador_test")

# Función para iniciar cualquier diálogo por su título
func start_dialogue(title: String):
	# La comprobación 'if balloon == null' es ahora 100% fiable gracias a la señal tree_exited.
	if balloon == null:
		print("El globo no existe. Creando una nueva instancia.")
		balloon = BALLOON_SCENE.instantiate()
		add_child(balloon)
		
		# ¡¡LÓGICA CRÍTICA!! Nos conectamos a la señal que nos avisará cuando el globo se destruya.
		balloon.tree_exited.connect(_on_balloon_exited_tree)

	# Ahora que sabemos que el globo existe, iniciamos el diálogo en él.
	balloon.start(dialogue_resource, title, [GLOBAL])

# ¡NUEVA FUNCIÓN! Esta se ejecuta automáticamente cuando el globo se destruye.
func _on_balloon_exited_tree():
	print("El globo ha sido destruido. Limpiando la variable.")
	# Limpiamos nuestra variable para que la próxima llamada a start_dialogue sepa que debe crear uno nuevo.
	balloon = null

# Esta función se ejecuta CUANDO el script GLOBAL emite su señal.
func _on_numpad_requested_by_dialogue():
	numpad_ui.show()
	numpad_ui.get_node("Numpad").line_edit_input.text = ""

func _on_numpad_input_submitted(value: String):
	numpad_ui.hide()
	
	GLOBAL.numpad_input = value
	
	# Iniciamos el SEGUNDO diálogo para reaccionar al resultado.
	start_dialogue("reaccionar_a_pin")

func _on_numpad_cancelled():
	numpad_ui.hide()
	
	GLOBAL.numpad_input = ""
	
	start_dialogue("reaccionar_a_pin")

func _unhandled_input(event):
	if numpad_ui.visible and event.is_action_pressed("ui_accept"):
		get_tree().set_input_as_handled()
