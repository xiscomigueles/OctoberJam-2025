extends Node

var positions : Dictionary = {}


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
