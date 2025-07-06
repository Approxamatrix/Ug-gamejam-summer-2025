extends Sprite2D
class_name FakePlayer

@export var player : CharacterBody2D

func _physics_process(delta: float) -> void:
	
	position = lerp(position,player.global_position,0.8)
	
	pass
