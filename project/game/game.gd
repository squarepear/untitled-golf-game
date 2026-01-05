extends Node3D

@export var _turn_order: Array[Controller]


func _ready() -> void:
	for controller in _turn_order:
		controller.turn_ended.connect(_next_turn)
	_turn_order[0].start_turn()


func _next_turn() -> void:
	_turn_order.append(_turn_order.pop_front())
	print(_turn_order[0])
	_turn_order[0].start_turn()
