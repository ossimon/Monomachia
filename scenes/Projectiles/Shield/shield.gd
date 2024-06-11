extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()


func _on_timer_timeout():
	queue_free()


func _on_area_entered(area):
	if area.name == "Bullet":
		area.queue_free()
		queue_free()
