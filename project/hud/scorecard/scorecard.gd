class_name Scorecard
extends Control

const _score_square_scene := preload("res://hud/scorecard/score_square.tscn")

var _scorekeeper: Scorekeeper

@onready var _grid_container: GridContainer = %GridContainer


func set_scorekeeper(scorekeeper: Scorekeeper) -> void:
	_scorekeeper = scorekeeper
	_scorekeeper.updated.connect(_update)

	_initialize_grid.call_deferred()


func _initialize_grid() -> void:
	for child in _grid_container.get_children():
		child.queue_free()

	for scores in _scorekeeper.get_scores():
		_grid_container.add_child(Label.new())
		for i in range(_grid_container.columns - 2):
			_create_score_square().set_score(scores.scores[i])
		_create_score_square().set_score(scores.course_score())


func _create_score_square() -> ScoreSquare:
	var score_square: ScoreSquare = _score_square_scene.instantiate()
	_grid_container.add_child(score_square)
	return score_square


func _update() -> void:
	var scores := _scorekeeper.get_scores()
	for i in scores.size():
		for j in range(_grid_container.columns - 2):
			_get_score_square(i, j).set_score(scores[i].scores[j])
		_get_score_square(i, _grid_container.columns - 2).set_score(scores[i].course_score())


func _get_score_square(player_index: int, level_index: int) -> ScoreSquare:
	var index := 1 + player_index * _grid_container.columns + level_index
	if index < 0 or index >= _grid_container.get_child_count():
		return null

	return _grid_container.get_child(1 + player_index * _grid_container.columns + level_index)
