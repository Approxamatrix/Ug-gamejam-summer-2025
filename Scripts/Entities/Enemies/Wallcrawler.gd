extends CharacterBody2D
class_name Wallcrawler


##TODO : Add a timer for how long it takes the enemy to attack the player
## BUT make it a random time between a specific range



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

var wanderdir : int = -1

var facingdir : int = -1


func _ready() -> void:
	
	state = Enemystates.Idle
	
	
	
	pass
	
	
func _physics_process(delta: float) -> void:
	
	EnemyStateManager()
	
	move_and_slide()
	
	
	if !BeginAttackTimer.is_stopped():
		print(BeginAttackTimer.time_left)
		pass
	
	if health <= 0 and state != Enemystates.Die:
		
		state = Enemystates.Die
		
		pass
	
	#print(velocity.x)
	
	pass



func EnemyStateManager():
	
	match state:
		
		Enemystates.Die:
			
			velocity.x = 0
			queue_free()
			
			pass
		
		Enemystates.Idle:
			#print("idle")
			
			if idletimer.is_stopped():
				idletimer.start()
			
			velocity.x = 0
			
			if detectionarea.has_overlapping_bodies():
				
				pass
				
			
		
			
			pass
			
		Enemystates.Wander:
			
			facingdir = wanderdir
			
			#print("wandering")
			#if stopwandering.is_stopped():
			wander()
				#stopwandering.start()
			
			if detectionarea.has_overlapping_bodies(): 
				pass
				
				
			if player != null:
				randomizebeginattacktimer()
			
			pass
			
		Enemystates.Shoot:
			
			velocity.x = 0
			
			#if currbullets <= bulletlimit:
			if bullcooldown.is_stopped() and shootagain.is_stopped():
				shootenemy()
				bullcooldown.start()
				
				
				
				
			#if currbullets >= bulletlimit:
				
			if shootagain.is_stopped():
				
				shootagain.start()
				pass
			
				pass
			
			if !player:
				
				state = Enemystates.Idle
			
			pass
	
	
	
	pass
	






func startwandering():
	
	if leftray.is_colliding() or rightray.is_colliding():
		
		if state != Enemystates.Die:
			state = Enemystates.Wander
		
		pass
			
	
	pass




func shootenemy():
	
	if player != null:
	#if currbullets < bulletlimit:
		var bullet = bulletscene.instantiate()
		self.get_parent().add_child(bullet)
		bullet.global_position.x = self.global_position.x + (bulletoffset * global_position.direction_to(player.global_position).x)
		bullet.global_position.y = self.global_position.y + 10
		#dirtoplyr = self.global_position.direction_to(player.global_position)
		bullet.set_speed(bulletspeed * dirtoplyr.x , bulletspeed * dirtoplyr.y)
		print(Vector2(bulletspeed * dirtoplyr.x , bulletspeed * dirtoplyr.y))
		print(dirtoplyr)
		currbullets += 1
		
		if changeattackdirdelaytimer.is_stopped():
			#print("AAAAAAAAAAAAAdddddddd")
			changeattackdirdelaytimer.start()
		
		#BeginAttackTimer.start()
		
		randomizebeginattacktimer()
		state = Enemystates.Idle
			
			#dirtoplyr = self.global_position.direction_to(player.global_position)

		
	else:
		
		pass



func wander():
	
	## add a timer which has a cooldown on how when the wanderdir can change
	
	if dirchangecooldown.is_stopped():
		#wanderdir = randi_range(-1,1)
		
		if wanderdir == 0 and facingdir != 0:
			wanderdir = facingdir
		else:
			wanderdir = 1
		
		#
		if wanderdir == facingdir:
			#wanderdir = wanderdir * -1
			pass
		
		dirchangecooldown.start()
		
	
	if wallray.is_colliding() and wallray.get_collider().is_in_group("Enemy") :
		
		wanderdir *= -1
		pass
	
	if (rightray.is_colliding() and !leftray.is_colliding() ) or (wallray.is_colliding() and wallray.target_position.x < -1 ):
	 
		if state != Enemystates.Die:
			state = Enemystates.Idle
		
		wanderdir = 1
		
		

	if ( leftray.is_colliding() and !rightray.is_colliding() ) or (wallray.is_colliding() and wallray.target_position.x > 1 ):

		#velocity.x = 0
		
		if state != Enemystates.Die:
			state = Enemystates.Idle
		
		wanderdir = -1

	#if !leftray.is_colliding() and !rightray.is_colliding():
#
		#wanderdir = 0
		#pass
	
	
	#detectorray.target_position.x = targetrange * facingdir
	
	wallray.target_position.x = walldist * facingdir

	#wanderspeed = randi_range(0,maxwanderrange)

	var wanderpos = Vector2(wanderdir * wanderspeed,0)

#
	#if spawnpoint.distance_to(wanderpos) > maxwanderrange:
		#wanderpos.x = wanderpos.x / maxwanderrange


	self.velocity.x = wanderpos.x


func _on_shoot_again_timeout() -> void:
	
	currbullets = 0
	
	pass # Replace with function body.


func _on_dir_change_timer_timeout() -> void:
	
	if state == Enemystates.Wander:
		
		state = Enemystates.Idle
		
	
	pass # Replace with function body.
	
	
	
	
	pass # Replace with function body.

func randomizebeginattacktimer():
	if BeginAttackTimer.is_stopped():
		BeginAttackTimer.wait_time = randi_range(0.1,beginattackmaxtime)
		BeginAttackTimer.start()
	else:
		print("IDKIDKIDK")


func _on_detection_area_body_entered(body: Node2D) -> void:
	
	
	if body.is_in_group("Player"):
		
		randomizebeginattacktimer()
		
		player = body
		dirtoplyr = self.global_position.direction_to(player.global_position)

		changeattackdirdelaytimer.start()
	
	
	
	pass # Replace with function body.


func _on_detection_area_body_exited(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		
		body = null
		
		if state == Enemystates.Shoot:
			
			state = Enemystates.Idle
			
			pass
	
	
	pass # Replace with function body.


func _on_begin_attack_timeout() -> void:
	
	if player != null:
		if state == Enemystates.Wander or state == Enemystates.Idle:
			print("attack starts now !!")
			currbullets = 0
			print("currbullets" + str(currbullets))
			state = Enemystates.Shoot
			
			pass
	
	pass # Replace with function body.


func _on_attack_delay_timeout() -> void:
	if player != null:
		dirtoplyr = self.global_position.direction_to(player.global_position)
	pass # Replace with function body.
