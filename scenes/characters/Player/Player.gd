extends CharacterBody2D

# signals
signal bullet(pos, dir)
signal ability(pos, dir)

# the player's movement speed
var movement_speed = 200
var facing_direction = Vector2.RIGHT

# health
var max_health = 100
var health = max_health

# abilities
var can_shoot: bool = true
var can_ability: bool = true


func _ready():
	health = max_health
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health


func move():
	velocity = Vector2.ZERO

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
	# if Input.is_action_just_pressed("Shoot") and can_shoot:
	if Input.is_action_pressed("Shoot") and can_shoot:
		var bullet_position = position + facing_direction * 20
		var bullet_direction = facing_direction
		bullet.emit(bullet_position, bullet_direction)

		can_shoot = false
		$ShootingTimer.start()


func hit(damage):
	health -= damage
	if health <= 0:
		# player died
		print("Player died")
		queue_free()
	
	$HealthBar.value -= damage
	

func shatter():
	pass


func use_abilities():
	if Input.is_action_pressed("Ability") and can_ability:
		var ability_position = position + facing_direction * 15
		var ability_direction = facing_direction
		ability.emit(ability_position, ability_direction)

		can_ability = false
		$AbilityTimer.start()
	

func _process(_delta):
	move()
	shoot()
	use_abilities()


func _on_shooting_cooldown():
	can_shoot = true


func _on_ability_timer_timeout():
	can_ability = true
