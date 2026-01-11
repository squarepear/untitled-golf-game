class_name Ball
extends CharacterBody3D

signal stopped_moving

const MAX_POWER := 10.0
const SLEEP_THRESHOLD := 0.03
const COLLISION_ABSORPTION := 0.8

var _power_percentage := 0.5
var _has_hit := false

@onready var _aimer: Node3D = %Aimer
@onready var _pivot: Node3D = %Pivot
@onready var _power_indicator: MeshInstance3D = %PowerIndicator
@onready var _sleep_timer: Timer = %SleepTimer


func _process(_delta: float) -> void:
	_aimer.global_position = global_position


func _physics_process(delta: float) -> void:
	if _has_hit and _sleep_timer.time_left <= 0.01:
		if velocity.length() < SLEEP_THRESHOLD:
			velocity = Vector3.ZERO
			_has_hit = false
			stopped_moving.emit()
			return

	velocity -= velocity.normalized() * delta

	var collision := move_and_collide(velocity * delta)
	while collision:
		var normal := collision.get_normal()
		var remainder := collision.get_remainder()
		velocity = velocity.bounce(normal) * COLLISION_ABSORPTION

		if remainder.length() < 0.01:
			break

		remainder = remainder.bounce(normal)
		collision = move_and_collide(remainder)


func hit() -> void:
	velocity = -_pivot.basis.z * _power_percentage * MAX_POWER
	_has_hit = true
	_sleep_timer.start()


func turn(angle: float) -> void:
	_pivot.rotate_y(angle)


func adjust_power(amount: float) -> void:
	# TODO: Add safeguards
	_power_percentage += amount
	_power_indicator.mesh.size.y = _power_percentage
