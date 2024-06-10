extends Node2D

func update(timer: Timer):
	if timer.is_stopped():
		$TextureProgressBar.value = 0
		$Label.text = ''
		return
	
	$TextureProgressBar.value = timer.time_left * 100 / timer.wait_time
	# show one decimal place
	$Label.text = str(timer.time_left).left(3)

