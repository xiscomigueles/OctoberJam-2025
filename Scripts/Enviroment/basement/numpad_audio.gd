class_name NumpadAudio extends AudioStreamPlayer2D

@export var button_sound: AudioStream
@export var open_safe_sound: AudioStream


func play_button_sound() -> void:
	_play_sound(button_sound)


func play_open_safe_sound() -> void:
	_play_sound(open_safe_sound)


func _play_sound(audio: AudioStream) -> void:
	assert(audio != null)
	stream = audio
	play()
