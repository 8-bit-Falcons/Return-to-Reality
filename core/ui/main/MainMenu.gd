extends Control


# Declare member variables here. Examples:
export(String, FILE, "*tscn") var next_world
var play_selected = true


# Called when the node enters the scene tree for the first time.
func _ready():
	$CenterContainer/SettingsSelected.hide()
	$CenterContainer/PlaySelected.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_right"):
		play_selected = false
		$CenterContainer/PlaySelected.hide()
		$CenterContainer/SettingsSelected.show()
	if Input.is_action_pressed("ui_left"):
		play_selected = true
		$CenterContainer/PlaySelected.show()
		$CenterContainer/SettingsSelected.hide()
	if Input.is_action_pressed("ui_accept") and play_selected:
		get_tree().change_scene(next_world)
