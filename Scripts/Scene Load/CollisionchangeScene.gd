extends Area2D

@export var target_scene: String = "res://Scenes/GameplayKitchen.tscn"
@export var door_name: String = "puertaSotano"  # identifica esta puerta

func _on_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("player"):
		body.can_move = false

		# 👉 Guardamos la posición actual ANTES de cambiar de escena
		GLOBAL.save_position(get_tree().current_scene.name, door_name, body.position)

		var transition = get_tree().root.get_node("Transicion")
		if transition:
			await transition.change_scene(target_scene)
			body.can_move = true
		else:
			get_tree().change_scene_to_file(target_scene)
			body.can_move = true
			print("No se encontró el nodo Transicion")
