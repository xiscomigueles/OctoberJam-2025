extends Interactable

@export var dialogue: DialogueResource
@export var dialogue_node: String


func _ready() -> void:
	if Global.has_VHS:
		get_parent().queue_free()

func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_node)
	await DialogueManager.dialogue_ended
	Global.has_VHS = true
	get_parent().queue_free()
	interaction_ended.emit()
