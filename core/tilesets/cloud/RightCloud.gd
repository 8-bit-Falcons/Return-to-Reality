extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			body.motion.y = -800
			$AnimatedSprite2.play("TouchesPlayer")


func _on_LeftCloud_body_entered(body):
	$AnimatedSprite2.play("TouchesPlayer")


func _on_AnimatedSprite2_animation_finished():
	$AnimatedSprite2.play("Idle")
