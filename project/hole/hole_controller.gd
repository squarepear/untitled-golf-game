class_name HoleController
extends Node

@export var _hole: Hole


func _process(_delta: float) -> void:
	var dir := Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
	_hole.move(dir)
