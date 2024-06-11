extends TextureProgressBar

func update(timer: Timer):
	if timer.is_stopped():
		self.value = 0
		$Label.text = ''
		return
	
	self.value = timer.time_left * 100 / timer.wait_time
	$Label.text = str(timer.time_left).left(3)
