extends Node2D

@export var player: CharacterBody2D

# Nombre de la puerta por la que entra el jugador en esta escena
@export var entry_door: String = "puertaSotano"
@export var position_default = Vector2()

func _ready():
	var start_pos = GLOBAL.get_position(get_tree().current_scene.name, entry_door)
	if start_pos != Vector2():
		player.position = start_pos
		print("👣 Posición del jugador:", player.position)
	else:
		player.position = position_default # Posición por defecto
		print("👣 Posición inicial del jugador:", player.position)
