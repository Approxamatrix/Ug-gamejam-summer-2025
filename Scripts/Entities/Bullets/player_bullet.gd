extends BaseBullet
class_name PlayerBullet


func destroybullet():
	
	
	GameAutoload.DecreasePlyrBulletCounter.emit()
	queue_free()
	
	pass

func dealdamage(body : Node2D):
	
	if body.is_in_group("Enemy"):
		print(body.health)

		body.take_damage(damage)
	
	pass
	
	

func body_entered(body: Node2D) -> void:
	
	
	dealdamage(body)
	
	#print("E")
	
	pass
