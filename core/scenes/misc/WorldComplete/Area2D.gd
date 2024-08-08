#World_Complete.gd
extends Area2D

@export_file("*.tscn") var next_world

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			StageManager.change_stage(next_world)
