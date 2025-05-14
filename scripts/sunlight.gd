extends DirectionalLight3D

@export var day_length: float = 20.0
@export var day_color: Color = Color(1.0, 0.95, 0.8)  # Warm sunlight
@export var night_color: Color = Color(0.1, 0.1, 0.3)  # Dark blue

var time_elapsed: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#time_elapsed += delta
	#var progress = fmod(time_elapsed / day_length, 1.0)
	#print(progress)
	#rotation_degrees.x = lerp(-90.0, 90.0, progress)
	#light_color = day_color.lerp(night_color, abs(sin(progress * PI)))
	#light_energy = lerp(2.0, 0.1, abs(sin(progress * PI)))
