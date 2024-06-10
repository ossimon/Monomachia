extends Node2D

func update(timer: Timer):
	if timer.is_stopped():
		$TextureProgressBar.value = 0
		return
	
	$TextureProgressBar.value = timer.time_left * 100 / timer.wait_time

