extends Node2D

@export var static_sound: AudioStream

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func play_static_sound() -> void:
	_play_sfx(static_sound)


func _play_sfx(sfx: AudioStream) -> void:
	assert(sfx != null)
	audio_player.stream = sfx
	audio_player.play()
