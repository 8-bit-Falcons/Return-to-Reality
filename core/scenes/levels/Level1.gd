extends Node2D

func _ready():
	if not Music.stream == load("res://assets/music/Orange Soda (Level 1).wav"):
		Music.stream = load("res://assets/music/Orange Soda (Level 1).wav")
		Music.play()


func _on_Fallzone_body_entered(body):
	get_tree().reload_current_scene()
