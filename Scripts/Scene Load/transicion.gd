extends CanvasLayer


func change_scene(path: String) -> void:
	call_deferred("_deferred_change_scene", path)

func _deferred_change_scene(path: String) -> void:
	get_tree().change_scene_to_file(path)
