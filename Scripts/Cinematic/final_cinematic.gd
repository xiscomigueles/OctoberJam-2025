extends Node2D

@export var dialogue: DialogueResource
@export var start_node: String
@export var ballon_cinematic_path: String = "res://Pruebas/balloon_cinematic.tscn"


@onready var tv_static_anim: AnimatedSprite2D = $"TV Static Animation"
@onready var reveal_anim: AnimatedSprite2D = $"Reveal Animation"
@onready var bodies_anim: AnimatedSprite2D = $"Bodies Animation"

const cinematic_parts: int = 4
var current_part: int = 0

func _ready() -> void:
	Music.play_cinematic_music()
	DialogueManager.passed_title.connect(_on_passed_title)
	DialogueManager.show_dialogue_balloon_scene(ballon_cinematic_path, dialogue, start_node)


func _on_passed_title(_title: String) -> void:
	current_part += 1
	_change_anim()


func _change_anim() -> void:
	match current_part:
		1:
			_play_tv_static_anim()
		2:
			_play_reveal_anim()
		3:
			_play_bodies_anim()


func _play_tv_static_anim() -> void:
	tv_static_anim.visible = true
	reveal_anim.visible = false
	bodies_anim.visible = false
	
	tv_static_anim.play()


func _play_reveal_anim() -> void:
	tv_static_anim.visible = false
	reveal_anim.visible = true
	bodies_anim.visible = false
	
	reveal_anim.play()


func _play_bodies_anim() -> void:
	tv_static_anim.visible = false
	reveal_anim.visible = false
	bodies_anim.visible = true
	
	CTR.play_glitch_effect(0.2)
	bodies_anim.play()
