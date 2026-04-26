extends CanvasLayer

func _on_singleplayer_button_pressed() -> void:
	Globals.singleplayer = true
	get_tree().change_scene_to_file("res://Assets/Scenes/gameplay.tscn")

func _on_host_game_button_pressed() -> void:
	Globals.singleplayer = false
	Globals.client_type = Globals.CLIENT_TYPES.HOST
	get_tree().change_scene_to_file("res://Assets/Scenes/gameplay.tscn")


func _on_join_game_button_pressed() -> void:
	Globals.singleplayer = false
	Globals.client_type = Globals.CLIENT_TYPES.CLIENT
	get_tree().change_scene_to_file("res://Assets/Scenes/gameplay.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()
