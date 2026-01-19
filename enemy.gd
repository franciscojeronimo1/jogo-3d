extends CharacterBody3D

@export var speed: float = 3.0
@export var stop_distance: float = 1.25
@export var target_path: NodePath

var target: Node3D

func _ready() -> void:
	if target_path != NodePath():
		target = get_node_or_null(target_path) as Node3D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if target:
		var to_target := target.global_position - global_position
		to_target.y = 0.0
		var distance := to_target.length()

		if distance > stop_distance and distance > 0.001:
			var direction := to_target / distance
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
			look_at(global_position + direction, Vector3.UP)
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
