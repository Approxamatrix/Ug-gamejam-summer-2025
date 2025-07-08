extends CharacterBody2D
class_name BaseBullet



@export var damage : int
@export var SpriteNode : Sprite2D
@export var SpriteImg : Texture2D
@export var bullettimer : Timer
@export var Hurtbox : Area2D

var xbulletspeed
var ybulletspeed = 0


func _ready() -> void:
	
	bullettimer.start()
	
	pass

func destroybullet():
	
	queue_free()
	pass


func set_speed(xspeed : int, yspeed : int):
	
	xbulletspeed = xspeed
	ybulletspeed = yspeed
	pass

func _physics_process(delta: float) -> void:
	
	
	velocity.x += xbulletspeed
	velocity.y += ybulletspeed
	
	if abs(velocity.x) >= abs(xbulletspeed):
		velocity.x = xbulletspeed
		
	
	if abs(velocity.y) >= abs(ybulletspeed):
		velocity.y = ybulletspeed
	
	var collisions = move_and_collide(velocity)
	
	if collisions != null or bullettimer.is_stopped():
		destroybullet()
	
	pass
	
	move_and_collide(velocity)

func dealdamage(body: Node2D):
	
	pass
