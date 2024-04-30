extends Node2D

const Block = preload("res://scenes/obstacles/Block/block.tscn")
const PlayerWall = preload("res://scenes/obstacles/Block/player_wall.tscn")

const WALL_SIZE = Vector2(20, 20)
const OFFSET = 10

const GRID_WIDTH = 20
const GRID_HEIGHT = 15

var grid = []

func _ready():
	grid = generate_grid(GRID_WIDTH, GRID_HEIGHT)
	#print_grid()

func generate_grid(width, height):
	var grid = []
	for i in range(height):
		grid.append([])
		for j in range(width):
			if randf() < 0.2:
				grid[i].append(true)
				add_block_at_position(position_from_grid_index(j, i))
			else:
				grid[i].append(false)
	return grid

func print_grid():
	for row in grid:
		print(row)

func position_to_grid_index(pos):
	var x_index = int((round(pos.x) + 200) / WALL_SIZE.x)
	var y_index = int((round(pos.y) + 150) / WALL_SIZE.y)
	#print("Position: ", pos.x, " ", pos.y, " to ", "Index: ",x_index, " ", y_index)
	return [x_index, y_index]
	
func position_from_grid_index(x, y):
	return Vector2(
		x * WALL_SIZE.x - (200 - OFFSET),
		y * WALL_SIZE.y - (150 - OFFSET)
	)
	
func add_node_at_position(pos):
	if is_out_of_bounds(pos):
		print("Building out of bounds")
		return

	var grid_index = position_to_grid_index(pos)
	var x = grid_index[0]
	var y = grid_index[1]
	
	if !is_node_at_position(x, y):
		var node = PlayerWall.instantiate()
		node.connect("is_shattered", _on_player_wall_is_shattered)
		
		node.position = position_from_grid_index(x, y)
		add_child(node)
		grid[y][x] = true
	else:
		print("Can't build a wall")

func remove_node_at_position(pos):
	var grid_index = position_to_grid_index(pos)
	var x = grid_index[0]
	var y = grid_index[1]
	
	if is_node_at_position(x, y):
		grid[y][x] = false
	else:
		print("No need to remove")

func is_node_at_position(x, y):
	if (x > 0 && x <= GRID_WIDTH) && (y > 0 && y <= GRID_HEIGHT):
		return grid[y][x]

func is_out_of_bounds(pos):
	return (pos.x <= -200 || pos.x >= 200) || (pos.y <= -150 || pos.y >= 150)

func add_block_at_position(pos):
	var block_instance = Block.instantiate()
	block_instance.connect("is_shattered", _on_block_is_shattered)
	block_instance.position = pos
	add_child(block_instance)

func _on_player_wall_is_shattered(pos):
	remove_node_at_position(pos)
	
func _on_block_is_shattered(pos):
	remove_node_at_position(pos)
