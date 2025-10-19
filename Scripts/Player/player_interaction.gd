class_name PlayerInteraction extends Area2D

@onready var input_label: Label = $"../Input Label"

var object_to_interact: Interactable = null


func _ready() -> void:
	Global.enable_input()
	hide_input()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		_interact()


func _on_area_entered(area: Area2D) -> void:
	if area is Interactable:
		show_input()
		object_to_interact = area


func _on_area_exited(area: Area2D) -> void:
	if area is Interactable:
		hide_input()
		object_to_interact = null


func _interact() -> void:
	if object_to_interact == null or not Global.can_interact:
		return
	
	Global.disable_input()
	object_to_interact.interact()
	await object_to_interact.interaction_ended
	print("interaction ended")
	Global.enable_input()


func show_input() -> void:
	print("show input")
	input_label.visible = true


func hide_input() -> void:
	print("hide input")
	input_label.visible = false
