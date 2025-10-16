class_name Interactable extends Area2D

@export var dialogue: DialogueResource


func show_input() -> void:
	print("show interaction with key E")


func hide_input() -> void:
	print("hide interaction with key E")


func interact() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue)
