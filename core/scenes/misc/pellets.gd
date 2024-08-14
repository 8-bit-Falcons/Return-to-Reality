extends Area2D


var direction : Vector2 = Vector2.DOWN
var speed : float = 100

func _physics_process(delta):
	position += direction * speed * delta

func _on_area_entered(area):
	area = Area2D
	queue_free()
