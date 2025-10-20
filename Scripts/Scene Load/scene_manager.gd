# autoload script - scene_manager.gd (VERSIÓN CORRECTA Y FINAL)
extends Node

const PLAYER_SCENE: PackedScene = preload("res://Scenes/Player.tscn")
const Y_SORT_NODE_NAME: String = "Y Sorting"
const DEFAULT_SPAWN_NAME: String = "Default"
const SPAWNS_NODE_NAME = "SpawnPoints"
@export var final_scene_path: String = "res://Scenes/final_cinematic.tscn"


func _ready() -> void:
	_spawn_player()


func change_to_final_scene() -> void:
	change_scene(final_scene_path)


func change_scene(scene_path: String, spawn_point: String = "") -> void:
	get_tree().change_scene_to_file(scene_path)
	await get_tree().scene_changed
	_spawn_player(spawn_point)


func _spawn_player(spawn_point: String = "") -> void:
	var y_sort_node = _get_y_sort_node()
	if y_sort_node == null:
		printerr("Cannot spawn player. 'Y Sorting' node not found in the current scene.")
		return
	
	var player: Node2D = PLAYER_SCENE.instantiate()
	var position = _get_spawn_position(spawn_point)
	
	player.global_position = position
	y_sort_node.add_child(player)


func _get_y_sort_node() -> Node:
	return get_tree().current_scene.get_node_or_null(Y_SORT_NODE_NAME)


func _get_spawn_position(spawn_point: String = "") -> Vector2:
	var spawn_node = _get_spawn_node(DEFAULT_SPAWN_NAME if spawn_point.is_empty() else spawn_point)
	if is_instance_valid(spawn_node):
		return spawn_node.position
	
	printerr("Spawn point not found. Spawning player at Vector2.ZERO.")
	return Vector2.ZERO


func _get_spawn_node(node_name: String) -> Node2D:
	var path = Y_SORT_NODE_NAME + "/" + SPAWNS_NODE_NAME + "/" + node_name
	var node = get_tree().current_scene.get_node_or_null(path)
	if node == null:
		printerr("Spawn node at path '" + path + "' does not exist.")
	return node
