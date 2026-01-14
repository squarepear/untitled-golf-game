class_name PlayerCamera
extends Node3D

const ROTATION_SPEED := 0.05

static var _main: PlayerCamera

@export var _target: Node3D

@onready var _camera: Camera3D = %Camera3D


static func main() -> PlayerCamera:
	return _main


func _ready() -> void:
	if _main:
		_main.queue_free()

	_main = self


func _process(delta: float) -> void:
	if not _target:
		return

	global_position = lerp(global_position, _target.global_position, delta)

	if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		return

	rotate_y(-(Input.get_last_mouse_velocity().x / get_viewport().get_visible_rect().size.x) * ROTATION_SPEED)
	_camera.rotate_x(-(Input.get_last_mouse_velocity().y / get_viewport().get_visible_rect().size.x) * ROTATION_SPEED)


func set_target(target: Node3D) -> void:
	_target = target


func get_dir(dir: Vector2) -> Vector2:
	var vec := Vector3(dir.x, 0.0, -dir.y).rotated(Vector3.UP, rotation.y)
	return Vector2(vec.x, vec.z)


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
