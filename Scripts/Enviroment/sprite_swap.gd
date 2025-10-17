extends Node2D

@onready var regular_sprite = $Regular
@onready var dark_sprite = $Dark


func _ready() -> void:
	swap_to_regular()


func swap_to_regular() -> void:
	regular_sprite.visible = true
	dark_sprite.visible = false


func swap_to_dark() -> void:
	regular_sprite.visible = false
	dark_sprite.visible = true
