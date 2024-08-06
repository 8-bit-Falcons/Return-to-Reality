extends Control

func _on_VideoPlayer_finished():
	StageManager.change_stage(StageManager.MAIN_MENU)
