class_name HoleController
extends Controller

@export var _hole: Hole


func _input(_event: InputEvent) -> void:
	if not _is_active:
		return

	var dir := Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
	_hole.move(PlayerCamera.main().get_dir(dir))


func start_turn() -> void:
	super()
	var timer = get_tree().create_timer(5.0)
	timer.timeout.connect(end_turn)


func set_target(target: Hole) -> void:
	_hole = target
	turn_ended.connect(_hole.move.bind(Vector2.ZERO))


func get_target() -> Node3D:
	return _hole
