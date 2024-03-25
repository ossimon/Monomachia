extends Area2D

@export var speed: int = 400
var direction: Vector2 = Vector2.UP
var damage: int = 15

func _ready():
	# get vector from rotation
	direction = Vector2(cos(rotation), sin(rotation))
	$SelfDestructTimer.start()

func _process(delta):
	position += direction * speed * delta


func _on_body_entered(body):
	print('body hit')
	if "hit" in body:
		body.hit(damage)
	queue_free()


func _on_self_destruct_timer_timeout():
	queue_free()
