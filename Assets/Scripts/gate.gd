extends StaticBody2D
class_name Gate

@export var pos1 : Vector2
@export var pos2 : Vector2

var atPos = 1

func switch_pos():
	if atPos == 1:
		atPos = 2
		transform.origin = pos2
		return
	elif atPos == 2:
		atPos = 1
		transform.origin = pos1
		return
