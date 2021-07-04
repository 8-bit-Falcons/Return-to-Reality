extends CanvasLayer

enum {NONE, PAUSE_MENU, SETTINGS_MENU} # Defines menus
enum {RESUME, SETTINGS, MAIN_MENU} # Defines pause menu buttons
enum {VOLUME0, VOLUME1, VOLUME2, VOLUME3} # Defines settings menu buttons
var current_menu = NONE # The menu currently open
var pause_selected = RESUME # The button selected on the pause menu
var settings_selected = VOLUME3 # The button selected on the settings menu

# When the pause button is pressed, inverse the pause state of the level
func _input(event):
	if event.is_action_pressed("pause"):
		var new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		$PauseMenu.set_visible(new_pause_state)
		$SettingsMenu.set_visible(false)
		current_menu = PAUSE_MENU
		if not new_pause_state:
			current_menu = NONE
			PauseMusic.stop()
		else:
			PauseMusic.play()

# This code is disgusting but I'm sorry I cannot rn
func _process(delta):
	# On the pause menu, pressing the arrow keys changes the currently selected
	# button
	if current_menu == PAUSE_MENU:
		if Input.is_action_just_pressed("ui_down"):
			if pause_selected == RESUME:
				pause_selected = SETTINGS
				$PauseMenu/ResumeSelected.hide()
				$PauseMenu/SettingsSelected.show()
			elif pause_selected == SETTINGS:
				pause_selected = MAIN_MENU
				$PauseMenu/SettingsSelected.hide()
				$PauseMenu/MenuSelected.show()
			else:
				pause_selected = RESUME
				$PauseMenu/MenuSelected.hide()
				$PauseMenu/ResumeSelected.show()
		if Input.is_action_just_pressed("ui_up"):
			if pause_selected == RESUME:
				pause_selected = MAIN_MENU
				$PauseMenu/ResumeSelected.hide()
				$PauseMenu/MenuSelected.show()
			elif pause_selected == SETTINGS:
				pause_selected = RESUME
				$PauseMenu/SettingsSelected.hide()
				$PauseMenu/ResumeSelected.show()
			else:
				pause_selected = SETTINGS
				$PauseMenu/MenuSelected.hide()
				$PauseMenu/SettingsSelected.show()

		# Pressing ui_accept when the resume button is selected resumes the game
		if Input.is_action_just_pressed("ui_accept") and pause_selected == RESUME:
			var new_pause_state = not get_tree().paused
			get_tree().paused = new_pause_state
			$PauseMenu.set_visible(new_pause_state)
			current_menu = NONE
			PauseMusic.stop()
		# Pressing ui_accept when the settings button is selected opens a popup
		if Input.is_action_just_pressed("ui_accept") and pause_selected == SETTINGS:
			$SettingsMenu.set_visible(true)
			current_menu = SETTINGS_MENU
		# Pressing ui_accept when the main menu button is selected returns us to
		# the main menu
		if Input.is_action_just_pressed("ui_accept") and pause_selected == MAIN_MENU:
			var new_pause_state = not get_tree().paused
			get_tree().paused = new_pause_state
			$PauseMenu.set_visible(new_pause_state)
			current_menu = NONE
			Music.stop()
			get_tree().change_scene("res://ui/main/MainMenu.tscn")
	
	# On the settings menu, pressing the arrow keys changes the volume
	elif current_menu == SETTINGS_MENU:
		if Input.is_action_just_pressed("ui_left"):
			if settings_selected == VOLUME1:
				settings_selected = VOLUME0
				$SettingsMenu/Volume1.hide()
				$SettingsMenu/Volume0.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)
			elif settings_selected == VOLUME2:
				settings_selected = VOLUME1
				$SettingsMenu/Volume2.hide()
				$SettingsMenu/Volume1.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -40)
			elif settings_selected == VOLUME3:
				settings_selected = VOLUME2
				$SettingsMenu/Volume3.hide()
				$SettingsMenu/Volume2.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -20)
		if Input.is_action_just_pressed("ui_right"):
			if settings_selected == VOLUME0:
				settings_selected = VOLUME1
				$SettingsMenu/Volume0.hide()
				$SettingsMenu/Volume1.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -40)
			elif settings_selected == VOLUME1:
				settings_selected = VOLUME2
				$SettingsMenu/Volume1.hide()
				$SettingsMenu/Volume2.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -20)
			elif settings_selected == VOLUME2:
				settings_selected = VOLUME3
				$SettingsMenu/Volume2.hide()
				$SettingsMenu/Volume3.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)
