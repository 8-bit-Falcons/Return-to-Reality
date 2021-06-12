extends Node2D


func _ready():
	if not Music.stream == load("res://assets/music/Credits.wav"):
		Music.stream = load("res://assets/music/Credits.wav")
		Music.play()
