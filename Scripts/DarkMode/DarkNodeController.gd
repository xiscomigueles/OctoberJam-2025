# DarkModeController.gd
extends Node2D

func swap_to_dark() -> void:
	for child in get_tree().get_nodes_in_group("dark_objects"):
		child.swap_to_dark()


func swap_to_regular() -> void:
	for child in get_tree().get_nodes_in_group("dark_objects"):
		child.swap_to_regular()
