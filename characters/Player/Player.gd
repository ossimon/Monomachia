extends CharacterBody2D

# the player's movement speed
var movement_speed = 200
var facing_direction = Vector2.RIGHT

# health
var max_health = 100
var health = max_health

# abilities
var can_shoot: bool = true


func _ready():
	health = max_health

# take damage
func _on_player_damage(amount):
	health -= amount
	print("Player took", amount, "damage. Health:", health)
	if health <= 0:
		# player died
		print("Player died")
		queue_free()

func move():
	velocity = Vector2.ZERO
	# move the player
	if Input.is_action_pressed("Move right"):
		velocity.x += 1
		facing_direction = Vector2.RIGHT
	if Input.is_action_pressed("Move left"):
		velocity.x += -1
		facing_direction = Vector2.LEFT
	if Input.is_action_pressed("Move down"):
		velocity.y += 1
		facing_direction = Vector2.DOWN
	if Input.is_action_pressed("Move up"):
		velocity.y += -1
		facing_direction = Vector2.UP

	velocity = velocity.normalized() * movement_speed
	move_and_slide()

func shoot():
	if Input.is_action_just_pressed("Shoot") and can_shoot:
		# # create a bullet
		# var bullet = Bullet.instance()
		# # set the bullet's position
		# bullet.global_position = global_position
		# # set the bullet's direction
		# bullet.direction = facing_direction
		# # add the bullet to the scene
		# get_parent().add_child(bullet)
		# disable shooting for a short time
		can_shoot = false
		print("Player shot")

# let the player move freely with WASD keys
func _process(_delta):
	move()
	shoot()


func _on_shooting_cooldown():
	can_shoot = true
