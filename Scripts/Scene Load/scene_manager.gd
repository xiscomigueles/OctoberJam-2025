# autoload script

extends Node

const PLAYER_SCENE: PackedScene = preload("res://Scenes/Player.tscn")
const Y_SORT_NODE_NAME: String = "Y Sorting"
const DEFAULT_SPAWN_NAME = "Default"
const SPAWNS_NODE_NAME = "SpawnPoints"

func _ready() -> void:
	_spawn_player()


func change_scene(scene_path: String, spawn_point: String = "") -> void:
	get_tree().change_scene_to_file(scene_path)
	await get_tree().scene_changed
	_spawn_player(spawn_point)


func _spawn_player(spawn_point: String = "") -> void:
	var y_sort_node = _get_y_sort_node()
	if y_sort_node == null:
		printerr("Cannot spawn player.")
		return
	
	var player: Node2D = PLAYER_SCENE.instantiate()
	var position: Vector2 = _get_spawn_position(spawn_point)
	
	player.global_position = position
	y_sort_node.add_child(player)


func _get_y_sort_node() -> Node:
	var y_sort_node: Node = get_tree().current_scene.get_node_or_null(Y_SORT_NODE_NAME)
	
	if y_sort_node == null:
		printerr(Y_SORT_NODE_NAME + " node not found.")
		return null
		
	return y_sort_node


func _get_spawn_position(spawn_point: String = "") -> Vector2:
	if spawn_point.is_empty():
		print("Searching defualt spawn.")
		return _get_spawn_node(DEFAULT_SPAWN_NAME).position
	else:
		return _get_spawn_node(spawn_point).position


func _get_spawn_node(node_name: String) -> Node2D:
	var path = Y_SORT_NODE_NAME + "/" + SPAWNS_NODE_NAME + "/" + node_name
	var node = get_tree().current_scene.get_node_or_null(path)
	if node == null:
		printerr("Node " + path + "does not exit.")
	return node
