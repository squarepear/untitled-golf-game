class_name HoleController
extends Controller

const MAX_TIME := 5

@export var _hole: Hole

var _timer: SceneTreeTimer


func _input(_event: InputEvent) -> void:
	if not _is_active:
		return

	var dir := Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
	_hole.move(PlayerCamera.main().get_dir(dir))

	if not dir:
		return

	if not _timer:
		_timer = get_tree().create_timer(MAX_TIME)
		_timer.timeout.connect(end_turn)


func end_turn(silent := false) -> void:
	if _timer && _timer.timeout.is_connected(end_turn):
		_timer.timeout.disconnect(end_turn)
		_timer = null

	super(silent)



func set_target(target: Hole) -> void:
	_hole = target
	turn_ended.connect(_hole.move.bind(Vector2.ZERO))


func get_target() -> Node3D:
	return _hole


func get_time_remaining() -> int:
	if not _timer:
		return MAX_TIME

	return int(_timer.time_left)
