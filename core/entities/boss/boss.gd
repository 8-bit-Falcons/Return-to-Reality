extends KinematicBody2D

const TIME_BETWEEN_HITS = 0.5  # seconds
# Last number is how many flashes; this ensures that flashes are consistent & divisible
const FLASH_FREQ = TIME_BETWEEN_HITS / 5
# normal color; damage color
const COLOR_DAMAGE = ["ffffff", "ff9c9c"]

var health = 3
var time_since_hit = 0.0
var time_since_flash = 0.0
var damagecolor_active: bool = false


func _ready():
	pass
	#$AnimatedSprite.play("summoned")
	
func _process(delta):
	if time_since_hit > 0.0:
		time_since_hit += delta
		time_since_flash += delta
		if time_since_hit > TIME_BETWEEN_HITS:
			time_since_hit = 0.0
			change_color(false)

		if time_since_flash > FLASH_FREQ:
			change_color(not damagecolor_active)

func change_color(active: bool):
	time_since_flash = 0.0
	damagecolor_active = active
	$AnimatedSprite.modulate = Color(COLOR_DAMAGE[int(damagecolor_active)])

func _on_Area2D_body_entered(body):
	if time_since_hit == 0.0:
		time_since_hit = 0.001
		health -= 1
		print('ouch. %f health' % health)
