extends Node2D

const GRID_WIDTH = 20
const GRID_HEIGHT = 15

var wave_alive = false
var diagonal_offset = 0
var divine_sword_scene: PackedScene = preload("res://scenes/Projectiles/DivineSword/DivineSword.tscn")


func spawn_wave_of_nodes(scene):
	if diagonal_offset > 0:
		return
	wave_alive = true
	spawn_diagonal()
	
func spawn_diagonal():
	if not wave_alive:
		return
	for i in range(max(0, diagonal_offset - GRID_HEIGHT + 1), min(diagonal_offset + 1, GRID_WIDTH)):
		var base_position = Vector2(-190, -140)
		var position_change = Vector2(i * 20, (diagonal_offset - i) * 20)
		print(Vector2(1, -1).angle())
		get_parent().get_parent().add_scene(divine_sword_scene, base_position + position_change, 0, get_parent().player_instance)
		
	diagonal_offset += 1

	$WaveTimer.start()

func _on_wave_timer_timeout():
	if diagonal_offset >= GRID_WIDTH + GRID_HEIGHT - 1:
		diagonal_offset = 0
		wave_alive = false
		return
	spawn_diagonal()
