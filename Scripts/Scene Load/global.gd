extends Node

enum RoomType { SOTANO, KITCHEN }

var has_basement_key: bool = false
var basement_door_open: bool = false
var paint_reveal: bool = false
var has_homer_simpson: bool = false
var door_kitchen_open: bool = false
var kitchen_gas: bool = false
var kitchen_dialogue_displayed: bool = false

var has_remote : bool = false
var has_VHS: bool = false

var can_move: bool = true
var can_interact: bool = true



func enable_input() -> void:
	can_move = true
	can_interact = true


func disable_input() -> void:
	can_move = false
	can_interact = false
