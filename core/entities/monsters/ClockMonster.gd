extends Area2D



func _on_ClockMonster_body_entered(body):
	get_tree().reload_current_scene()
	
