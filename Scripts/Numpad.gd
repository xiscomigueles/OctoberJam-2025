# res://Scripts/Numpad.gd
extends Control

# Señales personalizadas para comunicar el valor final y la cancelación
signal input_submitted(value)
signal numpad_cancelled

@onready var line_edit_input: LineEdit = $VBox_Main/LineEdit_Input
var max_input_length = 9 # Define la longitud máxima permitida para el input

func _ready():
	# Inicializa la pantalla de input
	line_edit_input.text = ""
	# Conecta los botones numéricos y de acción
	_connect_buttons()

func _connect_buttons():
	# Conecta los botones numéricos
	for child in $VBox_Main/Grid_Buttons.get_children():
		if child is Button:
			if child.text.is_valid_int(): # Si el texto del botón es un número
				child.pressed.connect(Callable(self, "_on_number_button_pressed").bind(child.text))
			elif child.name == "ButtonClear":
				child.pressed.connect(_on_ButtonClear_pressed)
			elif child.name == "ButtonOK":
				child.pressed.connect(_on_ButtonOK_pressed)

# Función genérica para manejar los botones numéricos
func _on_number_button_pressed(number_char: String):
	if line_edit_input.text.length() < max_input_length:
		line_edit_input.text += number_char

# Maneja el botón "Clear"
func _on_ButtonClear_pressed():
	line_edit_input.text = ""

# Maneja el botón "OK"
func _on_ButtonOK_pressed():
	var input_value = line_edit_input.text
	if not input_value.is_empty():
		emit_signal("input_submitted", input_value)
		# Opcional: Reiniciar el numpad después de enviar
		line_edit_input.text = ""
	else:
		# Puedes añadir alguna retroalimentación visual si el campo está vacío
		print("Numpad: Campo vacío, no se envía nada.")

# Función opcional para ocultar el numpad y emitir una señal de cancelación
func cancel_numpad():
	line_edit_input.text = ""
	emit_signal("numpad_cancelled")
	# Por ejemplo, hide() si el numpad es un popup
	# hide()
