extends Node

var my_peer_id: int = 1

var players : Array[PlayerController]

func set_peer_id(id: int):
	my_peer_id = id
	print("NetworkManager: Set peer ID to ", id)

func get_peer_id():
	return my_peer_id
