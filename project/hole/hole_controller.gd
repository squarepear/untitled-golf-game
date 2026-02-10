class_name HoleController
extends Controller

const MAX_TIME := 5
const UNTIL_PAR_TIME_LOSS := 2
const MIN_TIME := 1

@export var _hole: Hole

var _timer: SceneTreeTimer
var _time := MAX_TIME


func _input(event: InputEvent) -> void:
	super(event)

	if not _is_active:
		return

	var dir := Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
	_hole.move(PlayerCamera.main().get_dir(dir))

	if not dir:
		return

	if not _timer:
		_timer = get_tree().create_timer(_time)
		_timer.timeout.connect(end_turn)


func start_turn(until_par: int) -> void:
	super(until_par)

	_time = _calc_time(until_par)


func end_turn(silent := false) -> void:
	if _timer && _timer.timeout.is_connected(end_turn):
		_timer.timeout.disconnect(end_turn)
		_timer = null

	super(silent)


func set_target(target: Hole) -> void:
	_hole = target
	_time = MAX_TIME
	turn_ended.connect(_hole.move.bind(Vector2.ZERO))


func get_target() -> Node3D:
	return _hole


func get_time_remaining() -> int:
	if not _timer:
		return _time

	return ceili(_timer.time_left)


func _calc_time(until_par: int) -> int:
	if until_par >= UNTIL_PAR_TIME_LOSS:
		return MAX_TIME

	return max(MAX_TIME + (until_par - UNTIL_PAR_TIME_LOSS), MIN_TIME)
