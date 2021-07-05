extends Node2D

func _ready():
	if not Music.stream == load("res://assets/music/Grape Soda (Level 2).wav"):
		Music.stream = load("res://assets/music/Grape Soda (Level 2).wav")
		Music.play()

func _on_Area2D_body_entered(body):
	$Fade/AnimationPlayer.play("Fade")
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().reload_current_scene()
