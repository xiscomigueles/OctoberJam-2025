extends Area2D

var object_to_interact: Interactable = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and object_to_interact != null:
		object_to_interact.interact()


func _on_area_entered(area: Area2D) -> void:
	if area is Interactable:
		area.show_input()
		object_to_interact = area


func _on_area_exited(area: Area2D) -> void:
	if area is Interactable:
		area.hide_input()
		object_to_interact = null
