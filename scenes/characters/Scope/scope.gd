extends Marker2D

var aim_vec: Vector2 = Vector2(1, 0)
var dist_from_the_player: int = 15

func _ready():
	set_position(aim_vec * dist_from_the_player)


func aim(new_aim_vec: Vector2):
	aim_vec = new_aim_vec
	set_position(aim_vec * dist_from_the_player)
	rotation = aim_vec.angle()


func get_aim_vec():
	return aim_vec
