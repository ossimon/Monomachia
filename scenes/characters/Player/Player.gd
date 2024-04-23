extends CharacterBody2D

@export var player_instance: int = 1

# signals
signal bullet(pos, dir)
signal ability(pos, dir)
signal build_wall(pos, dir)


# the player's movement speed
var movement_speed = 200
var facing_direction = Vector2.RIGHT

# build distance
var build_distance = 25

# health
var max_health = 100
var health = max_health

# abilities
var can_shoot: bool = true
var can_ability: bool = true
var can_build_wall: bool = true
var can_heal: bool = true

func _ready():
	health = max_health
	$HealthBar.max_value = max_health
	$HealthBar.value = max_health

func scope():
	var aim_vector: Vector2 = Vector2.ZERO
	if player_instance == 1:
		aim_vector = get_global_mouse_position() - global_position
	else:
		# get right stick position
		aim_vector = Vector2(Input.get_joy_axis(0, JOY_AXIS_RIGHT_X), Input.get_joy_axis(0, JOY_AXIS_RIGHT_Y))
		if abs(aim_vector.x) < 0.5 and abs(aim_vector.y) < 0.5:
			return

	aim_vector = aim_vector.normalized()
	$Scope.aim(aim_vector)


func move():
	velocity = Vector2.ZERO
	if Input.is_action_pressed("p%d_move_right" % player_instance):
		velocity.x += 1
		facing_direction = Vector2.RIGHT
	if Input.is_action_pressed("p%d_move_left" % player_instance):
		velocity.x += -1
		facing_direction = Vector2.LEFT
	if Input.is_action_pressed("p%d_move_down" % player_instance):
		velocity.y += 1
		facing_direction = Vector2.DOWN
	if Input.is_action_pressed("p%d_move_up" % player_instance):
		velocity.y += -1
		facing_direction = Vector2.UP

	velocity = velocity.normalized() * movement_speed
	move_and_slide()


func shoot():
	if Input.is_action_pressed("p%d_shoot" % player_instance) and can_shoot:
		var bullet_direction = $Scope.get_aim_vec()
		var bullet_position = position + bullet_direction * 20
		bullet.emit(bullet_position, bullet_direction)

		can_shoot = false
		$ShootingTimer.start()

		# play shooting sound from GolemSounds scene
		$GolemSounds.play_shoot()


func hit(damage):
	health -= damage
	if health <= 0:
		# player died
		print("Player died")
		$GolemSounds.play_death()
	
	$HealthBar.value -= damage
	
func die():
	queue_free()


func use_shatter():
	if Input.is_action_pressed("p%d_ability" % player_instance) and can_ability:
		var ability_direction = $Scope.get_aim_vec()
		var ability_position = position + ability_direction * 15
		ability.emit(ability_position, ability_direction)

		can_ability = false
		$AbilityTimer.start()
		
		$GolemSounds.play_attack()


func use_heal():
	if Input.is_action_pressed("p%d_heal" % player_instance) and can_heal:
		health = max_health
		$HealthBar.value = max_health
		can_heal = false
		$HealingTimer.start()
		$GolemSounds.play_heal()


func use_abilities():
	use_shatter()
	use_heal()
	
	
func build_walls():
	if Input.is_action_pressed("p%d_build_wall" % player_instance) and can_build_wall:
		var wall_direction = $Scope.get_aim_vec()
		var wall_position = position + wall_direction * build_distance
		build_wall.emit(wall_position, wall_direction)
		
		can_build_wall = false
		$WallTimer.start()
		$GolemSounds.play_place()
		

func _process(_delta):
	scope()
	move()
	shoot()
	use_abilities()
	build_walls()


func _on_shooting_cooldown():
	can_shoot = true


func _on_ability_timer_timeout():
	can_ability = true
	
func _on_wall_timer_timeout():
	can_build_wall = true


func _on_healing_timer_timeout():
	can_heal = true
