extends CharacterBody2D
class_name BaseBullet

@export var SpriteNode : Sprite2D
@export var SpriteImg : Texture2D
@export var bullettimer : Timer


var bulletspeed


func _ready() -> void:
	
	bullettimer.start()
	
	pass

func destroybullet():
	
	queue_free()
	pass


func set_speed(speed : int):
	
	bulletspeed = speed
	
	pass

func _physics_process(delta: float) -> void:
	
	
	velocity.x += bulletspeed
	
	if abs(velocity.x) >= abs(bulletspeed):
		velocity.x = bulletspeed
	
	var collisions = move_and_collide(velocity)
	
	if collisions != null or bullettimer.is_stopped():
		destroybullet()
	
	pass
