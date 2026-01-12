class_name Scorekeeper
extends Node

var _course_scores: Dictionary[Controller, int]
var _level_scores: Dictionary[Controller, int]


func set_players(players: Array[Controller]) -> void:
	for player in players:
		if player is BallController:
			player.ball_hit.connect(update_level_score.bind(player))
		_course_scores[player] = 0
		_level_scores[player] = 0


func update_level_score(player: Controller):
	_level_scores[player] += 1


func update_course_score(level: Level) -> void:
	var par = level.get_par()
	for player in _course_scores.keys():
		_course_scores[player] += _level_scores[player] - par
		_level_scores[player] = 0


func get_course_scores() -> Array[int]:
	return _course_scores.values()


func get_level_scores() -> Array[int]:
	return _level_scores.values()
