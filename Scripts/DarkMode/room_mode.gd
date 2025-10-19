class_name RoomMode

signal set_dark_active()
var dark_active: bool = false


func swap_to_dark_mode() -> void:
	dark_active = true
	set_dark_active.emit()
