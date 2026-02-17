extends Area2D

class_name Key

@export var door : AreaExit

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		if door:
			door.open()
		queue_free()
