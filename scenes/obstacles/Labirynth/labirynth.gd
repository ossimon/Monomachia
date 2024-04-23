extends Node2D


var player_wall: PackedScene = preload("res://scenes/obstacles/Block/player_wall.tscn")

var wall_size = Vector2(20, 20)
var offset = 10

var grid_width = 20
var grid_height = 15
# 2D array to store grid state
var grid = []

func _ready():
	for x in range(grid_width):
		grid.append([])
		for y in range(grid_height):
			grid[x].append(false)

func position_to_grid_index(pos):
	var x_index = int((round(pos.x) + 200) / wall_size.x)
	var y_index = int((round(pos.y) + 150) / wall_size.y)
	return [x_index, y_index]

func add_node_at_position(pos):
	if (pos.x <= -200 || pos.x >= 200) || (pos.y <= -150 || pos.y >= 150):
		print("Building out of bounds")
		return

	pos = position_to_grid_index(pos)
	var x = pos[0]
	var y = pos[1]
	
	if (!is_node_at_position(x, y)):
		var wall = player_wall.instantiate()
		wall.connect("is_shattered", _on_player_wall_is_shattered)
		var center_position = Vector2(
			(x * wall_size.x) - (200 - offset), 
			(y * wall_size.y) - (150 - offset)
		)
		wall.position = center_position
		add_child(wall)
		grid[x][y] = true
	else:
		print("Cant build a wall")

func remove_node_at_position(pos):
	pos = position_to_grid_index(pos)
	var x = pos[0]
	var y = pos[1]
	
	if (is_node_at_position(x, y)):
		grid[x][y] = false
	else:
		print("No wall")
	pass

func is_node_at_position(x, y):
	if (x > 0 && x <= grid_width) && (y > 0 && y <= grid_height):
		return grid[x][y]


func _on_player_wall_is_shattered(pos):
	remove_node_at_position(pos)
