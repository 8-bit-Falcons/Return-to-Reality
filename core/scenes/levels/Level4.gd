extends Node2D

func _ready():
	if not Music.stream == load("res://assets/music/Deafening Silence (Level 4).wav"):
		Music.stream = load("res://assets/music/Deafening Silence (Level 4).wav")
		Music.play()
	$World_Complete/Sprite.flip_h = true


func _on_Fallzone_body_entered(body):
	get_tree().reload_current_scene()
