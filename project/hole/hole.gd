class_name Hole
extends CharacterBody3D

signal ball_entered(ball: Ball)

const MAX_SPEED := 1.0

@onready var _ring_mesh: MeshInstance3D = %RingMesh


func _physics_process(_delta: float) -> void:
	move_and_slide()


func move(dir: Vector2) -> void:
	dir *= MAX_SPEED
	velocity = Vector3(dir.x, 0, dir.y)


func set_color(new_color) -> void:
	_ring_mesh.mesh.material.albedo_color = new_color


func _on_ball_area_body_entered(body: Node3D) -> void:
	if body is not Ball:
		return

	ball_entered.emit(body)
