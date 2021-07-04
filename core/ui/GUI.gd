extends CanvasLayer

enum {NONE, PAUSE_MENU, SETTINGS_MENU} # Defines menus
enum {RESUME, SETTINGS, MAIN_MENU} # Defines pause menu buttons
enum {VOLUME0 = -80, VOLUME1 = -40, VOLUME2 = -20, VOLUME3 = 0} # Defines settings menu buttons
var current_menu = NONE # The menu currently open
var pause_selected = RESUME # The button selected on the pause menu
var settings_file = "res://settings.save"
var settings_selected = load_settings() # The button selected on the settings menu


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
		# Pressing ui_accept when the settings button is selected opens the
		# settings menu
		if Input.is_action_just_pressed("ui_accept") and pause_selected == SETTINGS:
			$SettingsMenu.set_visible(true)
			current_menu = SETTINGS_MENU
			if settings_selected == VOLUME0:
				$SettingsMenu/Volume0.show()
			elif settings_selected == VOLUME1:
				$SettingsMenu/Volume1.show()
			elif settings_selected == VOLUME2:
				$SettingsMenu/Volume2.show()
			else:
				$SettingsMenu/Volume3.show()
		# Pressing ui_accept when the main menu button is selected returns us to
		# the main menu
		if Input.is_action_just_pressed("ui_accept") and pause_selected == MAIN_MENU:
			var new_pause_state = not get_tree().paused
			get_tree().paused = new_pause_state
			$PauseMenu.set_visible(new_pause_state)
			current_menu = NONE
			Music.stop()
			PauseMusic.stop()
			get_tree().change_scene("res://ui/main/MainMenu.tscn")
	
	# On the settings menu, pressing the arrow keys changes the volume
	elif current_menu == SETTINGS_MENU:
		if Input.is_action_just_pressed("ui_left"):
			if settings_selected == VOLUME1:
				settings_selected = VOLUME0
				$SettingsMenu/Volume1.hide()
				$SettingsMenu/Volume0.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), set_volume(VOLUME0))
			elif settings_selected == VOLUME2:
				settings_selected = VOLUME1
				$SettingsMenu/Volume2.hide()
				$SettingsMenu/Volume1.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), set_volume(VOLUME1))
			elif settings_selected == VOLUME3:
				settings_selected = VOLUME2
				$SettingsMenu/Volume3.hide()
				$SettingsMenu/Volume2.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), set_volume(VOLUME2))
		if Input.is_action_just_pressed("ui_right"):
			if settings_selected == VOLUME0:
				settings_selected = VOLUME1
				$SettingsMenu/Volume0.hide()
				$SettingsMenu/Volume1.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), set_volume(VOLUME1))
			elif settings_selected == VOLUME1:
				settings_selected = VOLUME2
				$SettingsMenu/Volume1.hide()
				$SettingsMenu/Volume2.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), set_volume(VOLUME2))
			elif settings_selected == VOLUME2:
				settings_selected = VOLUME3
				$SettingsMenu/Volume2.hide()
				$SettingsMenu/Volume3.show()
				AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), set_volume(VOLUME3))
				
func save_settings():
	var f = File.new()
	f.open(settings_file, File.WRITE)
	f.store_var(settings_selected)
	f.close()

func load_settings():
	var f = File.new()
	if f.file_exists(settings_file):
		f.open(settings_file, File.READ)
		settings_selected = f.get_var()
		f.close()
	else:
		settings_selected = VOLUME3
	return settings_selected
		
func set_volume(volume):
	settings_selected = volume
	save_settings()
	return volume
