extends Control

@export var transition_speed: float = 2.0

var colors: Array
var num_colors: int = 10
var progress: float = 0.0
var current_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MarginContainer/VBoxContainer/PlayButton.pressed.connect(_on_play_pressed)
	$MarginContainer/VBoxContainer/ExitButton.pressed.connect(_on_exit_pressed)
	$MarginContainer/VBoxContainer/OptionsButton.pressed.connect(_on_options_pressed)
	
	for i in range(num_colors):
		colors.push_back(Color(randf(), randf(), randf()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	progress += delta * transition_speed
	
	if progress >= 1.0:
		progress = 0.0
		current_index = (current_index + 1) % colors.size()
		
	var next_index = (current_index + 1) % colors.size()
	$HBoxContainer/Label.add_theme_color_override("font_color", colors[current_index].lerp(colors[next_index], progress))

func _on_play_pressed():
	get_tree().change_scene_to_file("res://main.tscn")

func _on_exit_pressed():
	get_tree().quit()
	
func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://OptionsMenu.tscn")
