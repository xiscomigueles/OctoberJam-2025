# aoutload script

extends Node

func change_scene(scene_path: String) -> void:
	print("change scene to: " + scene_path)
	get_tree().change_scene_to_file(scene_path)
