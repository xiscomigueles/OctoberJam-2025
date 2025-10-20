class_name NumpadAudio extends AudioStreamPlayer2D

@export var button_sound: AudioStream


func play_button_sound() -> void:
	assert(button_sound != null)
	stream = button_sound
	play()
