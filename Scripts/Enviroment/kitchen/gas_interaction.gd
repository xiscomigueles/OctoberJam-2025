extends Interactable

@export var dialogue: DialogueResource
@export var dialogue_node: String


func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_node)
	await DialogueManager.dialogue_ended
	interaction_ended.emit()
	Global.kitchen_gas = true
