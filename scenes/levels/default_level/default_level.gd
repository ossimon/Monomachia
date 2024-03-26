extends Sprite2D

var bullet_scene: PackedScene = preload("res://scenes/Projectiles/Bullet/bullet.tscn")

signal player_bullet

func _on_player_bullet(bullet_position, direction):
	var bullet = bullet_scene.instantiate()
	bullet.position = bullet_position
	bullet.rotation = direction.angle()
	add_child(bullet)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
