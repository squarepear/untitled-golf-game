class_name HoleController
extends Controller

@export var _hole: Hole

func _ready() -> void:
	turn_ended.connect(_hole.move.bind(Vector2.ZERO))


func _input(_event: InputEvent) -> void:
	if not _is_active:
		return

	var dir := Input.get_vector("move_left", "move_right", "move_backward", "move_forward")
	_hole.move(dir)


func start_turn() -> void:
	super()
	var timer = get_tree().create_timer(5.0)
	timer.timeout.connect(_end_turn)


func get_target() -> Node3D:
	return _hole
