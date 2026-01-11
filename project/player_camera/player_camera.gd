class_name PlayerCamera
extends Node3D

const ROTATION_SPEED := 0.05

static var _main: PlayerCamera

@export var _target: Node3D

@onready var _camera: Camera3D = %Camera3D
@onready var _forward: Node3D = %Forward


static func main() -> PlayerCamera:
	return _main


func _ready() -> void:
	if _main:
		_main.queue_free()

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_main = self


func _process(delta: float) -> void:
	if not _target:
		return

	global_position = lerp(global_position, _target.global_position, delta)

	rotate_y(-(Input.get_last_mouse_velocity().x / get_viewport().get_visible_rect().size.x) * ROTATION_SPEED)
	_camera.rotate_x(-(Input.get_last_mouse_velocity().y / get_viewport().get_visible_rect().size.x) * ROTATION_SPEED)


func set_target(target: Node3D) -> void:
	_target = target


func get_dir(dir: Vector2) -> Vector2:
	var vec := Vector3(dir.x, 0.0, -dir.y).rotated(Vector3.UP, rotation.y)
	return Vector2(vec.x, vec.z)
