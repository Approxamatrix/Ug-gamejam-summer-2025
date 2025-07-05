extends StaticBody2D
class_name SpikeTile



func _on_hurtbox_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("Player"):
		
		body.take_damage(200)
		
		pass
	
	pass # Replace with function body.
