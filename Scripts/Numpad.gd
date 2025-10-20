class_name Numpad extends CanvasLayer

signal ended()

@onready var line_edit_input: LineEdit = $"Container/Vertical Box/LineEdit Input"
@onready var grid: GridContainer = $"Container/Vertical Box/Grid"
@onready var audio: NumpadAudio = $AudioStreamPlayer2D

@export var max_input_length = 3
@export var combination: String = "123"

var is_open: bool = false

func _ready():
	_clear(false)
	_connect_buttons()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("cancel"):
		hide()
		ended.emit()


func _connect_buttons():
	for child in grid.get_children():
		if child is Button:
			if child.text.is_valid_int():
				child.pressed.connect(_on_number_button_pressed.bind(child.text))
			elif child.name == "Clear":
				child.pressed.connect(_clear)
			elif child.name == "OK":
				child.pressed.connect(_on_ok_pressed)


func _on_number_button_pressed(number_char: String):
	if line_edit_input.text.length() > max_input_length:
		return
	var index: int = line_edit_input.text.find("*")
	if index != -1:
		audio.play_button_sound()
		line_edit_input.text[index] = number_char


func _clear(with_sfx: bool = true):
	line_edit_input.text = "***"
	if with_sfx:
		audio.play_reset_beep()


func _on_ok_pressed():
	var input_value: String = line_edit_input.text
	if _check_combination(input_value):
		_open()
	else:
		audio.play_incorrect_beep()
		_clear(false)


func _open() -> void:
	Global.has_basement_key = true
	is_open = true
	hide()
	ended.emit()
	audio.play_open_safe_sound()


func _check_combination(input: String) -> bool:
	var nums1 = combination.split("")
	var nums2 = input.split("")
	
	nums1.sort()
	nums2.sort()
	
	return nums1 == nums2
