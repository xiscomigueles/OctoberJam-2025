extends Node2D

# @export para que puedas seleccionar la tecla directamente en el Inspector de Godot
# Key es un enum que contiene todas las teclas posibles (KEY_E, KEY_F, etc.)
@export var interaction_key: Key = KEY_E # Por defecto, la tecla 'E'

var overlapping_body: CharacterBody2D = null # Referencia al cuerpo (Player) que está superponiendo la moneda

func _on_interaction_area_body_entered(body: Node2D) -> void:
	# Asegurarse de que el cuerpo que entra es el jugador (o el tipo de cuerpo que nos interesa)
	if body is CharacterBody2D:
		overlapping_body = body as CharacterBody2D
		print("Player entró en el área de la moneda. Ahora puedes interactuar.")

func _on_interaction_area_body_exited(body: Node2D) -> void:
	# Limpiar la referencia si el cuerpo que sale es el que teníamos guardado
	if body == overlapping_body:
		overlapping_body = null
		print("Player salió del área de la moneda. No puedes interactuar.")

func _process(delta: float) -> void:
	# Si hay un jugador en el área Y la tecla de interacción es presionada
	# Usamos Input.is_physical_key_pressed() o Input.is_key_pressed() con el enum Key
	if overlapping_body != null and Input.is_physical_key_pressed(interaction_key):
		print("¡Moneda recogida por el jugador al presionar la tecla!")
		queue_free() # Elimina la moneda de la escena
		# Aquí podrías emitir una señal si quieres que otro nodo (como un GameManager)
		# sepa que la moneda ha sido recogida.
