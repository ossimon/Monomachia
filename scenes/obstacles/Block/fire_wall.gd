extends Area2D

var burn_damage = 5

func _ready():
	$Timer.start()

func _on_body_entered(body):
	if "hit" in body:
		if body.name != "Lich":
			body.hit(burn_damage)

func _on_timer_timeout():
	queue_free()

