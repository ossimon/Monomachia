extends CharacterBody2D
class_name Player

@export var player_instance: int = 1

# the player's movement speed
var movement_speed = 200
var facing_direction = Vector2.RIGHT

# health
var max_health = 100
var health = max_health


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


func hit(damage):
	health -= damage
	if health <= 0:
		# player died
		print("Player died")
		$GolemSounds.play_death()
	
	$HealthBar.value -= damage
	
func die():
	queue_free()

func use_ability1():
	pass
	
func use_ability2():
	pass

func use_ability3():
	pass

func use_ability4():
	pass

func use_abilities():
	if Input.is_action_pressed("p%d_ability1" % player_instance):
		use_ability1()
	if Input.is_action_pressed("p%d_ability2" % player_instance):
		use_ability2()
	if Input.is_action_pressed("p%d_ability3" % player_instance):
		use_ability3()
	if Input.is_action_pressed("p%d_ability4" % player_instance):
		use_ability4()

func _process(_delta):
	scope()
	move()
	use_abilities()

