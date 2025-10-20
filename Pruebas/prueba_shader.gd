extends Node2D

@export var dialogue: DialogueResource


func _ready() -> void:
	DialogueManager.show_dialogue_balloon(dialogue)
