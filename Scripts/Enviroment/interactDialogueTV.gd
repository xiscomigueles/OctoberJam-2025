extends Interactable

@export var dialogue: DialogueResource
@export var dialogue_node: String
@export var room_type: Global.RoomType

func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_node)
	await DialogueManager.dialogue_ended
	DarkManager.swap_to_dark(room_type)
	interaction_ended.emit()
