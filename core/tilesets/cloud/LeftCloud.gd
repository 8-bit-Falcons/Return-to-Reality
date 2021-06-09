extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			body.motion.y = -800
			$AnimatedSprite.play("TouchesPlayer")


func _on_RightCloud_body_entered(body):
	$AnimatedSprite.play("TouchesPlayer")


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("Idle")
