extends Interactable

@export var dialogue: DialogueResource
@export var dialogue_node: String

func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_node)
	await DialogueManager.dialogue_ended

	var dark_controller = get_tree().get_root().find_child("Sotano", true, false)
	if dark_controller:
		dark_controller.swap_to_dark()

	interaction_ended.emit()
