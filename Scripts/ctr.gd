extends CanvasLayer

@onready var glitch_shader: TextureRect = $"Glitch Shader"
@onready var glitch_timer: Timer = $"Glitch Timer"


func _ready() -> void:
	_hide_glitch()


func _hide_glitch() -> void:
	glitch_shader.visible = false


func play_glitch_effect(duration: float) -> void:
	glitch_shader.visible = true
	glitch_timer.wait_time = duration
	glitch_timer.start()
	await glitch_timer.timeout
	_hide_glitch()
