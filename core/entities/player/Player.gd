extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -500

var motion = Vector2()
var devtools_enabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not devtools_enabled:
		motion.y += GRAVITY
		var friction = false
		
		if Input.is_action_pressed("move_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Sprite.play("walking")
		elif Input.is_action_pressed("move_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Sprite.play("walking")
		else:
			$Sprite.play("idle")
			friction = true
			
		if is_on_floor():
			if Input.is_action_just_pressed("jump"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.2)
		else:
			if motion.y < 0:
				$Sprite.play("jumping")
			else:
				$Sprite.play("falling")
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)
			
		motion = move_and_slide(motion, UP)
	# Devtools allows you to fly through the level in order to test all
	# levels in a single run without having to play through them all
	else:
		if Input.is_action_pressed("ui_right"):
			motion.x = 500
		elif Input.is_action_pressed("ui_left"):
			motion.x = -500
		else:
			motion.x = 0
		
		if Input.is_action_pressed("ui_up"):
			motion.y = -500
		elif Input.is_action_pressed("ui_down"):
			motion.y = 500
		else:
			motion.y = 0
		motion = move_and_slide(motion, UP)
	
func _input(event):
	if event.is_action_pressed("devtools"): # F11
		devtools_enabled = not devtools_enabled
