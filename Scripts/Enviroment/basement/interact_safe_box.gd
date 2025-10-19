extends Interactable

@export var dialogue: DialogueResource
@export var node_no_key: String
@export var node_key: String
@onready var numpad: Numpad = $"../NumpadUI"


func _ready() -> void:
	numpad.hide()


func interact() -> void:
	_show_dialogue()
	await DialogueManager.dialogue_ended
	if not Global.has_basement_key:
		numpad.show()
		await numpad.ended
	interaction_ended.emit()
	print("Has key? " + str(Global.has_basement_key))


func _show_dialogue() -> void:
	var node: String = node_no_key
	if Global.has_basement_key:
		node = node_key
	DialogueManager.show_dialogue_balloon(dialogue, node)
