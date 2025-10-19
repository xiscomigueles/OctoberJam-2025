extends Interactable

@export var dialogue_first: DialogueResource
@export var node_first: String
@export var dialogue_after: DialogueResource
@export var node_after: String

@onready var anim_paint:AnimatedSprite2D = $"../AnimatedSprite2D"


func _ready() -> void:
	change_paint()



func interact() -> void:
	if not Global.paint_reveal:
		#Primer dialogo
		DialogueManager.show_dialogue_balloon(dialogue_first, node_first)
		await DialogueManager.dialogue_ended
		anim_paint.play("Without")
		await anim_paint.animation_finished
		anim_paint.play("Idle2")
		Global.paint_reveal = true
	else:
		#Dialogo after
		DialogueManager.show_dialogue_balloon(dialogue_after, node_after)
		await DialogueManager.dialogue_ended
	interaction_ended.emit()

func change_paint():
	if Global.paint_reveal:
		anim_paint.play("Idle2")
	else:
		anim_paint.play("Idle")
