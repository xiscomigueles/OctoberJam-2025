extends Node

var positions : Dictionary = {}

signal numpad_requested_by_dialogue

func request_numpad():
	print("GLOBAL: 'request_numpad' llamado por el diálogo. Emitiendo señal global.")
	# Su única responsabilidad es notificar al resto del juego.
	emit_signal("numpad_requested_by_dialogue")

func save_position(scene_name: String, door_name: String, pos: Vector2):
	var key = scene_name + "_" + door_name
	positions[key] = pos
	print("✅ Guardado:", key, "=", pos)

func get_position(scene_name: String, door_name: String) -> Vector2:
	var key = scene_name + "_" + door_name
	if positions.has(key):
		print("📦 Recuperado:", key, "=", positions[key])
		return positions[key]
	print("⚠️ No hay posición guardada para:", key)
	return Vector2()
