class_name PlayerInteraction extends Area2D

@onready var input_label: Label = $"../Input Label"
@onready var movement: PlayerMovement = $".."

var object_to_interact: Interactable = null
var can_interact: bool = true


func _ready() -> void:
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


func _disable_input() -> void:
	can_interact = false
	movement.can_move = false


func _enable_input() -> void:
	can_interact = true
	movement.can_move = true


func _interact() -> void:
	if object_to_interact == null or not can_interact:
		return
	
	_disable_input()
	object_to_interact.interact()
	await object_to_interact.interaction_ended
	print("interaction ended")
	_enable_input()


func show_input() -> void:
	input_label.visible = true


func hide_input() -> void:
	input_label.visible = false
