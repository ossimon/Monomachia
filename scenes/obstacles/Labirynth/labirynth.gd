extends Node2D


var player_wall: PackedScene = preload("res://scenes/obstacles/Block/player_wall.tscn")

# Size of each cell
var wall_size = Vector2(20, 20) # You can adjust the size as needed

# Grid dimensions
var grid_width = 15
var grid_height = 20

# 2D array to store grid state
var grid = []

func _ready():
	
	# Initialize grid state
	for x in range(grid_width):
		grid.append([])
		for y in range(grid_height):
			grid[x].append(false)  # Initially, no node is present

func position_to_grid_index(pos):
	var x_index = int(round(pos.x / wall_size.x))
	var y_index = int(round(pos.y / wall_size.y))
	return [x_index, y_index]


func add_node_at_position(pos):
	print(pos)
	pos = position_to_grid_index(pos)
	print(pos)
	var x = pos[0]
	var y = pos[1]
	
	if (!is_node_at_position(x, y)):
		var wall = player_wall.instantiate()
		wall.connect("is_shattered", _on_player_wall_is_shattered)
		var center_position = Vector2((x + 0.5) * wall_size.x, (y + 0.5) * wall_size.y)
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

func is_node_at_position(x, y):
	return grid[x][y]
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_player_wall_is_shattered(pos):
	remove_node_at_position(pos)
