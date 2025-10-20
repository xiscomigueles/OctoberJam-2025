extends Interactable

@export var dialogue: DialogueResource
@export var dialogue_node: String
@export var room_type: Global.RoomType

func interact() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_node)
	SFX.play_static_sound()
	await DialogueManager.dialogue_ended
	if Global.tv_sotano != true:
		DarkManager.swap_to_dark(room_type)
		SFX.play_static_sound()
		CTR.play_glitch_effect(0.5)
		Global.tv_sotano = true
	interaction_ended.emit()
