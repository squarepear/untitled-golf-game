class_name PlayerCamera
extends Node3D

@export var _target: Node3D


func _process(delta: float) -> void:
	if not _target:
		return

	global_position = lerp(global_position, _target.global_position, delta)


func set_target(target: Node3D) -> void:
	_target = target
