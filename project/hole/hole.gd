extends CharacterBody3D

signal ball_entered(ball: Ball)

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


func _on_ball_area_body_entered(body: Node3D) -> void:
	if body is not Ball:
		return

	ball_entered.emit(body)
