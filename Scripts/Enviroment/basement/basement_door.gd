extends Interactable

@onready var audio_player: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@export var dialogue: DialogueResource
@export var node_no_key: String
@export var node_key: String

func _ready() -> void:
	_update_state()


func interact() -> void:
	if not Global.has_basement_key:
		DialogueManager.show_dialogue_balloon(dialogue, node_no_key)
		await DialogueManager.dialogue_ended
	else:
		DialogueManager.show_dialogue_balloon(dialogue, node_key)
		await DialogueManager.dialogue_ended
		Global.basement_door_open = true
		_open(true)
	
	interaction_ended.emit()


func _update_state() -> void:
	if Global.basement_door_open:
		_open(false)


func _open(with_sound: bool) -> void:
	if with_sound:
		audio_player.play()
		await audio_player.finished
	get_parent().queue_free()
