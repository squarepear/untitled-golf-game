class_name Ball
extends RigidBody3D

signal stopped_moving

const MAX_POWER := 10.0

var _power_percentage := 0.5
var _has_hit := false

@onready var _aimer: Node3D = %Aimer
@onready var _pivot: Node3D = %Pivot
@onready var _power_indicator: MeshInstance3D = %PowerIndicator


func _process(_delta: float) -> void:
	_aimer.global_position = global_position


func hit() -> void:
	apply_impulse(-_pivot.basis.z * _power_percentage * MAX_POWER)
	_has_hit = true


func turn(angle: float) -> void:
	_pivot.rotate_y(angle)


func adjust_power(amount: float) -> void:
	# TODO: Add safeguards
	_power_percentage += amount
	_power_indicator.mesh.size.y = _power_percentage


func _on_sleeping_state_changed() -> void:
	if sleeping and _has_hit:
		_has_hit = false
		stopped_moving.emit()
