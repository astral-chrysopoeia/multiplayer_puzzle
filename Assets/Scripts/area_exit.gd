extends Area2D
class_name AreaExit

@export var destination : String
@export var destinationX = 0.0
@export var destinationY = 0.0
@export var sprite : Sprite2D
@export var locked = false
@export var keys : Array[Key]
@export var levelManager : Node2D
@onready var label: Label = $Label

var interactable = false
var player_overlapping : PlayerController
var players_overlapping : Array[PlayerController]

func _ready():
	if keys != null:
		close()

func open():
	for key in keys:
		if key:
			if !key.pickedup:
				return
	locked = false
	interactable = true
	sprite.region_rect.position.x = 16
	label.text = "Enter (E)"

func close():
	locked = true
	sprite.region_rect.position.x = 0
	label.text = "Door Locked!"
	

func interact():
	exit_area()

func _on_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		body.object = self
		players_overlapping.append(body)
		label.show()

func _on_body_exited(body: Node2D) -> void:
	if body is PlayerController:
		body.object = null
		players_overlapping.erase(body)
		label.hide()

func exit_area():
	for player in players_overlapping:
		player.next_spawn = Vector2(destinationX, destinationY)
		rpc("player_can_leave", player.playerID)
	levelManager.gameplay_manager.try_next_level(destination)

@rpc("any_peer", "call_local", "reliable")
func player_can_leave(id: String):
	for player in NetworkManager.players:
		if player.playerID == id:
			player.can_leave = true
	
