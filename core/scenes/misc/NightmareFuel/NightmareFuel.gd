extends Area2D

func _on_Nightmare_Fuel_body_entered(body):
	get_node("../../Fade/AnimationPlayer").play("Fade")
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().reload_current_scene()
