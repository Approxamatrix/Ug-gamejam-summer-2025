extends BaseBullet


func destroybullet():
	
	
	GameAutoload.DecreasePlyrBulletCounter.emit()
	queue_free()
	
	pass
