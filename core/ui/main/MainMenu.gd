extends Control

export(String, FILE, "*tscn") var next_world

enum {MAIN_MENU, SETTINGS_MENU} # Defines menus
enum {VOLUME0 = -80, VOLUME1 = -40, VOLUME2 = -20, VOLUME3 = 0} # Defines settings menu buttons
var current_menu = MAIN_MENU # The menu currently open
var play_selected = true # Is the play button currently selected?
var settings_file = "user://settings.save"
var settings_selected = load_settings() # The button selected on the settings menu

# Called when the node enters the scene tree for the first time.
func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), settings_selected)
	if not Music.stream == load("res://assets/music/Menu Music.mp3"):
		Music.stream = load("res://assets/music/Menu Music.mp3")
		Music.play()
	$CenterContainer/SettingsSelected.hide()
	$CenterContainer/PlaySelected.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_menu == MAIN_MENU:
		if Input.is_action_pressed("ui_right"):
			play_selected = false
			$CenterContainer/PlaySelected.hide()
			$CenterContainer/SettingsSelected.show()
		if Input.is_action_pressed("ui_left"):
			play_selected = true
			$CenterContainer/PlaySelected.show()
			$CenterContainer/SettingsSelected.hide()
		if Input.is_action_pressed("ui_accept") and play_selected:
			$Fade/AnimationPlayer.play("Fade")
			yield(get_tree().create_timer(0.5), "timeout")
			get_tree().change_scene(next_world)
		if Input.is_action_pressed("ui_accept") and not play_selected:
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
	else:
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
		if Input.is_action_just_pressed("pause"):
			$SettingsMenu.set_visible(false)
			current_menu = MAIN_MENU
		
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
