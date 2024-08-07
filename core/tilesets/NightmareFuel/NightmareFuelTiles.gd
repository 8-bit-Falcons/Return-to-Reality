extends TileMap


func _on_area_2d_body_entered(body):
	get_node("../Fade/AnimationPlayer").play("Fade")
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
