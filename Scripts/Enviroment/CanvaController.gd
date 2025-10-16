extends Node2D

@onready var area: Area2D = $Area2D
@onready var anim: AnimatedSprite2D = $StaticBody2D/AnimatedSprite2D

var player_inside: bool = false
var animation_playing: bool = false
var has_discovered: bool = false  # 👈 Para que solo ocurra una vez

func _ready() -> void:
	# Conectamos señales del Area2D
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	anim.animation_finished.connect(_on_animation_finished) 

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):  # Usa grupos para identificar al jugador
		player_inside = true
		print("Player dentro del área")

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_inside = false
		print("Player salió del área")

func _process(delta: float) -> void:
	if player_inside and not has_discovered and not animation_playing:
		if Input.is_action_just_pressed("interact"):  # 👈 se activa solo UNA vez al pulsar E
			print("Activando animación discover...")
			animation_playing = true
			anim.play("discover")

func _on_animation_finished() -> void:
	if anim.animation == "discover":
		print("Animación discover terminada, cambiando a Idle2")
		anim.play("Idle2")
		has_discovered = true   # 👈 marca que ya se activó una vez
		animation_playing = false
