extends Node2D # ¡IMPORTANTE! Ahora extendemos Node2D

@export var interaction_key: Key = KEY_E # Default key to interact.
@export var proximity_radius: float = 80.0 # Proximity radious.

var overlapping_body: CharacterBody2D = null # Referencia to overlapping player.

# References the collision shapes, for easier access.
@onready var proximity_collision_shape: CollisionShape2D = $InteractionArea/ProximityCollision
@onready var physical_collision_shape: CollisionShape2D = $CoinBody/PhysicalCollision


func _ready() -> void:
	if not proximity_collision_shape:
		printerr("ERROR: No se encontró 'ProximityCollision' bajo 'InteractionArea'.")
		return
	if not physical_collision_shape:
		printerr("ERROR: No se encontró 'PhysicalCollision' bajo 'CoinBody'.")
		return

	# Set up the size from the CollisionShape of the proximity,
	var shape = proximity_collision_shape.shape
	if shape is CircleShape2D:
		shape.radius = proximity_radius
	elif shape is RectangleShape2D:
		shape.size = Vector2(proximity_radius * 2, proximity_radius * 2)
	print("Tamaño del ProximityCollision de la moneda ajustado a:", proximity_radius)

	#Debug for the new values.
	if physical_collision_shape.shape is CircleShape2D:
		print("Radio del PhysicalCollision:", (physical_collision_shape.shape as CircleShape2D).radius)
	elif physical_collision_shape.shape is RectangleShape2D:
		print("Tamaño del PhysicalCollision:", (physical_collision_shape.shape as RectangleShape2D).size)


func _on_interaction_area_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		overlapping_body = body as CharacterBody2D
		print("Player in range.")

func _on_interaction_area_body_exited(body: Node2D) -> void:
	if body == overlapping_body:
		overlapping_body = null
		print("Player out of range.")

func _process(delta: float) -> void:
	if overlapping_body != null and Input.is_physical_key_pressed(interaction_key):
		print("Taken out.")
		queue_free()
