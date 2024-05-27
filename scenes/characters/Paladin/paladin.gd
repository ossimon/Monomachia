extends Player

var bullet_scene: PackedScene = preload("res://scenes/Projectiles/Bullet/bullet.tscn")
var hammer_scene: PackedScene = preload("res://scenes/Projectiles/Hammer/Hammer.tscn")
var divine_sword_scene: PackedScene = preload("res://scenes/Projectiles/DivineSword/DivineSword.tscn")

# build distance
var build_distance = 25

# abilities
var can_hammer: bool = true
var can_shield: bool = true
var can_knockback: bool = true
var can_divine_punishment: bool = true

func use_ability1():
	swing_hammer()
	
func use_ability2():
	place_shield_wall()

func use_ability3():
	knockback()

func use_ability4():
	cast_divine_punishment()
	
func swing_hammer():
	if not can_hammer:
		return
		
	var hammer_direction = $Scope.get_aim_vec()
	var hammer_position = position + hammer_direction * 20

	get_parent().add_scene(hammer_scene, hammer_position, hammer_direction.angle(), player_instance)

	can_hammer = false
	$HammerTimer.start()
	$GolemSounds.play_shoot()
	
func place_shield_wall():
	pass
	
func knockback():
	pass
	
func cast_divine_punishment():
	if not can_divine_punishment:
		return
	
	$DivinePunishment.spawn_wave_of_nodes(divine_sword_scene)
	
	can_divine_punishment = false
	$DivinePunishmentTimer.start()
	$GolemSounds.play_shoot()
			

func play_death_sound():
	$GolemSounds.play_death()

func _on_hammer_timer_timeout():
	can_hammer = true


func _on_divine_punishment_timer_timeout():
	can_divine_punishment = true
