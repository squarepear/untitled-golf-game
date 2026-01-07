extends Node3D

@export var _turn_order: Array[Controller]

var _players: Array[Controller]

@onready var _course: Course = %Course
@onready var _camera: PlayerCamera = %PlayerCamera
@onready var _hole: Hole = %Hole


func _ready() -> void:
	_players = _turn_order.duplicate()

	for controller in _turn_order:
		controller.turn_ended.connect(_next_turn)
	_hole.ball_entered.connect(_on_ball_entered_hole)

	_turn_order[0].start_turn()


func _next_turn() -> void:
	_turn_order.append(_turn_order.pop_front())
	print(_turn_order[0])
	_turn_order[0].start_turn()
	_camera.set_target(_turn_order[0].get_target())


func _on_ball_entered_hole(ball: Ball) -> void:
	var ball_controller_index := _turn_order.find_custom(
		func(controller: Controller): return controller.get_target() == ball
	)

	if ball_controller_index < 0:
		printerr("Inactive ball entered hole... That's not supposed to happen!")
		return

	if _turn_order.size() == 2:
		_level_complete()
		return

	if ball_controller_index == 0:
		_next_turn()
		_turn_order.remove_at(_turn_order.size() - 1)
	else:
		_turn_order.remove_at(ball_controller_index)


func _level_complete() -> void:
	print("Level %d complete!" % _course.get_current_level_index())
	for controller in _turn_order:
		controller.end_turn(true)

	_turn_order = _players.duplicate()
	_course.advance_level()
	
	# TODO: Update positions

	_turn_order[0].start_turn()
	_camera.set_target(_turn_order[0].get_target())
