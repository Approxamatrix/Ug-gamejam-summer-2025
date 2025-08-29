extends CharacterBody2D
class_name Player


enum PlayerState {Idle,Walk,Fall,Jump,Stun,Dead}

@export var health : int

@export var healthbar : ProgressBar

var state : PlayerState

@export var gravity : float

@export var basejumpheight : float
#@export var jumppower : float

var inputvector : Vector2

@export var walkspeed : float
@export var runspeed : float

@export var jumptimer : Timer

@export var dashtimer : Timer

@export var shieldtimer : Timer

@export var stuntimer : Timer

var facingdir

var oldjumpheight 

var bulletscene = preload("res://Scenes/Entities/Projectiles/PlayerBullet.tscn")

@export var bulletlimit : int

@export var healthlabel : Label

var bulletcount = 0

var shieldactive : bool

@export var Camera : Camera2D

@export var PlyrSprite : Sprite2D

#@export var fakeplyr : Sprite2D

@export var CameraoffsetY : int

@export var CamMaxDistanceFromPlayer : float


func _ready() -> void:
	
	
	state = PlayerState.Idle
	
	oldjumpheight = basejumpheight
	
	print("Player Start !")
	
	
	facingdir = 1
	
	GameAutoload.DecreasePlyrBulletCounter.connect(decrementbulletcounter)
	
	SepSpriteandCam()

	
	pass


func input():
	
	
	inputvector.x = Input.get_action_strength("MoveRight") - Input.get_action_strength("MoveLeft")
	
	if inputvector.x != 0:
		
		facingdir = inputvector.x
	
	#print(facingdir)
	
	if Input.is_action_just_pressed("Shoot") and GameAutoload.HasGun:
		shootbullet()
		pass
	
	if state == PlayerState.Idle:
		if Input.is_action_just_pressed("Shield"):
			
			shieldtimer.start()
			
			shieldactive = true
			
			pass
		elif !Input.is_action_just_pressed("Shield") or shieldtimer.is_stopped():
			
			shieldactive = false
			
			pass
		
	
	
	if state == PlayerState.Idle or state == PlayerState.Walk:
		
	
	
		if Input.is_action_just_pressed("Jump"):
			#state = PlayerState.Jump
			
			jumptimer.start()
			plyrjump()
		
		
		
	
	if GameAutoload.HasDashModule == true:
		dash()
	else:
		pass
	
	
	
	
	
	pass


func PlyrStateManager():
	
	match state:
		PlayerState.Idle:
			
			
			#
			#if Input.is_action_just_pressed("Jump"):
				#
				#jumptimer.start()
				##state = PlayerState.Jump
				#plyrjump()
			#
			#
			#print("Idle")
			
			if inputvector.x != 0 or Input.is_action_pressed("Dash"):
				state = PlayerState.Walk
			else:
				pass
			
			if !is_on_floor():
				
				
				state = PlayerState.Fall
				pass
		
		
			velocity = Vector2.ZERO
			pass
			
		PlayerState.Fall:
			
			#print("Fall")d
			velocity.x = inputvector.x * (walkspeed/2)
			if is_on_floor():
				
				state = PlayerState.Idle
			else:
				velocity.y += gravity * 10
				

			
			pass
		
		PlayerState.Jump:
			
			velocity.x = inputvector.x * (walkspeed/2)
			
			
			
			#print("Jump")
			
			## if the jump button is not pressed or the timer is stopped, then the player will fall
			## but if it is pressed or the timer is stil going, keep applying the force
			
			
			if !Input.is_action_pressed("Jump") or jumptimer.is_stopped():
				
				
				jumptimer.stop()
				state = PlayerState.Fall
			
			elif Input.is_action_pressed("Jump") or !jumptimer.is_stopped():
				#velocity.y -= jumppower * 10
				
				basejumpheight-= 20
				
				
				velocity.y -= basejumpheight
				
				#print(basejumpheight)
			
			
			
			
			if basejumpheight <= -20:
				
				basejumpheight = -20
				pass
	
	
	
			
			
			
			
				
			#if is_on_floor():
				#sttae = PlayerState.
			
			pass
		
		PlayerState.Walk:
			
			#
			#
			#if Input.is_action_just_pressed("Jump"):
				##state = PlayerState.Jump
				#
				#jumptimer.start()
				#plyrjump()
				#
			#
			
			
			velocity.x = inputvector.x * walkspeed
			
			
			#velocity.x = lerpf(velocity.x,inputvector.x * (walkspeed* 4),0.1)
			
			
			if inputvector.x == 0 or dashtimer.is_stopped():
				state = PlayerState.Idle
			
			if !is_on_floor():
				
				state = PlayerState.Fall
			
			
			pass
			
			
			
			velocity.y = 0
		
		PlayerState.Dead:
			
			
			velocity = Vector2.ZERO
			
			get_tree().reload_current_scene()
			
			
			
			
		PlayerState.Stun:
			
			velocity.x = 0
			
			if stuntimer.is_stopped():
				
				if !is_on_floor():
					
					state = PlayerState.Fall
					
					pass
				else:
					state = PlayerState.Idle
					pass
				pass
				
				
			else:
					
				if is_on_floor():
					
					#state = PlayerState.Idle
					pass
					pass
				if !is_on_floor():
					velocity.y += gravity * 10
					
					#velocity.y = 0
					pass
			
			pass
	
	
	pass


func dash():
	
	#if !dashtimer.is_stopped():
		##print(dashtimer.time_left)
	
	if state != PlayerState.Jump or state != PlayerState.Fall:
			
			if Input.is_action_just_pressed("Dash"):
				
				if dashtimer.is_stopped():
					dashtimer.start()
					walkspeed = runspeed
				
				
				
				#velocity.x = facingdir * walkspeed
				
				#print("dash !")
			
			if !Input.is_action_pressed("Dash") or dashtimer.is_stopped():
				
				walkspeed = runspeed/2
				
				if !dashtimer.is_stopped():
					
					dashtimer.stop()
				
				
				
				pass
			
			
			pass




func plyrjump():
	
	
	
	if state != PlayerState.Jump: ##basically the enter function in this kinda FSM system
		
		basejumpheight = oldjumpheight
		
		state = PlayerState.Jump
		
		velocity.y = basejumpheight
		
	
	
	#
	#velocity.y -= basejumpheight
	#
	#basejumpheight-= 0.25
	#
	#
	#if velocity.y <= 0.7:
		#
		#velocity.y = 0.7
		#pass
	#
	#
	
	
	
	
	
	pass

func shootbullet():
	
	if bulletcount < bulletlimit: 
		
		var bulletinstance = bulletscene.instantiate()
		
		var bulletpos
		
		var bulletspeed
		
		bulletpos = Vector2(self.global_position.x + ( 100 * facingdir ), self.global_position.y)
		
		bulletinstance.position = bulletpos
		
		bulletinstance.set_speed(20 * facingdir , 0)
		
		self.get_parent().add_child(bulletinstance)
		
		bulletcount += 1 
		
		
		
		
	
	
	pass

func decrementbulletcounter():
	
	bulletcount -= 1

func take_damage(damage : int):
	
	if !shieldactive or state != PlayerState.Stun:
		health -= damage
		clamp(health, 0, 10)
		print("Ouch !!")
		
		
		if state != PlayerState.Stun:
			state = PlayerState.Stun
			stuntimer.start()
		else:
			
			pass
		
	else:
		pass
		
		
	
	
	
	
	pass

func SepSpriteandCam():
	
	if PlyrSprite != null:
		#PlyrSprite.reparent(self.get_parent())
		
		PlyrSprite.reparent.call_deferred(self.get_parent())
		#
		#self.remove_child(PlyrSprite)
		#self.get_parent().get_parent().add_child.call_deferred(PlyrSprite)
		
	else:
		pass
	
	if Camera != null:
		#Camera.reparent(self.get_parent())
				#self.remove_child(Camera)
				#self.get_parent().get_parent().add_child.call_deferred(Camera)
				
		Camera.reparent.call_deferred(self.get_parent())


	#position = lerp(position,self.global_position,0.5)
	
	
	
	pass



func Cameramanager():
	
	if Camera != null:
		Camera.position.x =  PlyrSprite.position.x
		
		if is_on_floor():
			Camera.position.y = lerp(Camera.position.y,PlyrSprite.position.y + CameraoffsetY ,0.05)
			
		if !is_on_floor():
			
			var distancefromplyr
			distancefromplyr = abs(PlyrSprite.position.y - Camera.position.y)
			
			if distancefromplyr >= CamMaxDistanceFromPlayer:
				Camera.position.y = lerp(Camera.position.y, PlyrSprite.position.y + CameraoffsetY,0.025)
			
			
			
			
			
			
			
			pass
	else:
		print("Camera doesn't exist !")
		
	
	pass

func SpriteLogic():
	
	PlyrSprite.global_position = lerp(PlyrSprite.global_position,self.global_position,0.5)
	
	
	if facingdir <= -1:
		PlyrSprite.flip_h = true
		pass
	else:
		PlyrSprite.flip_h = false
	pass

func _physics_process(delta: float):
	SpriteLogic()
	Cameramanager()

	
	#
	#
	#if Camera != null:
		#
		#pass
		#
	#else:
		#print("Error ! Player has no assigned camera !!")
	
	#healthlabel.text = "Health : " + str(health)
	healthbar.value = health * 5
	
	#print(" State :" + var_to_str(state))
	if state != PlayerState.Dead :
		input()
	PlyrStateManager()
	
	
	
	
	if health <= 0 and state != PlayerState.Dead:
		
		state = PlayerState.Dead
		
		pass
	
	
	
	move_and_slide()
	
	pass
