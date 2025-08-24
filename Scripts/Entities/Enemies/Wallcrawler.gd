extends CharacterBody2D
class_name Wallcrawler


##TODO : Add a timer for how long it takes the enemy to attack the player
## BUT make it a random time between a specific range



@export var statemanager : StateManager

@export var statelabel : Label

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

@export var beginattackmaxtime : float

var player : Player

var currbullets : int

var dirtoplyr : Vector2

@export var DirChangeCooldown : Timer

@export var IdleTimer : Timer

@export var AttackCooldownTimer : Timer

@export var AttackDelayTimer : Timer


var wanderdir : int = -1

var facingdir : int = -1


func _ready() -> void:
	
	
	statemanager.change_state("WallcrawlerIdle")
	
	
	
	pass
	
	
func _physics_process(delta: float) -> void:
	
	move_and_slide()
	
	statelabel.text = str(statemanager.currentstate) 
	



func _on_shoot_again_timeout() -> void:
	
	currbullets = 0
	
	pass # Replace with function body.



func _on_detection_area_body_entered(body: Node2D) -> void:
	
	
	if body.is_in_group("Player"):
		
		
		player = body
		dirtoplyr = self.global_position.direction_to(player.global_position)

	
	
	
	pass 


func _on_detection_area_body_exited(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		
		player = null
		
		
		statemanager.change_state("WallcrawlerIdle")
		
		pass
		
		
		
	


	
	pass 





func change_attack_dir_timeout() -> void:
	if player != null:
		dirtoplyr = self.global_position.direction_to(player.global_position)
	pass 


func take_damage(damage : int):
	
	#if !shieldactive:
	health -= damage
	#else:
		#pass
	#
	#
	
	pass
