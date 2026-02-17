extends Area2D

@onready var label: Label = $Label

var interactible = false

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		interactible = true
		label.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		interactible = false
		label.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interactible:
		get_tree().quit()
