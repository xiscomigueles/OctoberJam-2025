extends Node

var sotano_mode: RoomMode = RoomMode.new()
var kitchen_mode: RoomMode = RoomMode.new()


func swap_to_dark(room_type: Global.RoomType) -> void:
	match room_type:
		Global.RoomType.SOTANO:
			sotano_mode.swap_to_dark_mode()
		Global.RoomType.KITCHEN:
			kitchen_mode.swap_to_dark_mode()


func is_room_dark(room_type: Global.RoomType) -> bool:
	match room_type:
		Global.RoomType.SOTANO:
			return sotano_mode.dark_active
		Global.RoomType.KITCHEN:
			return kitchen_mode.dark_active
	return false


func connect_to_dark_swap(room_type: Global.RoomType, object: Object, method: String) -> void:
	match room_type:
		Global.RoomType.SOTANO:
			sotano_mode.set_dark_active.connect(Callable(object, method))
		Global.RoomType.KITCHEN:
			kitchen_mode.set_dark_active.connect(Callable(object, method))
