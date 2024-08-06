extends Control

func _on_VideoPlayer_finished():
	StageManager.change_stage("res://ui/main/MainMenu.tscn")
