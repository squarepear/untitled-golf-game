class_name Scorekeeper
extends Node

signal updated

var _current_level := 0
var _scores: Dictionary[Controller, LevelScores]


func set_up(course: Course, players: Array[Controller]) -> void:
	for player in players:
		if player is BallController:
			player.ball_hit.connect(increment_level_score.bind(player))
		_scores[player] = LevelScores.new(course.get_levels())


func increment_level_score(player: Controller):
	_scores[player].increment_level_score(_current_level)


func complete_level(player: Controller = null):
	if player:
		_scores[player].complete_level(_current_level)
		updated.emit()
		return

	for p in _scores.keys():
		_scores[p].complete_level(_current_level)

	_current_level += 1
	updated.emit()


func get_scores() -> Array[LevelScores]:
	return _scores.values()


class LevelScores:
	var pars: Array[int] = []
	var scores: Array[int] = []
	var is_complete: Array[bool] = []


	func _init(levels: Array[Level]) -> void:
		for level in levels:
			pars.append(level.get_par())
			scores.append(0)
			is_complete.append(false)


	func increment_level_score(level_index: int) -> void:
		scores[level_index] += 1


	func complete_level(level_index: int) -> void:
		is_complete[level_index] = true


	func course_score() -> int:
		var total := 0

		for i in scores.size():
			if not is_complete[i]:
				continue

			total += scores[i] - pars[i]

		return total
