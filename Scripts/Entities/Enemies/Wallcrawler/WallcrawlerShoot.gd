extends Basestate
class_name WallcrawlerShoot

@export var enemyobj : Wallcrawler

func enter():
	
	print("Shoot")
	
	enemyobj.AttackDelayTimer.start()
	
	enemyobj.velocity = Vector2.ZERO
	
	pass

func shootenemy():
	#print("POW !")
	enemyobj.velocity.x = 0
	if enemyobj.player != null:
	#if currbullets < bulletlimit:
		var bullet = enemyobj.bulletscene.instantiate()
		self.get_parent().add_child(bullet)
		bullet.global_position.x = enemyobj.global_position.x + (enemyobj.bulletoffset * enemyobj.global_position.direction_to(enemyobj.player.global_position).x)
		bullet.global_position.y = enemyobj.global_position.y + 10
		enemyobj.dirtoplyr = enemyobj.global_position.direction_to(enemyobj.player.global_position)
		bullet.set_speed(enemyobj.bulletspeed * enemyobj.dirtoplyr.x , enemyobj.bulletspeed * enemyobj.dirtoplyr.y)
		print(Vector2(enemyobj.bulletspeed * enemyobj.dirtoplyr.x , enemyobj.bulletspeed * enemyobj.dirtoplyr.y))
		print(enemyobj.dirtoplyr)
		enemyobj.currbullets += 1
		
		StateChangeSignal.emit("WallcrawlerWander")
		
			

		
	else:
		
		pass


func update():
	
	enemyobj.velocity.x = 0
	
	if enemyobj.player == null:
		pass
	else:
		if enemyobj.AttackDelayTimer.is_stopped():
			shootenemy()
			pass
		pass
	

	
	pass



func exit():
	print("exiting shooting state")
	enemyobj.AttackCooldownTimer.start()
	enemyobj.currbullets = 0
	pass
