extends Node3D

@onready var _position_1 = %Position1
@onready var _position_2 = %Position2
@onready var _position_3 = %Position3


func get_positions() -> Array[Vector3]:
	return [_position_1.global_position, _position_2.global_position, _position_3.global_position]
