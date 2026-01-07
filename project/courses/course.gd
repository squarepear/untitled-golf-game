class_name Course
extends Node3D

signal level_advanced(level_index: int)

var _current_level := 0
var _levels: Array[Level]

@onready var _levels_parent: Node = %Levels


func _ready() -> void:
	for level in _levels_parent.get_children():
		assert(level is Level)

		_levels.append(level)


func advance_level() -> void:
	_current_level += 1
	level_advanced.emit(_current_level)


func get_current_level() -> Level:
	return _levels[_current_level]


func get_current_level_index() -> int:
	return _current_level
