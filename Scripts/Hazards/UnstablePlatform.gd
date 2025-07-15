extends CharacterBody2D
class_name UnstablePlatform

var ogpos : Vector2

@export var fallspeed : int
@export var sprite : Sprite2D
@export var collision : CollisionShape2D
@export var area : Area2D
@export var falltimer : Timer
@export var respawntimer : Timer

@export var emitterleft : CPUParticles2D
@export var emitterright : CPUParticles2D
@export var animplayer : AnimationPlayer

enum state {Idle,Fall,Reset}
var platformstate : state

func _ready() -> void:
	
	ogpos = global_position
	platformstate = state.Idle
	
	
	
	pass
	
	

func respawn():
	collision.disabled = false
	sprite.visible = true
	area.visible = true
	
	velocity.y = 0
	
	
	global_position = ogpos
	
	platformstate = state.Idle
	
	
	#print("fall")
	
	pass




func fall():
	
	##collision.disabled = true
	#sprite.visible = false
	#area.visible = false
	
	respawntimer.start()
	
	emitterleft.emitting = true
	emitterright.emitting = true
	
	#actuallyfall()
	
	platformstate = state.Fall
	
	motion_mode = CharacterBody2D.MOTION_MODE_GROUNDED
	
	#print("fall")
	
	pass
	
	
func actuallyfall():
	
	velocity.y += fallspeed
	
	
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	
	
	if body.is_in_group("Player") and body.global_position.y < self.global_position.y:
		falltimer.start()
		animplayer.play("Shake")
		print("Player detected !!")
		
		
		pass
		
	
	
	
	
	pass # Replace with function body.






func _physics_process(delta: float) -> void:
	
	
	match platformstate:
		state.Idle:
			
			
			if motion_mode != CharacterBody2D.MOTION_MODE_FLOATING:
				
				
				motion_mode = CharacterBody2D.MOTION_MODE_FLOATING

				
				pass
				
			if emitterleft.emitting:
				emitterleft.emitting = false
				emitterright.emitting = false
		
			velocity.y = 0
			
			if falltimer.time_left <= 0.15:
				
				animplayer.stop()
				
				pass
			
			
			
		state.Fall:
			
			
			actuallyfall()
			
			pass
			
		state.Reset:
			
			pass
	
	move_and_slide()
	
	
	pass
