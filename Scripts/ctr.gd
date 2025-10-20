extends CanvasLayer

@export var glitch_duration: float = 1.0

@onready var glitch_shader: TextureRect = $"Glitch Shader"
@onready var glitch_timer: Timer = $"Glitch Timer"


func _ready() -> void:
	_hide_glitch()


func _hide_glitch() -> void:
	glitch_shader.visible = false


func play_glitch_effect() -> void:
	glitch_shader.visible = true
	glitch_timer.wait_time = glitch_duration
	glitch_timer.start()
	await glitch_timer.timeout
	_hide_glitch()
