extends CharacterBody2D
class_name Wallcrawler


##TODO : Add a timer for how long it takes the enemy to attack the player
## BUT make it a random time between a specific range



@export var statemanager : StateManager

@export var health : int

@export var wanderspeed : int

@export var bulletlimit : int

@export var bulletspeed : int

@export var bulletoffset : int

var bulletscene = preload("res://Scenes/Entities/Projectiles/EnemyBullet.tscn")

@export var detectionarea : Area2D

@export var wallray : RayCast2D
@export var walldist : int

@export var leftray : RayCast2D
@export var rightray : RayCast2D

@export var idletimer : Timer

@export var bullcooldown : Timer

@export var shootagain : Timer

@export var BeginAttackTimer : Timer

@export var beginattackmaxtime : float

@export var changeattackdirdelaytimer : Timer

@export var player : Player

var currbullets : int

var dirtoplyr : Vector2



enum Enemystates {Idle, Wander, Shoot, Die}

var state : Enemystates

@export var dirchangecooldown : Timer

@export var shootdelay : Timer

var wanderdir : int = -1

var facingdir : int = -1


func _ready() -> void:
	
	
	statemanager.change_state("WallcrawlerIdle")
	
	
	
	pass
	
	
func _physics_process(delta: float) -> void:
	
	move_and_slide()
	

	if health <= 0 and state != Enemystates.Die:
		
		state = Enemystates.Die
		
		pass
		
	pass


#
#func EnemyStateManager():
	#
	#match state:
		#
		#Enemystates.Die:
			#
			#velocity.x = 0
			#queue_free()
			#
			#pass
		#
		#Enemystates.Wander:
			#
			#
			#
			#pass
	#pass
	#









func _on_shoot_again_timeout() -> void:
	
	currbullets = 0
	
	pass # Replace with function body.



func _on_detection_area_body_entered(body: Node2D) -> void:
	
	
	if body.is_in_group("Player"):
		
		#randomizebeginattacktimer()
		
		player = body
		dirtoplyr = self.global_position.direction_to(player.global_position)

		changeattackdirdelaytimer.start()
		
		
		if BeginAttackTimer.is_stopped():
			BeginAttackTimer.start()
			changeattackdirdelaytimer.start()

	
	
	
	pass # Replace with function body.


func _on_detection_area_body_exited(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		
		player = null
		
		if state == Enemystates.Shoot:
			
			statemanager.change_state("WallcrawlerIdle")
			
			pass
		
		#shootagain.stop()
		#BeginAttackTimer.stop()
		#changeattackdirdelaytimer.stop()
		
	


	
	pass # Replace with function body.


func _on_begin_attack_timeout() -> void:
	if idletimer.is_stopped():
		
		if player != null:
			if state == Enemystates.Wander or state == Enemystates.Idle:
				print("attack starts now !!")
				#currbullets = 0
				print("currbullets" + str(currbullets))
				statemanager.change_state("WallcrawlerShoot")
			

				
				pass
	else:
		
		BeginAttackTimer.start()
		
		pass
		pass # Replace with function body.


func change_attack_dir_timeout() -> void:
	if player != null:
		dirtoplyr = self.global_position.direction_to(player.global_position)
	pass # Replace with function body.


func take_damage(damage : int):
	
	#if !shieldactive:
	health -= damage
	#else:
		#pass
	#
	#
	
	pass
