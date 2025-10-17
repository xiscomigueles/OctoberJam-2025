# aoutload script

extends Node

func change_scene(scene_path: String) -> void:
	get_tree().change_scene_to_file(scene_path)
