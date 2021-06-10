extends KinematicBody2D

signal dying

const TIME_BETWEEN_HITS = 0.5  # seconds
# Last number is how many flashes; this ensures that flashes are consistent & divisible
const FLASH_FREQ = TIME_BETWEEN_HITS / 5
# normal color; damage color
const COLOR_DAMAGE = ["ffffff", "ff9c9c"]
const MINIMUM_HEALTH = 0 # death health
const FADE_RATE = 0.1  # value between 0 and 1 for how much to fade per frame

var health = 2
var dead = false  # this isn't really needed but I added it for simplicity's sake
var time_since_hit = 0.0
var time_since_flash = 0.0
var damagecolor_active: bool = false


func _ready():
	pass
	#$AnimatedSprite.play("summoned")
	
func _physics_process(delta):
	if dead:
		$AnimatedSprite.modulate.a -= FADE_RATE

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

func die():
	dead = true
	emit_signal("dying")
	$CollisionShape2D.set_deferred("disabled", true)
	$Area2D/TophatHitbox.set_deferred("disabled", true)

func _on_Area2D_body_entered(body):
	if time_since_hit == 0.0:
		health -= 1
		if health >= MINIMUM_HEALTH:
			time_since_hit = 0.001
		else:
			die()
