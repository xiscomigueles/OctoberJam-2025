extends Node

@export var dialogue: DialogueResource
@export var dialogue_node: String
@onready var timer: Timer = $Timer

func _ready() -> void:
	if not Global.kitchen_dialogue_displayed:
		timer.timeout.connect(_play_dialogue)

func _play_dialogue() -> void:
	Global.disable_input()
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_node)
	await DialogueManager.dialogue_ended
	Global.enable_input()
	Global.kitchen_dialogue_displayed = true
