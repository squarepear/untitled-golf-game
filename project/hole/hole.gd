extends CharacterBody3D

const SPEED := 50.0


func _process(delta: float) -> void:
	var dir := Input.get_vector("move_left","move_right","move_backward","move_forward")
	velocity += Vector3(dir.x, 0, dir.y) * delta * SPEED


func _physics_process(_delta: float) -> void:
	move_and_slide()
	velocity = Vector3.ZERO


func move(dir: Vector2) -> void:
	dir = dir.normalized()
	velocity = Vector3(dir.x, 0, dir.y)
