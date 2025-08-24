extends Basestate
class_name WallcrawlerWander

@export var enemyobj : Wallcrawler


func enter():
	
	
	print("wander")
	
	pass

func wander():
	
	
	if enemyobj.DirChangeCooldown.is_stopped():
		
		enemyobj.DirChangeCooldown.wait_time = randi_range(3,10)
		
		if enemyobj.wanderdir == 0 and enemyobj.facingdir != 0:
			enemyobj.wanderdir = enemyobj.facingdir
		else:
			enemyobj.wanderdir = 1
		
		#
		if enemyobj.wanderdir == enemyobj.facingdir:
			#wanderdir = wanderdir * -1
			pass
			
		enemyobj.wanderdir = enemyobj.wanderdir * -1
		
		
	
	if enemyobj.wallray.is_colliding() and enemyobj.wallray.get_collider().is_in_group("Enemy") :
		
		enemyobj.wanderdir *= -1
		pass
	
	if (enemyobj.rightray.is_colliding() and !enemyobj.leftray.is_colliding() ) or (enemyobj.wallray.is_colliding() and enemyobj.wallray.target_position.x < -1 ):
		
		enemyobj.wanderdir = 1
		
		

	if ( enemyobj.leftray.is_colliding() and !enemyobj.rightray.is_colliding() ) or (enemyobj.wallray.is_colliding() and enemyobj.wallray.target_position.x > 1 ):

		#velocity.x = 0
	
		enemyobj.wanderdir = -1


	
	enemyobj.wallray.target_position.x = enemyobj.walldist * enemyobj.facingdir


	var wanderpos = Vector2(enemyobj.wanderdir * enemyobj.wanderspeed,0)




	enemyobj.velocity.x = wanderpos.x
	


func _on_dir_change_timer_timeout() -> void:
	
	
	StateChangeSignal.emit("WallcrawlerIdle")
	
	
	
	
	pass # Replace with function body.


func _on_begin_attack_timeout() -> void:
	pass
	#if enemyobj.idletimer.is_stopped():
		#
		#if enemyobj.player != null:
			#print("attack starts now !!")
			##currbullets = 0
			#print("currbullets" + str(enemyobj.currbullets))
			#StateChangeSignal.emit("WallcrawlerShoot")
			#
			#
			#
			#pass
	#else:
		#
		#
		#pass
		#pass # Replace with function body.


func update():
	
	

	
	enemyobj.facingdir = enemyobj.wanderdir
	
	#print("wandering")
	#if stopwandering.is_stopped():
	wander()
	
	#print(enemyobj.wanderdir)
	
	if enemyobj.player and enemyobj.AttackCooldownTimer.is_stopped():
		StateChangeSignal.emit("WallcrawlerShoot")
		pass
	
	pass
	
		
	
	
	pass
