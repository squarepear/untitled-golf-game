extends Node3D

@export var _turn_order: Array[Controller]

var _players: Array[Controller]

@onready var _course: Course = %Course
@onready var _camera: PlayerCamera = %PlayerCamera
@onready var _hud := %Hud
@onready var _scorekeeper := %Scorekeeper

func _ready() -> void:
	_players = _turn_order.duplicate()
	_spawn_balls()
	_spawn_hole()

	for controller in _turn_order:
		controller.turn_ended.connect(_next_turn)

	_scorekeeper.set_players(_players)

	_hud.set_current_player(_turn_order[0])
	_turn_order[0].start_turn()
	_camera.set_target(_turn_order[0].get_target())


func _next_turn() -> void:
	_turn_order.append(_turn_order.pop_front())
	_hud.set_current_player(_turn_order[0])
	_turn_order[0].start_turn()
	_camera.set_target(_turn_order[0].get_target())


func _on_ball_entered_hole(ball: Ball) -> void:
	var ball_controller_index := _turn_order.find_custom(
		func(controller: Controller): return controller.get_target() == ball
	)

	ball.queue_free()

	if ball_controller_index < 0:
		printerr("Inactive ball entered hole... That's not supposed to happen!")
		return

	if _turn_order.size() == 2:
		_level_complete()
		return

	if ball_controller_index == 0:
		_turn_order[0].end_turn(true)
		_next_turn()
		_turn_order.remove_at(_turn_order.size() - 1)
	else:
		_turn_order.remove_at(ball_controller_index)


func _level_complete() -> void:
	print("Level %d complete!" % _course.get_current_level_index())
	for controller in _players:
		controller.end_turn(true)

	_scorekeeper.update_course_score(_course.get_current_level())

	_turn_order = _players.duplicate()
	_course.advance_level()

	_spawn_balls()
	_spawn_hole()

	_turn_order[0].start_turn()
	_camera.set_target(_turn_order[0].get_target())


func _spawn_balls() -> void:
	var index: int = 0

	var positions = _course.get_current_level().get_spawn_positions()
	for player in _players:
		if player is not BallController:
			continue

		if player.get_target():
			player.get_target().queue_free()

		var ball := preload("res://golfer/ball/ball.tscn").instantiate()
		add_child(ball)
		ball.global_position = positions[index]
		player.set_target(ball)

		index += 1


func _spawn_hole() -> void:
	var hole_controller_index := _players.find_custom(
		func(controller: Controller): return controller is HoleController
	)

	assert(hole_controller_index >= 0)

	var hole_controller = _players[hole_controller_index]

	if hole_controller.get_target():
		hole_controller.get_target().queue_free()

	var hole := preload("res://hole/hole.tscn").instantiate()
	add_child(hole)
	hole.global_position = _course.get_current_level().get_hole_spawn_position()
	hole_controller.set_target(hole)
	hole.ball_entered.connect(_on_ball_entered_hole)
