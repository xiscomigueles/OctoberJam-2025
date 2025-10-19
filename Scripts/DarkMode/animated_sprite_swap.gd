class_name AnimatedSpriteSwap extends SpriteSwap


var animated_sprite: AnimatedSprite2D:
	get:
		if DarkManager.is_room_dark(room_type):
			return dark_sprite as AnimatedSprite2D
		else:
			return regular_sprite as AnimatedSprite2D
