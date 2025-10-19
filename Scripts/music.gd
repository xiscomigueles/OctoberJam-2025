extends Node

@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D


func _ready() -> void:
	audio_player.play()
	audio_player.finished.connect(_on_music_finished)


func _on_music_finished() -> void:
	print("loop music")
	audio_player.play()
