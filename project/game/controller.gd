class_name Controller
extends Node

signal turn_ended

var _is_active: bool = false


func start_turn() -> void:
	_is_active = true


func end_turn(silent := false) -> void:
	_is_active = false
	
	if not silent:
		turn_ended.emit()


func get_target() -> Node3D:
	return null
