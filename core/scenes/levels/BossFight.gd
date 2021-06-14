extends Node2D

func _ready():
	if not Music.stream == load("res://assets/music/Spectral Showdown (Boss Fight).wav"):
		Music.stream = load("res://assets/music/Spectral Showdown (Boss Fight).wav")
		Music.play()

func _on_Bossman_dying():
	print("he dead")
	Music.stop()
	get_tree().change_scene("res://scenes/cutscenes/WakingUpCutscene.tscn")
