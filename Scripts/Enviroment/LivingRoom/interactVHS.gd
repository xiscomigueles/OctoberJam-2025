extends Interactable

@export var dialogue: DialogueResource
@export var dialogue_node: String


func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_node)
	await DialogueManager.dialogue_ended
	Global.has_VHS = true
	get_parent().queue_free()
	interaction_ended.emit()
