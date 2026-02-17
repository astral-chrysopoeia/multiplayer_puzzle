extends CanvasLayer

func _ready():
	visible = false
	get_tree().paused = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			visible = false
			get_tree().paused = false
		else:
			visible = true
			get_tree().paused = true

func _on_resume_pressed() -> void:
	visible = false
	get_tree().paused = false

func _on_reset_level_pressed() -> void:
	GameManager.to_area(GameManager.current_level)
	visible = false
	get_tree().paused = false

func _on_quit_pressed() -> void:
	get_tree().quit()
