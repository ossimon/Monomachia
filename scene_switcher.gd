extends Node

var current_scene = null
# Called when the node enters the scene tree for the first time.
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)

func switch_scene(res_path):
	call_deferred("_deferred_switch_scene", res_path)

func switch_scene_and_add_players(res_path, player1, player2):
	call_deferred("_deferred_switch_scene_and_add_players", res_path, player1, player2)
	
func _deferred_switch_scene(res_path):
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

func _deferred_switch_scene_and_add_players(res_path, player1, player2):
	current_scene.free()
	var s = load(res_path)
	current_scene = s.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	
	player1 = load(player1).instantiate()
	player1.player_instance = 1
	player1.position = Vector2(40, 80)
	player2 = load(player2).instantiate()
	player2.player_instance = 2
	player2.position = Vector2(-40, -80)
	get_tree().current_scene.add_child(player1)
	get_tree().current_scene.add_child(player2)
	get_tree().current_scene.get_node("CooldownsBar1").set_timers()
	get_tree().current_scene.get_node("CooldownsBar2").set_timers()
