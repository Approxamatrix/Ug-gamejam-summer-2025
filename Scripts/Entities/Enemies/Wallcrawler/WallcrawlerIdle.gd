extends Basestate
class_name WallcrawlerIdle

#NOTE : This is basically a reset state. Don't bother with adding much (or any) funcitonality here !
@export var enemyobj : Wallcrawler

func enter():
	
	
	print("idling")
	
	pass

func update():
	
	enemyobj.velocity.x = 0
	
	StateChangeSignal.emit("WallcrawlerWander")
	
	pass



func exit():
	pass
	
	
