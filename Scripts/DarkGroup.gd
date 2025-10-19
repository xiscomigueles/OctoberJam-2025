extends Node2D

@export var regular_sprite: Sprite2D
@export var dark_sprite: Sprite2D

func _ready() -> void:
	swap_to_regular()
	add_to_group("dark_objects") 

func swap_to_regular() -> void:
	regular_sprite.visible = true
	dark_sprite.visible = false

func swap_to_dark() -> void:
	regular_sprite.visible = false
	dark_sprite.visible = true
