extends Area2D

class_name Key

@export var doors : Array[AreaExit]

var pickedup := false

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		rpc("pickup")

@rpc("any_peer", "call_local", "reliable")
func pickup():
	pickedup = true
	if doors:
		for door in doors:
			door.open()
	queue_free()
