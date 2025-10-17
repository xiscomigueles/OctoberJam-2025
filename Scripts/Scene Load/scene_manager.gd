# aoutload script

extends Node

const PLAYER_SCENE: PackedScene = preload("res://Scenes/player.tscn")
const Y_SORT_NODE_NAME: String = "Y Sorting"

func _ready() -> void:
	_spawn_player()


func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
	await get_tree().scene_changed
	_spawn_player()


func _spawn_player() -> void:
	var y_sort_node = get_tree().current_scene.get_node_or_null(Y_SORT_NODE_NAME)
	if y_sort_node == null:
		print("y sort node not found")
	else:
		print("y sort node found")
	
	var player: Node2D = PLAYER_SCENE.instantiate()
	player.global_position = Vector2(80, 100)
	y_sort_node.add_child(player)
