extends StaticBody2D

signal is_shattered(pos)

func shatter():
	is_shattered.emit(position)
	queue_free()
