extends Area2D

@export var target_scene: String = "res://Scenes/GameplayKitchen.tscn"


func _on_body_entered(body: CharacterBody2D) -> void:
	print("Colisión detectada con:", body.name)
	if body.is_in_group("player"):
		print("Es el player, cambiando escena...")
		# Bloquea movimiento
		body.can_move = false
		
		var transition = get_tree().root.get_node("Transicion")
		if transition:
			await(transition.change_scene(target_scene))
			body.can_move = true
		else:
			print("No se encontró el nodo Transicion") 
