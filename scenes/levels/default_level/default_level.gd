extends Sprite2D

var bullet_scene: PackedScene = preload("res://scenes/Projectiles/Bullet/bullet.tscn")
var ability_scene: PackedScene = preload("res://scenes/Projectiles/Shatter/shatter.tscn")
var player_wall: PackedScene = preload("res://scenes/obstacles/Block/player_wall.tscn")
signal player_bullet


func _on_player_bullet(bullet_position, direction):
	var bullet = bullet_scene.instantiate()
	bullet.position = bullet_position
	bullet.rotation = direction.angle()
	add_child(bullet)

func _on_player_2_bullet(bullet_position, direction):
	var bullet = bullet_scene.instantiate()
	bullet.position = bullet_position
	bullet.rotation = direction.angle()
	add_child(bullet)


func _on_player_ability(pos, dir):
	var ability = ability_scene.instantiate()
	ability.position = pos
	ability.rotation = dir.angle()
	add_child(ability)

func _on_player_2_ability(pos, dir):
	var ability = ability_scene.instantiate()
	ability.position = pos
	ability.rotation = dir.angle()
	add_child(ability)

func _on_player_build_wall(pos, dir):
	var wall = player_wall.instantiate()
	wall.position = pos
	wall.rotation = dir.angle()
	add_child(wall)

func _on_player_2_build_wall(pos, dir):
	var wall = player_wall.instantiate()
	wall.position = pos
	wall.rotation = dir.angle()
	add_child(wall)
