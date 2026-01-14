class_name BallController
extends Controller

signal ball_hit

const POWER_ADJUST_AMOUNT: float = 0.025
const TURN_AMOUNT: float = 0.1

@export var _ball: Ball

var _can_move: bool = false


func _process(_delta: float) -> void:
	if not _can_move or not _is_active:
		return

	_ball.turn(-PlayerCamera.main().get_dir(Vector2.RIGHT).angle())

	if Input.is_action_pressed("move_forward"):
		_ball.adjust_power(POWER_ADJUST_AMOUNT)
	if Input.is_action_pressed("move_backward"):
		_ball.adjust_power(-POWER_ADJUST_AMOUNT)


func _input(event: InputEvent) -> void:
	if not _can_move or not _is_active:
		return

	if event.is_action_pressed("hit"):
		_ball.hit()
		ball_hit.emit()
		_can_move = false


func start_turn() -> void:
	super()
	_can_move = true


func end_turn(silent := false) -> void:
	super(silent)
	_can_move = false


func set_target(target: Ball) -> void:
	_ball = target
	_ball.stopped_moving.connect(_on_ball_stopped_moving)


func get_target() -> Node3D:
	return _ball


func _on_ball_stopped_moving() -> void:
	if not _is_active:
		return

	end_turn()
