extends Sprite2D

var bullet_scene: PackedScene = preload("res://scenes/Projectiles/Bullet/bullet.tscn")
var ability_scene: PackedScene = preload("res://scenes/Projectiles/Shatter/shatter.tscn")
var player_wall: PackedScene = preload("res://scenes/obstacles/Block/player_wall.tscn")

func add_scene(scene_scene, pos, rot, owner_id=-1):
	var scene = scene_scene.instantiate()
	scene.position = pos
	scene.rotation = rot
	if "owner_id" in scene:
		scene.owner_id = owner_id
	add_child(scene)

func build_wall(pos):
	$Labirynth.add_node_at_position(pos)
