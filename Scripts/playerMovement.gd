extends CharacterBody2D

@export var speed: float = 200.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var interact_area: Area2D = $InteractionArea

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO

	# Input del jugador
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	# Normalizar para movimiento diagonal
	if direction.length() > 0:
		direction = direction.normalized()
		velocity = direction * speed

		# --- Animación Walking ---
		anim.play("walking")

		# --- Flip horizontal ---
		if direction.x != 0:
			anim.flip_h = direction.x < 0

			# Girar el área de interacción también
			var flip_dir = -1 if anim.flip_h else 1
			interact_area.position.x = abs(interact_area.position.x) * flip_dir
	else:
		velocity = Vector2.ZERO
		anim.play("Idle")

	move_and_slide()
