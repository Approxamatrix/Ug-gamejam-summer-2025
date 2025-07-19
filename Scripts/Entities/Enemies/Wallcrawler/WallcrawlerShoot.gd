extends Basestate
class_name WallcrawlerShoot

@export var enemyobj : Wallcrawler

func enter():
	
	print("Shoot")
	
	pass

func shootenemy():
	#print("POW !")
	if enemyobj.player != null:
	#if currbullets < bulletlimit:
		var bullet = enemyobj.bulletscene.instantiate()
		self.get_parent().add_child(bullet)
		bullet.global_position.x = enemyobj.global_position.x + (enemyobj.bulletoffset * enemyobj.global_position.direction_to(enemyobj.player.global_position).x)
		bullet.global_position.y = enemyobj.global_position.y + 10
		#dirtoplyr = self.global_position.direction_to(player.global_position)
		bullet.set_speed(enemyobj.bulletspeed * enemyobj.dirtoplyr.x , enemyobj.bulletspeed * enemyobj.dirtoplyr.y)
		print(Vector2(enemyobj.bulletspeed * enemyobj.dirtoplyr.x , enemyobj.bulletspeed * enemyobj.dirtoplyr.y))
		print(enemyobj.dirtoplyr)
		enemyobj.currbullets += 1
		
		if enemyobj.changeattackdirdelaytimer.is_stopped():
			#print("AAAAAAAAAAAAAdddddddd")
			enemyobj.changeattackdirdelaytimer.start()
		
		#BeginAttackTimer.start()
		
		enemyobj.randomizebeginattacktimer()
		
		StateChangeSignal.emit("WallcrawlerWander")
		
			
			#dirtoplyr = self.global_position.direction_to(player.global_position)

		
	else:
		
		pass


func update():
	
	enemyobj.velocity.x = 0
	


	if enemyobj.player != null:
		
		
		
		if enemyobj.bullcooldown.is_stopped() and enemyobj.shootagain.is_stopped():
			
			
			if enemyobj.shootdelay.is_stopped():
				#shootenemy()
				#velocity.x = 0
				print("velocity:")
				print(enemyobj.velocity.x)
				enemyobj.shootdelay.start()
			enemyobj.bullcooldown.start()
			
			
			
			
		#if currbullets >= bulletlimit:
			
		if enemyobj.shootagain.is_stopped():
			
			enemyobj.shootagain.start()
			pass
		
			pass
	

	
	pass



func randomizebeginattacktimer():
	#if idletimer.is_stopped():
	if enemyobj.BeginAttackTimer.is_stopped():
		enemyobj.BeginAttackTimer.wait_time = randi_range(0.5,enemyobj.beginattackmaxtime)
		enemyobj.BeginAttackTimer.start()
	else:
		pass

func exit():
	
	enemyobj.currbullets = 0
	pass
