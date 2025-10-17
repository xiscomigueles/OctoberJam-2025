extends Node

@export_file("*.tscn") var scene_path: String

func _ready() -> void:
	if scene_path.is_empty():
		print("the scene path is empty")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		SceneManager.change_scene(scene_path)
