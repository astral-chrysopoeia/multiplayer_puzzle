extends Area2D
class_name AreaExit

@export var destination : String
@export var destinationX = 0.0
@export var destinationY = 0.0
@export var sprite : Sprite2D
@export var locked = false
@export var key : Key
@onready var label: Label = $Label

var can_interact = false

func _ready():
	if key:
		close()

func open():
	locked = false
	sprite.region_rect.position.x = 16
	label.text = "Enter (E)"

func close():
	locked = true
	sprite.region_rect.position.x = 0
	label.text = "Door Locked!"
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and can_interact:
		exit_area()

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		if !locked:
			can_interact = true
		label.show()

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		can_interact = false
		label.hide()

func exit_area():
	GameManager.spawn_pos = Vector2(destinationX, destinationY)
	GameManager.to_area(destination)
