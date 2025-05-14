extends Control

func _ready() -> void:
	$AnimationPlayer.play("RESET")
	$PanelContainer/VBoxContainer/ResumeButton.pressed.connect(resume)
	$PanelContainer/VBoxContainer/ExitButton.pressed.connect(exit)
	$PanelContainer/VBoxContainer/OptionsButton.pressed.connect(options)
	$PanelContainer/VBoxContainer/RestartButton.pressed.connect(restart)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused:
			resume()
		else:
			pause()
		
func resume() -> void:
	get_tree().paused = false
	$AnimationPlayer.play_backwards("pause_menu_blur")
	
func pause() -> void:
	get_tree().paused = true
	$AnimationPlayer.play("pause_menu_blur")
	
func options() -> void:
	get_tree().change_scene_to_file("res://OptionsMenu.tscn")
	
func exit() -> void:
	get_tree().quit()
	
func restart() -> void:
	resume()
	get_tree().reload_current_scene()
