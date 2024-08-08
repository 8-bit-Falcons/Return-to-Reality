extends Node2D
@onready var animation_player = $GUI/Fade/AnimationPlayer

func _ready():
	if not Music.stream == load("res://assets/music/Orange Soda (Level 1).wav"):
		Music.stream = load("res://assets/music/Orange Soda (Level 1).wav")
		Music.play()


func _on_Fallzone_body_entered(body):
	StageManager.reset_scene()
