extends Sprite2D
class_name FakePlayer

@export var player : CharacterBody2D

func _physics_process(delta: float) -> void:
	
	position = lerp(position,player.global_position,0.5)
	
	
	if player.facingdir <= -1:
		flip_h = true
		pass
	else:
		flip_h = false
	
	pass
