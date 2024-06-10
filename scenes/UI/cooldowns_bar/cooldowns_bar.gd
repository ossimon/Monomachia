extends Node2D

@export var player_instance: int

@export var timer1: Timer
@export var timer2: Timer
@export var timer3: Timer

func set_timers():
	# get the player that has player_instance equal to the one we have
	# this player is a child of our parent node
	# there are multiple players in the scene, but we only want to get the one that is ours
	var player = null
	for child in get_parent().get_children():
		if not child.has_method("get_ability_cooldown_timers"):
			continue
		if child.get("player_instance") == player_instance:
			player = child
			break

	if player == null:
		return

	# get the cooldown timers from the player
	var timers = player.get_ability_cooldown_timers()
	timer1 = timers[0]
	timer2 = timers[1]
	timer3 = timers[2]

func _ready():
	set_timers()

func _process(_delta):
	if timer1:
		$CooldownIcon1.update(timer1)
	if timer2:
		$CooldownIcon2.update(timer2)
	if timer3:
		$CooldownIcon3.update(timer3)
