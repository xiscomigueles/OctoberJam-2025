extends CharacterBody2D

@export var speed: float = 50.0

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

var mov_input: Vector2 = Vector2.ZERO
var can_move: bool = true

func _process(_delta: float) -> void:
	mov_input = read_mov_input()
	play_animation()
	flip_player()


func _physics_process(_delta: float) -> void:
	velocity = mov_input * speed
	move_and_slide()


func read_mov_input() -> Vector2:
	var input = Vector2(
			Input.get_axis("ui_left", "ui_right"),
			Input.get_axis("ui_up", "ui_down")
		).normalized()
	return input


func play_animation() -> void:
	if velocity == Vector2.ZERO:
		anim.play("Idle")
	else:
		anim.play("walking")


func flip_player() -> void:
	if mov_input.x != 0:
		anim.flip_h = mov_input.x < 0
