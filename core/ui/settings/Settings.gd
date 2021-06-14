extends Control

var volume = 3

func _process(delta):
	if visible:
		if Input.is_action_pressed("ui_right"):
			if volume == 0:
				volume = 1
				$Volume0.hide()
				$Volume1.show()
			elif volume == 1:
				volume = 2
				$Volume1.hide()
				$Volume2.show()
			elif volume == 2:
				volume = 3
				$Volume2.hide()
				$Volume3.show()
		if Input.is_action_pressed("ui_left"):
			if volume == 1:
				volume = 0
				$Volume1.hide()
				$Volume0.show()
			elif volume == 2:
				volume = 1
				$Volume2.hide()
				$Volume1.show()
			elif volume == 3:
				volume = 2
				$Volume3.hide()
				$Volume2.show()
