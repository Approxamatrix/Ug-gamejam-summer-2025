##TODO : stop the enemy from going over the edge 
## when one of the raycasts is not detecting anything


extends CharacterBody2D

class_name Ranger

enum Enemystates {Idle, Wander, Shoot, Die}

var state : Enemystates

@export var health : int

@export var targetrange : int

@export var leftray : RayCast2D

@export var rightray : RayCast2D

@export var detectorray : RayCast2D

var currbullets = 0

@export var bulletlimit : int

var bulletscene = preload("res://Scenes/Entities/Projectiles/Bullet.tscn")

@export var bulletoffset : int

@export var bullcooldown : Timer

@export var shootagain : Timer

@export var dirchangecooldown : Timer

@export var stopwandering : Timer

@export var idletimer : Timer

var facingdir = 1

var wanderdir


@export var maxwanderrange : int

var spawnpoint

@export var wanderspeed : int

func _ready():

	spawnpoint = self.global_position
	
	state = Enemystates.Idle
	


func EnemyStateManager():
	
	match state:
		
		Enemystates.Die:
			
			velocity.x = 0
			queue_free()
			
			pass
		
		Enemystates.Idle:
			print("idle")
			
			if idletimer.is_stopped():
				idletimer.start()
			
			velocity.x = 0
			
			if detectorray.is_colliding():
				state = Enemystates.Shoot
				pass
				
			
		
			
			pass
			
		Enemystates.Wander:
			print("wandering")
			#if stopwandering.is_stopped():
			wander()
				#stopwandering.start()
			
			if detectorray.is_colliding():
				state = Enemystates.Shoot
				pass
			
			
			pass
			
		Enemystates.Shoot:
			
			velocity.x = 0
			
			if currbullets <= bulletlimit:
				if bullcooldown.is_stopped() and shootagain.is_stopped():
					shootenemy()
					bullcooldown.start()
				
				
				
				
			if currbullets >= bulletlimit:
				
				if shootagain.is_stopped():
					
					shootagain.start()
					pass
				
				pass
			
			if !detectorray.is_colliding():
				
				state = Enemystates.Idle
			
			pass
	
	
	
	pass
	



func startwandering():
	
	if leftray.is_colliding() or rightray.is_colliding():
		
		if state != Enemystates.Die:
			state = Enemystates.Wander
		
		pass
			
	
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
		
	
	
	
	if rightray.is_colliding() and !leftray.is_colliding():
	 
		if state != Enemystates.Die:
			state = Enemystates.Idle
		
		wanderdir = 1
		
		

	if leftray.is_colliding() and !rightray.is_colliding():

		#velocity.x = 0
		
		if state != Enemystates.Die:
			state = Enemystates.Idle
		
		wanderdir = -1

	#if !leftray.is_colliding() and !rightray.is_colliding():
#
		#wanderdir = 0
		#pass

	facingdir = wanderdir
	
	detectorray.target_position.x = targetrange * facingdir

	#wanderspeed = randi_range(0,maxwanderrange)

	var wanderpos = Vector2(wanderdir * wanderspeed,0)

#
	#if spawnpoint.distance_to(wanderpos) > maxwanderrange:
		#wanderpos.x = wanderpos.x / maxwanderrange


	self.velocity.x = wanderpos.x


func shootenemy():
	if currbullets < bulletlimit:

		var bullet = bulletscene.instantiate()
		self.get_parent().add_child(bullet)

		bullet.global_position.x = self.global_position.x + (bulletoffset * facingdir)
		bullet.global_position.y = self.global_position.y


		bullet.set_speed(20 * facingdir)
		
		currbullets += 1
		

func  _physics_process(delta: float) -> void:
	
	EnemyStateManager()
	
	move_and_slide()
	
	
	if health <= 0 and state != Enemystates.Die:
		
		state = Enemystates.Die
		
		pass
	
	#print(velocity.x)
	
	pass


func _on_shoot_again_timeout() -> void:
	
	currbullets = 0
	pass # Replace with function body.


func direction_change_timeout() -> void:
	
	if state == Enemystates.Wander:
		
		state = Enemystates.Idle
		
	
	pass # Replace with function body.
	
	
	
func take_damage(damage : int):
	
	#if !shieldactive:
	health -= damage
	#else:
		#pass
	#
	#
	
	pass
