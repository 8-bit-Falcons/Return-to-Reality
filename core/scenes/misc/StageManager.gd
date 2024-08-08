extends CanvasLayer

@onready var animations = $AnimationPlayer
@onready var black = $ColorRect

## Emitted when the stage manager has begun changing the scene
signal started
## Emitted when the stage manager has finished changing the scene
signal finished

const MAIN_MENU = "res://ui/main/MainMenu.tscn"
const WAKE_UP_CUTSCENE = "res://scenes/cutscenes/WakingUpCutscene.tscn"
const CREDITS = "res://scenes/cutscenes/Credits.tscn"

var changing_scene = false:
	set(val):
		changing_scene = val
		if changing_scene:
			started.emit()
		else:
			finished.emit()


# Called when the node enters the scene tree for the first time.
func _ready():
	black.hide()

# Changes the scene
func change_stage(stage_path):
	changing_scene = true
	
	# Fade in to black
	#get_tree().paused = true
	black.show()
	animations.play("fade_in")
	await animations.animation_finished
	
	# Change the scene
	get_tree().change_scene_to_file(stage_path)
	await get_tree().tree_changed
	
	# Fade out to scene
	animations.play("fade_out")
	await animations.animation_finished
	black.hide()
	#get_tree().paused = false
	changing_scene = false


# Reset the current scene
func reset_scene():
	black.show()
	animations.play("fade_in")
	await animations.animation_finished
	
	get_tree().reload_current_scene()
	
	animations.play("fade_out")
	await animations.animation_finished
	black.hide()
