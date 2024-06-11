extends Area2D

var burn_damage = 4
var player_instance: int = -1

func _ready():
	$Timer.start()
	$DotTimer.start()


func _on_dot_timer_timeout():
	for body in get_overlapping_bodies():
		if "hit" in body and body.player_instance != self.player_instance:
			body.hit(burn_damage)
	

func _on_timer_timeout():
	queue_free()
