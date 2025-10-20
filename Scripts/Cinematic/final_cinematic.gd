extends Node2D

@onready var tv_static_anim: AnimatedSprite2D = $"TV Static Animation"

func _ready() -> void:
	Music.play_cinematic_music()
	tv_static_anim.play()
