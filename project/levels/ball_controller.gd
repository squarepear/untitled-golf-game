class_name BallController
extends Node


@export var _ball: Ball

const POWER_ADJUST_AMOUNT: float = 0.05
const TURN_AMOUNT: float = 0.1


func _input(event: InputEvent) -> void:
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
