class_name InteractDialogue extends Interactable

@export var dialogue: DialogueResource


func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue)
	await DialogueManager.dialogue_ended
	interaction_ended.emit()
