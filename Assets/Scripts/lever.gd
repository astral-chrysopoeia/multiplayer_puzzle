extends Area2D
class_name Lever

@export var gates : Array[Gate]
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var interactable = false

func _ready():
	sprite_2d.flip_h = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interactable:
		for gate in gates:
			gate.switch_pos()
		sprite_2d.flip_h = !sprite_2d.flip_h

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		interactable = true
		label.show()

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		interactable = false
		label.hide()
