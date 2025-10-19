extends Interactable

@export var dialogue: DialogueResource
@export var dialogue_node: String


func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_node)
	await DialogueManager.dialogue_ended
	Global.has_remote = true
	queue_free()
	interaction_ended.emit()
