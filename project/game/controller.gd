class_name Controller
extends Node

signal turn_started
signal turn_ended

var _color: Color
var _is_active: bool = false


func start_turn() -> void:
	if _is_active:
		return

	_is_active = true
	turn_started.emit()


func end_turn(silent := false) -> void:
	if not _is_active:
		return

	_is_active = false

	if not silent:
		turn_ended.emit()


func set_color(new_color: Color) -> void:
	_color = new_color


func set_target(_target) -> void:
	pass


func get_color() -> Color:
	return _color


func get_target() -> Node3D:
	return null
