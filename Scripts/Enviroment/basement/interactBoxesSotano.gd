extends Interactable

@export var dialogue_first: DialogueResource
@export var node_first: String
@export var dialogue_after: DialogueResource
@export var node_after: String


func interact() -> void:
	if not Global.basement_door_open:
		#Primer dialogo
		DialogueManager.show_dialogue_balloon(dialogue_first, node_first)
		await DialogueManager.dialogue_ended
	else:
		#Dialogo after
		DialogueManager.show_dialogue_balloon(dialogue_after, node_after)
		await DialogueManager.dialogue_ended
		Global.has_homer_simpson = true
	interaction_ended.emit()
