extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationTimer.start()



func _on_animation_timer_timeout():
	queue_free()


func _on_body_entered(body):
	if "shatter" in body:
		body.shatter()
