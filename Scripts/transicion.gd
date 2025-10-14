extends CanvasLayer

@onready var anim: AnimationPlayer = $AnimationPlayer

# Emite una señal cuando termina la transición
signal transition_finished

func _ready() -> void:
	layer = -1

func change_scene(path: String) -> void:
	layer = 1
	anim.play("Trans")

	# Espera a que acabe la animación antes de cambiar la escena
	await anim.animation_finished
	get_tree().change_scene_to_file(path)

	# Reproduce la animación al revés (salida)
	anim.play_backwards("Trans")
	await anim.animation_finished

	layer = -1
	emit_signal("transition_finished")
