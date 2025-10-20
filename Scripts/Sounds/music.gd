extends Node

@export var cinematic_volume: float = -4.0

@export var game_music: AudioStream
@export var cinematic_music: AudioStream
@export var cimeatic_music_loop: AudioStream

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
	audio_player.finished.disconnect(_on_music_finished)
	
	audio_player.stop()
	audio_player.volume_db = cinematic_volume
	audio_player.stream = cinematic_music
	audio_player.play()
	
	await audio_player.finished
	audio_player.stream = cimeatic_music_loop
	audio_player.play()
	_set_music_loop()
