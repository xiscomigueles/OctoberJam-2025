class_name Interactable extends Area2D

@export var dialogue: DialogueResource

@onready var input_label: Label = $"../Input Label"


func _ready() -> void:
	input_label.visible = false
	input_label.text = InputUtils.get_action_key_string("interact")


func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue)
