extends Area2D


var direction : Vector2 = Vector2.DOWN
var speed : float = 200

func _physics_process(delta):
	position += direction * speed * delta

func _on_screen_exited():
	queue_free()
