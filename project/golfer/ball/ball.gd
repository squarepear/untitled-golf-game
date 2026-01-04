extends RigidBody3D

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		apply_impulse(Vector3(3, 0, 0))
