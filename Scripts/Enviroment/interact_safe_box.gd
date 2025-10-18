extends Interactable

@export var dialogue: DialogueResource
@onready var numpad: Numpad = $"../NumpadUI"


func _ready() -> void:
	numpad.hide()


func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue)
	await DialogueManager.dialogue_ended
	numpad.show()
	await numpad.ended
	interaction_ended.emit()
