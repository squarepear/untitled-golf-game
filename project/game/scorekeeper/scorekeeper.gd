class_name Scorekeeper
extends Node

signal updated

var _current_level := 0
var _course: Course
var _scores: Dictionary[Controller, LevelScores]


func set_up(course: Course, players: Array[Controller]) -> void:
	_course = course
	for player in players:
		if player is BallController:
			player.ball_hit.connect(increment_level_score.bind(player))
		_scores[player] = LevelScores.new(course.get_levels(), player is HoleController)


func increment_level_score(player: Controller):
	_scores[player].increment_level_score(_current_level)


func complete_level(player: Controller = null):
	if player:
		_scores[player].complete_level(_current_level)
		updated.emit()
		return

	for p in _scores.keys():
		if p is HoleController:
			_scores[p].update_hole_score(_current_level, _scores.values())
		_scores[p].complete_level(_current_level)

	_current_level += 1
	updated.emit()


func get_players() -> Array[Controller]:
	return _scores.keys()


func get_scores() -> Array[LevelScores]:
	return _scores.values()


func get_course() -> Course:
	return _course


func get_winner() -> Controller:
	var scores: Array
	for player in _scores.keys():
		scores.append({
			"player": player, 
			"score": _scores[player].course_score()
			})

	scores.sort_custom(
		func(a,b):
			return a.score < b.score
	)

	return scores[0].player


class LevelScores:
	var pars: Array[int] = []
	var scores: Array[int] = []
	var is_complete: Array[bool] = []


	func _init(levels: Array[Level], par_disabled := false) -> void:
		for level in levels:
			pars.append(0 if par_disabled else level.get_par())
			scores.append(0)
			is_complete.append(false)


	func increment_level_score(level_index: int) -> void:
		scores[level_index] += 1


	func update_hole_score(level_index: int, others_scores: Array[LevelScores]) -> void:
		for other_scores in others_scores:
			if other_scores == self:
				continue

			var other_score := other_scores.level_score(level_index)
			if other_score < 0:
				scores[level_index] += 1
			elif other_score > 0:
				scores[level_index] -= 1


	func complete_level(level_index: int) -> void:
		is_complete[level_index] = true


	func level_score(level_index: int) -> int:
		return scores[level_index] - pars[level_index]


	func course_score() -> int:
		var total := 0

		for i in scores.size():
			if not is_complete[i]:
				continue

			total += level_score(i)

		return total
