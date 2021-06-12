extends Area2D

const JUMP_HEIGHT = -800

func _on_Area2D_body_entered(body):
	if body.motion.y >= 0.0:  
		# one way doesn't work here because it would just activate at the top instead
		# of the bottom
		body.motion.y = JUMP_HEIGHT
		$LeftCloud.play("TouchesPlayer")
		$RightCloud.play("TouchesPlayer")


func _on_animation_finished():
	$LeftCloud.play("Idle")
	$RightCloud.play("Idle")
