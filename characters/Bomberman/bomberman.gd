extends CharacterBody2D

# the player's movement speed
var speed = 200

# let the player move freely with WASD keys

func _ready():
	
	# set the player's initial position
	position = Vector2(100, 100)

func _process(delta):
	
	velocity = Vector2.ZERO
	# move the player
	if Input.is_action_pressed("Move right"):
		velocity.x = 1
	if Input.is_action_pressed("Move left"):
		velocity.x = -1
	if Input.is_action_pressed("Move down"):
		velocity.y = 1
	if Input.is_action_pressed("Move up"):
		velocity.y = -1
	velocity = velocity.normalized() * speed
	move_and_slide()
