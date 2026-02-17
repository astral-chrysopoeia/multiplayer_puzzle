extends Node2D

@export var singleplayerMode = false

@onready var spawner: MultiplayerSpawner = $MultiplayerSpawner
@onready var area: Node2D = $Area

const playerScene := preload("res://Assets/Scenes/player.tscn")
const tutorialScene := preload("res://Assets/Scenes/Areas/tutorial_level.tscn")
const PORT := 7000
const MAX_CLIENTS := 3

func _ready():
	var demoScene := tutorialScene.instantiate()
	area.add_child(demoScene)
	
	if singleplayerMode:
		print("Singleplayer Mode")
		var player := playerScene.instantiate()
		player.playerID = "1"
		add_child(player)
		return
	
	spawner.add_spawnable_scene(playerScene.resource_path)
	spawner.spawn_function = _spawn_player
	
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	
	if "--client" in OS.get_cmdline_args():
		print("Starting as CLIENT")
		await get_tree().create_timer(0.5).timeout
		join_game("127.0.0.1")
	else:
		print("Starting as SERVER")
		host_game()

func host_game():
	var peer := ENetMultiplayerPeer.new()
	var err := peer.create_server(PORT, MAX_CLIENTS)
	if err != OK:
		push_error("Failed to start server: %s" % err)
		return
	
	multiplayer.multiplayer_peer = peer
	print("Server started on port ", PORT)
	spawn_player(multiplayer.get_unique_id())

func join_game(address: String):
	var peer := ENetMultiplayerPeer.new()
	var err := peer.create_client(address, PORT)
	if err != OK:
		push_error("Failed to join server: %s" % err)
		return
	
	multiplayer.multiplayer_peer = peer
	print("Connecting to ", address, ":", PORT)

func spawn_player(peer_id: int):
	if not multiplayer.is_server():
		return
	
	print("Requesting spawn for peer: ", peer_id)
	spawner.spawn(peer_id)

func _spawn_player(peer_id: int):
	var player = playerScene.instantiate()
	player.playerID = str(peer_id)
	
	player.set_multiplayer_authority(peer_id)
	
	print("Spawned player node for peer: ", peer_id)
	return player

func _on_peer_connected(id: int):
	print("Peer Connected: ", id)
	if multiplayer.is_server():
		spawn_player(id)

func _on_peer_disconnected(id: int):
	print("Peer Disconnected: ", id)
	if has_node(str(id)):
		get_node(str(id)).queue_free()

#Client Event: connected to server
func _on_connected_to_server():
	print("Connected to server")
	print("My peer ID: ", multiplayer.get_unique_id())

#Client Event: connection failed
func _on_connection_failed():
	print("Failed to connect")
