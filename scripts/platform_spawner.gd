extends Node3D

@export var platform_scene: PackedScene
@export var hollow_scene: PackedScene
@export var spawn_distance: float = -5.0
@export var player: RigidBody3D
@export var despawn_distance: float = 30.0  # Distance behind the player to delete platforms
@export var powerup_speed_boost: PackedScene

var rng = RandomNumberGenerator.new()
var gap: float = 2.0
var last_platform_position: Vector3

func _ready():
	last_platform_position = player.position - Vector3(0, 5, -30)
	spawn_platform()

func _process(delta: float):

	# Check if player has reached the spawn threshold
	if player.position.z - last_platform_position.z < spawn_distance:
		spawn_platform()
		
	# Delete out of screen platforms
	for entity in get_children():
		if entity.position.z > player.position.z + despawn_distance:
			entity.queue_free()

func spawn_platform() -> void:
	var platform = platform_scene.instantiate()
	platform.scale.z = rng.randf_range(0.75, 1.5)
	platform.scale.z = rng.randf_range(2, 4)
	platform.scale.x = rng.randf_range(0.5, 1.5)
	platform.rotation.z = deg_to_rad(rng.randf_range(-45, 45))
	#platform.physics_material_override.set_bounce()
	var mesh = platform.get_node("MeshInstance3D")
	var aabb = mesh.mesh.get_aabb()
	var platform_length = aabb.size.z * platform.scale.z  # Get actual size after scaling

	# Position the new platform correctly
	platform.position = last_platform_position - Vector3(0, 0, platform_length + gap)
	platform.position.x = rng.randf_range(-5, 5)
	platform.position.y += rng.randf_range(-0.5, 0.5)
	add_child(platform)
	
	var spawn_powerup : bool = rng.randi_range(-1, 1)

	if spawn_powerup:
		spawn_powerup(platform)

	# Update the last platform position
	last_platform_position = platform.position

# Spawns the powerup on the platform
func spawn_powerup(platform: Node3D) -> void:
	var powerup = powerup_speed_boost.instantiate()
	var plat_mesh_instance = platform.get_node("MeshInstance3D")
	var plat_aabb = plat_mesh_instance.get_aabb()
	var plat_size = plat_mesh_instance.get_aabb().size
	var plat_origin = plat_mesh_instance.global_transform.origin
	var x = rng.randf_range(plat_origin.x + plat_aabb.position.x, plat_origin.x + plat_aabb.position.x + plat_size.x)
	var z = rng.randf_range(plat_origin.z + plat_aabb.position.z, plat_origin.z + plat_aabb.position.z + plat_size.z)
	powerup.position = Vector3(x, platform.global_transform.origin.y + 1, z)
	powerup.rotation = platform.rotation
	add_child(powerup)
