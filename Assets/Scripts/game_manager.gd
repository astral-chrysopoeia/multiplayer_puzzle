extends Node

var area_path = "res://Assets/Scenes/Areas/"
var spawn_pos: Vector2 = Vector2.ZERO
var player : PlayerController
var area_container : Node2D
var is_paused : bool = false
var current_level : String

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	player = get_tree().get_first_node_in_group("player")
	area_container = get_tree().get_first_node_in_group("area_container")
	to_area("tutorial_level")
	current_level = "tutorial_level"

func to_area(destination: String):
	var full_path = area_path + destination + ".tscn"
	var scene = load(full_path) as PackedScene
	if !scene:
		return
	#remove the previous scene
	for child in area_container.get_children():
		child.queue_free()
		await child.tree_exited
	#set up new scene
	var instance = scene.instantiate()
	area_container.add_child(instance)
	player.to_spawn()
	current_level = destination
