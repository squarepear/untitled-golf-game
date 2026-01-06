class_name BallController
extends Controller

@export var _ball: Ball

const POWER_ADJUST_AMOUNT: float = 0.05
const TURN_AMOUNT: float = 0.1

var _can_move: bool = false


func _ready() -> void:
	_ball.stopped_moving.connect(_on_ball_stopped_moving)


func _input(event: InputEvent) -> void:
	if not _can_move or not _is_active:
		return

	if event.is_action_pressed("increase_power"):
		_ball.adjust_power(POWER_ADJUST_AMOUNT)
	if event.is_action_pressed("decrease_power"):
		_ball.adjust_power(-POWER_ADJUST_AMOUNT)
	if event.is_action_pressed("rotate_left"):
		_ball.turn(TURN_AMOUNT)
	if event.is_action_pressed("rotate_right"):
		_ball.turn(-TURN_AMOUNT)
	if event.is_action_pressed("hit"):
		_ball.hit()
		_can_move = false


func start_turn() -> void:
	super()
	_can_move = true


func get_target() -> Node3D:
	return _ball


func _on_ball_stopped_moving() -> void:
	if not _is_active:
		return

	_end_turn()
