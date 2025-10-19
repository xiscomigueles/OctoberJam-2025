class_name SpriteSwap extends Node2D

@onready var regular_sprite = $Regular
@onready var dark_sprite = $Dark
@export var room_type: Global.RoomType


func _ready() -> void:
	DarkManager.connect_to_dark_swap(room_type, self, "swap_to_dark")
	if DarkManager.is_room_dark(room_type):
		swap_to_dark()
	else:
		swap_to_regular()


func swap_to_regular() -> void:
	regular_sprite.visible = true
	dark_sprite.visible = false


func swap_to_dark() -> void:
	regular_sprite.visible = false
	dark_sprite.visible = true
