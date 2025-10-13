extends CharacterBody2D

@export var speed = 200.0

func _physics_process(delta: float) -> void:

	var direction = Vector2.ZERO

	# User input
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	#Fix for diagonal movement; the player will move in the same speed

	if direction.length() > 0:
		direction = direction.normalized()

	velocity = direction * speed

	move_and_slide()
