#World_Complete.gd
extends Area2D

@export_file("*.tscn") var next_world

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			get_node("../Fade/AnimationPlayer").play("Fade")
			await get_tree().create_timer(0.5).timeout
			StageManager.change_stage(next_world)
