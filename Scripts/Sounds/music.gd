extends Node

@export var game_music: AudioStream
@export var cinematic_music: AudioStream

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	_set_music_loop()
	play_game_music()


func _set_music_loop() -> void:
	audio_player.finished.connect(_on_music_finished)


func _on_music_finished() -> void:
	audio_player.play()


func play_game_music() -> void:
	audio_player.stop()
	audio_player.stream = game_music
	audio_player.play()


func play_cinematic_music() -> void:
	audio_player.stop()
	audio_player.stream = cinematic_music
	audio_player.play()
