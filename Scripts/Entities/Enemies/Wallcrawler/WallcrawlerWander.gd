extends Basestate
class_name WallcrawlerWander

@export var enemyobj : Wallcrawler


func enter():
	
	
	print("wander")
	
	pass

func wander():
	
	## add a timer which has a cooldown on how when the wanderdir can change
	
	if enemyobj.dirchangecooldown.is_stopped():
		#wanderdir = randi_range(-1,1)
		
		if enemyobj.wanderdir == 0 and enemyobj.facingdir != 0:
			enemyobj.wanderdir = enemyobj.facingdir
		else:
			enemyobj.wanderdir = 1
		
		#
		if enemyobj.wanderdir == enemyobj.facingdir:
			#wanderdir = wanderdir * -1
			pass
		
		enemyobj.dirchangecooldown.start()
		
	
	if enemyobj.wallray.is_colliding() and enemyobj.wallray.get_collider().is_in_group("Enemy") :
		
		enemyobj.wanderdir *= -1
		pass
	
	if (enemyobj.rightray.is_colliding() and !enemyobj.leftray.is_colliding() ) or (enemyobj.wallray.is_colliding() and enemyobj.wallray.target_position.x < -1 ):
	 
		StateChangeSignal.emit("WallcrawlerIdle")
		
		enemyobj.wanderdir = 1
		
		

	if ( enemyobj.leftray.is_colliding() and !enemyobj.rightray.is_colliding() ) or (enemyobj.wallray.is_colliding() and enemyobj.wallray.target_position.x > 1 ):

		#velocity.x = 0
		
		StateChangeSignal.emit("WallcrawlerIdle")

		
		enemyobj.wanderdir = -1

	#if !leftray.is_colliding() and !rightray.is_colliding():
#
		#wanderdir = 0
		#pass
	
	
	#detectorray.target_position.x = targetrange * facingdir
	
	enemyobj.wallray.target_position.x = enemyobj.walldist * enemyobj.facingdir

	#wanderspeed = randi_range(0,maxwanderrange)

	var wanderpos = Vector2(enemyobj.wanderdir * enemyobj.wanderspeed,0)

#
	#if spawnpoint.distance_to(wanderpos) > maxwanderrange:
		#wanderpos.x = wanderpos.x / maxwanderrange


	enemyobj.velocity.x = wanderpos.x


func _on_dir_change_timer_timeout() -> void:
	
	
	StateChangeSignal.emit("WallcrawlerIdle")
	
	
	
	
	pass # Replace with function body.

func update():
	
	

	
	enemyobj.facingdir = enemyobj.wanderdir
	
	#print("wandering")
	#if stopwandering.is_stopped():
	wander()
		#stopwandering.start()
	
	if enemyobj.detectionarea.has_overlapping_bodies(): 
		pass
		
		
	if enemyobj.player != null:
		#randomizebeginattacktimer()
		pass
	
	if enemyobj.player == null:
		enemyobj.BeginAttackTimer.stop()
		
	
	
	enemyobj.facingdir = enemyobj.wanderdir
			
			
	if enemyobj.detectionarea.has_overlapping_bodies(): 
		pass
		
		
	if enemyobj.player != null:
		#randomizebeginattacktimer()
		pass
	
	if enemyobj.player == null:
		enemyobj.BeginAttackTimer.stop()
	
	pass
	
		
	
	
	pass
