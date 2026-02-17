extends Area2D
class_name Lever

@export var gates : Array[Gate]
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var label: Label = $Label

var interactable = true

func _ready():
	sprite_2d.flip_h = true

func interact():
	rpc("_flip_lever")

@rpc("any_peer", "call_local", "reliable")
func _flip_lever():
	for gate in gates:
		gate.switch_pos()
	sprite_2d.flip_h = !sprite_2d.flip_h

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		body.object = self
		label.show()

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		body.object = null
		label.hide()
