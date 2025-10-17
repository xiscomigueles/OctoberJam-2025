extends Area2D

@export_file("*.tscn") var scene_path: String
@export var spawn_point_name: String

func _ready() -> void:
	if scene_path.is_empty():
		print("the scene path is empty")


func _on_body_entered(_body: Node2D) -> void:
	call_deferred("_change_scene")


func _change_scene() -> void:
	SceneManager.change_scene(scene_path, spawn_point_name)
