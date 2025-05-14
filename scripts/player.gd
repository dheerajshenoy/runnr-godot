extends RigidBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 7.5

# Shape shifting stuff
@export var sphere_mesh: MeshInstance3D
@export var box_mesh: MeshInstance3D

var is_sphere: bool = true

@export var camera: Camera3D

var xform: Transform3D
var is_on_floor: bool = false
var collision_normal: Vector3

func _ready() -> void:
	shape_shift()

func _physics_process(delta: float) -> void:
	position.z -= 10.0 * delta
	
	if get_contact_count() > 0:
		for i in range(get_contact_count()):
			var normal = 
			

	if Input.is_action_just_pressed("ui_left"):
		shape_shift()
	
	if rotation_degrees.x != 0:
		rotation_degrees.x = 0
		
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "", "")
		
	# Rotate character to align with the floor
	if is_on_floor:
		align_with_platform(collision_normal)
		global_transform = global_transform.interpolate_with(xform, 0.1)
	else:
		align_with_platform(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.1)

		# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor:
		apply_central_impulse(collision_normal * JUMP_VELOCITY)
		
	if Input.is_action_pressed("move_left"):
		apply_central_force(Vector3(-20.0, 0, 0))
		
	if Input.is_action_pressed("move_right"):
		apply_central_force(Vector3(20.0, 0, 0))
	
	camera.position = position + Vector3(0, 7.5, 5)

func align_with_platform(platform_normal: Vector3) -> void:
	xform = global_transform
	xform.basis.y = platform_normal
	xform.basis.x = -xform.basis.z.cross(platform_normal)
	xform.basis = xform.basis.orthonormalized()
	
func shape_shift() -> void:
	is_sphere = not is_sphere
	
	if is_sphere:
		$Mesh.mesh = sphere_mesh
		sphere_mesh.visible = true
		box_mesh.visible = false
		$CollisionShape3D.shape = SphereShape3D.new()
	else:
		$Mesh.mesh = box_mesh
		sphere_mesh.visible = false
		box_mesh.visible = true
		$CollisionShape3D.shape = BoxShape3D.new()
