extends Node

@export_file("*.tscn") var scene_path: String

func _ready() -> void:
	if scene_path.is_empty():
		print("the scene path is empty")


func _on_body_entered(body: Node2D) -> void:
	SceneManager.change_scene(scene_path)
