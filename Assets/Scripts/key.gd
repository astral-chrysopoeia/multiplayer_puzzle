extends Area2D

class_name Key

@export var door : AreaExit

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		rpc("pickup")

@rpc("any_peer", "call_local", "reliable")
func pickup():
	print("pickup")
	if door:
		door.open()
	queue_free()
