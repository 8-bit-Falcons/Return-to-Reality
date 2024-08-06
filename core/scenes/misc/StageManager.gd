extends CanvasLayer

@onready var animations = $AnimationPlayer
@onready var black = $ColorRect

const MAIN_MENU = "res://ui/main/MainMenu.tscn"
const WAKE_UP_CUTSCENE = "res://scenes/cutscenes/WakingUpCutscene.tscn"
const CREDITS = "res://scenes/cutscenes/Credits.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	black.hide()

# Changes the scene
func change_stage(stage_path):
	# Fade in to black
	get_tree().paused = true
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
	get_tree().paused = false
