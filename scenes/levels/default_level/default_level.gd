extends Sprite2D

var bullet_scene: PackedScene = preload("res://scenes/Projectiles/Bullet/bullet.tscn")
var ability_scene: PackedScene = preload("res://scenes/Projectiles/Shatter/shatter.tscn")

signal player_bullet


func _on_player_bullet(bullet_position, direction):
	var bullet = bullet_scene.instantiate()
	bullet.position = bullet_position
	bullet.rotation = direction.angle()
	add_child(bullet)


func _on_player_ability(pos, dir):
	var ability = ability_scene.instantiate()
	ability.position = pos
	ability.rotation = dir.angle()
	add_child(ability)
