extends Control

var selected = 0

func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state

# This code is disgusting but I'm sorry I cannot rn
func _process(delta):
	if get_tree().paused:
		if Input.is_action_just_pressed("ui_right") or Input.is_action_just_pressed("ui_down"):
			if selected == 0:
				selected = 1
				$ResumeSelected.hide()
				$SettingsSelected.show()
			elif selected == 1:
				selected = 2
				$SettingsSelected.hide()
				$MenuSelected.show()
			else:
				selected = 0
				$MenuSelected.hide()
				$ResumeSelected.show()
		if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_up"):
			if selected == 0:
				selected = 2
				$ResumeSelected.hide()
				$MenuSelected.show()
			elif selected == 1:
				selected = 0
				$SettingsSelected.hide()
				$ResumeSelected.show()
			else:
				selected = 1
				$MenuSelected.hide()
				$SettingsSelected.show()
				
		if Input.is_action_just_pressed("ui_accept") and selected == 0:
			var new_pause_state = not get_tree().paused
			get_tree().paused = new_pause_state
			visible = new_pause_state
		if Input.is_action_just_pressed("ui_accept") and selected == 1:
			pass
		if Input.is_action_just_pressed("ui_accept") and selected == 2:
			var new_pause_state = not get_tree().paused
			get_tree().paused = new_pause_state
			visible = new_pause_state
			get_tree().change_scene("res://ui/main/MainMenu.tscn")
		
