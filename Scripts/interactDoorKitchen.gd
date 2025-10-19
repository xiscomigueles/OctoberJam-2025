extends Interactable

@export var dialogue_first: DialogueResource
@export var node_first: String

@onready var anim_door:AnimatedSprite2D = $"../AnimatedSprite2D"


func _ready() -> void:
	change_door()



func interact() -> void:
	if not Global.has_homer_simpson:
		#Dialogo no tengo martillo
		DialogueManager.show_dialogue_balloon(dialogue_first, node_first)
		await DialogueManager.dialogue_ended
	else:
		#Abrimos puerta
		anim_door.play("Wood")
		await anim_door.animation_finished
		anim_door.play("Idle2")
	interaction_ended.emit()

func change_door():
	if Global.paint_reveal:
		anim_door.play("Idle2")
	else:
		anim_door.play("Idle")
