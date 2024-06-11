extends Player

var bullet_scene: PackedScene = preload("res://scenes/Projectiles/Bullet/bullet.tscn")
var shatter_scene: PackedScene = preload("res://scenes/Projectiles/Shatter/shatter.tscn")
var fire_wall_scene: PackedScene = preload("res://scenes/obstacles/Block/fire_wall.tscn")
var shield_scene: PackedScene = preload("res://scenes/Projectiles/Shield/shield.tscn")

# build distance
var build_distance = 25

# abilities
var can_shoot: bool = true
var can_ability: bool = true
var can_build_wall: bool = true
var can_shield: bool = true

func use_ability1():
	shoot()
	
func use_ability2():
	build_walls()

func use_ability3():
	use_shield()

func use_ability4():
	use_shatter()

func shoot():
	if not can_shoot:
		return
	var bullet_direction = $Scope.get_aim_vec()
	var bullet_position = position + bullet_direction * 20

	get_parent().add_scene(bullet_scene, bullet_position, bullet_direction.angle())
	can_shoot = false
	$ShootingTimer.start()
	$GolemSounds.play_shoot()

func build_walls():
	if not can_build_wall:
		return
	var wall_direction = $Scope.get_aim_vec()
	var wall_position = position
	
	owner.get_node("Labirynth").add_node_around_position(wall_position, "FireWall", player_instance)
	
	can_build_wall = false
	$WallTimer.start()
	$GolemSounds.play_place()

func use_shield():
	if not can_shield:
		return
	var shield = shield_scene.instantiate()
	
	self.add_child(shield)
		
	can_shield = false
	$ShieldTimer.start()
	$GolemSounds.play_heal()
		
func use_shatter():
	if not can_ability:
		return
	var ability_direction = $Scope.get_aim_vec()
	var ability_position = position + ability_direction * 15
	#ability.emit(ability_position, ability_direction)
	get_parent().add_scene(shatter_scene, ability_position, ability_direction.angle())

	can_ability = false
	$AbilityTimer.start()
	$GolemSounds.play_attack()

func _on_shooting_timer_timeout():
	can_shoot = true

func _on_ability_timer_timeout():
	can_ability = true
	
func _on_wall_timer_timeout():
	can_build_wall = true

func _on_healing_timer_timeout():
	can_shield = true

func get_ability_cooldown_timers():
	return [$AbilityTimer, $WallTimer, $ShieldTimer]
