extends Area2D

const TIME_BEFORE_REGEN = 3.0  # time in seconds
const GRACE_PERIOD = 0.25  # time in seconds before the platform dissapears

var time_invisible: float = 0.0
var time_since_entering: float = 0.0
var is_visible = true
var player_in_hitbox = false

# this uses _process instead of _physics_process so that the time is based on time, not frames
func _process(delta):
	if player_in_hitbox and is_visible and time_since_entering == 0.0:
		time_since_entering = 0.001
			# using elif so that the delta doesn't get added right after beginning to count
	elif time_since_entering > 0.0:
		time_since_entering += delta
		if time_since_entering >= GRACE_PERIOD:
			time_since_entering = 0.0
			set_visibility(false)
	# using if in case visibility changed above
	if not is_visible:
		time_invisible += delta
		if time_invisible >= TIME_BEFORE_REGEN:
			set_visibility(true)
			time_invisible = 0.0

func set_visibility(visible: bool):
	is_visible = visible
	$StaticBody2D/CollisionShape2D.disabled = not is_visible
	if visible:
		$Sprite.visible = visible
		$Sprite.play("Appearing")
	else:
		$Sprite.play("Popping")

func _on_DissapearingPlatform_body_entered(_body):
	player_in_hitbox = true


func _on_DissapearingPlatform_body_exited(_body):
	player_in_hitbox = false


func _on_Sprite_animation_finished():
	if is_visible:
		$Sprite.play("Idle")
	else:
		$Sprite.visible = false
