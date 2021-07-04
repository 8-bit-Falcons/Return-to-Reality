extends Node2D

func _ready():
	if not Music.stream == load("res://assets/music/Deafening Silence (Level 4).wav"):
		Music.stream = load("res://assets/music/Deafening Silence (Level 4).wav")
		Music.play()
	$World_Complete/Sprite.flip_h = true


func _on_Fallzone_body_entered(body):
	$Fade/AnimationPlayer.play("Fade")
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().reload_current_scene()
