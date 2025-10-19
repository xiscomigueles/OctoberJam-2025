extends Interactable

@export_file("*.tscn") var scene_path: String
@export var spawn_point_name: String

@export var dialogue_first: DialogueResource
@export var node_first: String

@export var dialogue_gas: DialogueResource
@export var node_gas: String

@onready var door_anim: AnimatedSpriteSwap = $"../Sprites"
@onready var audio_player: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

enum State { CLOSED, OPEN }

var state: State

func _ready() -> void:
	_update_state()


func interact() -> void:
	match state:
		State.CLOSED:
			await _close_interaction()
		State.OPEN:
			_open_interaction()
	interaction_ended.emit()


func _update_state() -> void:
	if Global.door_kitchen_open:
		state = State.OPEN
		door_anim.animated_sprite.play("Idle2")
	else:
		state = State.CLOSED
		door_anim.animated_sprite.play("Idle")


func _close_interaction() -> void:
	if not Global.has_homer_simpson:
		DialogueManager.show_dialogue_balloon(dialogue_first, node_first)
		await DialogueManager.dialogue_ended
	elif not Global.kitchen_gas:
		DialogueManager.show_dialogue_balloon(dialogue_gas, node_gas)
		await DialogueManager.dialogue_ended
	else:
		await _open_door()



func _open_door() -> void:
	audio_player.play()
	door_anim.animated_sprite.play("Wood")
	await door_anim.animated_sprite.animation_finished
	door_anim.animated_sprite.play("Idle2")
	state = State.OPEN
	Global.door_kitchen_open = true


func _open_interaction() -> void:
	call_deferred("_change_scene")


func _change_scene() -> void:
	SceneManager.change_scene(scene_path, spawn_point_name)
