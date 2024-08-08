extends CharacterBody2D

@onready var camera_2d = $Camera2D

const ACCELERATION = 50
const SPEED = 200.0
const JUMP_VELOCITY = -480.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var devtools_enabled = false


func _ready():
	camera_2d.reset_smoothing()

func _physics_process(delta):
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if not devtools_enabled:
		if Input.is_action_pressed("move_right"):
			velocity.x = min(velocity.x + ACCELERATION, SPEED)
			$Sprite.flip_h = false
			$Sprite.play("walking")
		elif Input.is_action_pressed("move_left"):
			velocity.x = max(velocity.x - ACCELERATION, -SPEED)
			$Sprite.flip_h = true
			$Sprite.play("walking")
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION)
			$Sprite.play("idle")
			
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * delta
			
			if velocity.y < 0:
				$Sprite.play("jumping")
			else:
				$Sprite.play("falling")
	
		move_and_slide()
	## Devtools allows you to fly through the level in order to test all
	## levels in a single run without having to play through them all
	else:
		if Input.is_action_pressed("ui_right"):
			velocity.x = 500
		elif Input.is_action_pressed("ui_left"):
			velocity.x = -500
		else:
			velocity.x = 0
		
		if Input.is_action_pressed("ui_up"):
			velocity.y = -500
		elif Input.is_action_pressed("ui_down"):
			velocity.y = 500
		else:
			velocity.y = 0
		
		move_and_slide()


func _input(event):
	if event.is_action_pressed("devtools"): # F11
		devtools_enabled = not devtools_enabled
		if devtools_enabled:
			var n = get_node("../GUI/AcceptDialog")
			if n:
				n.popup_centered()
