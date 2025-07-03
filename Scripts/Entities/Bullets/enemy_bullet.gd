extends BaseBullet
class_name EnemyBullet



func dealdamage(body : Node2D):
	
	if body.is_in_group("Player"):
		print(body.health)
		

		body.take_damage(damage)
		
		queue_free()
	
	pass
	


func body_entered(body: Node2D) -> void:
	
	
	dealdamage(body)
	
	print(body)
	
	pass
