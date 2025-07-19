extends Basestate
class_name WallcrawlerIdle


@export var enemyobj : Wallcrawler

func enter():
	
	if  enemyobj.idletimer.is_stopped():
				enemyobj.idletimer.start()
			
	print("idling")
	
	pass

func update():
	
	enemyobj.velocity.x = 0
			
	if enemyobj.detectionarea.has_overlapping_bodies():
		
		pass
		
			
	
	
	StateChangeSignal.emit("WallcrawlerWander")
	
	pass



func exit():
	pass
	
	
