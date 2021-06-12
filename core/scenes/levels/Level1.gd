extends Node2D

var reload = false

func _ready():
	if not Music.playing:
		Music.stream = load("res://assets/music/Orange Soda (Level 1).wav")
		Music.play()

func _exit_tree():
	if not reload: Music.stop()
