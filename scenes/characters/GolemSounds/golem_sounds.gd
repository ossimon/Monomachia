extends Node2D

signal death_sound_finished

func play_attack():
	$AttackSound.play()
	
func play_death():
	$DeathSound.play()
	
func play_shoot():
	$ShootSound.play()

func play_place():
	$PlaceSound.play()

func _on_death_sound_finished():
	get_parent().die()
