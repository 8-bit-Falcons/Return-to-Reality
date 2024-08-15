extends Area2D

var direction : Vector2 = Vector2.DOWN
var speed : float = 175

func _physics_process(delta):
	position += direction * speed * delta

func _on_area_entered(area):
	area = Area2D
	queue_free()

func _on_body_entered(body):
	await get_tree().create_timer(0.1).timeout
	get_tree().reload_current_scene()
