extends Area2D

var damage: int = 40

@export var owner_id: int = -1 

func _ready():
	$SwingTimer.start()

func _on_body_entered(body):
	if "player_instance" in body and body.player_instance == owner_id:
		return
	if "hit" in body:
		body.hit(damage)
	#queue_free()

func _on_swing_timer_timeout():
	queue_free()
