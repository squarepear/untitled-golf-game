extends Node


@export var _ball: Ball


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("hit"):
		_ball.hit()
