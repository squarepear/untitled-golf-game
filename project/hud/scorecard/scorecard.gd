class_name Scorecard
extends Control

const _par_square_scene := preload("res://hud/scorecard/par_score_square.tscn")
const _score_square_scene := preload("res://hud/scorecard/score_square.tscn")

var _scorekeeper: Scorekeeper

@onready var _player_names_container: VBoxContainer = %PlayerNamesContainer
@onready var _pars_container: HBoxContainer = %ParsContainer
@onready var _score_container: GridContainer = %ScoreContainer
@onready var _score_totals_container: VBoxContainer = %ScoreTotalsContainer


func set_scorekeeper(scorekeeper: Scorekeeper) -> void:
	_scorekeeper = scorekeeper
	_scorekeeper.updated.connect(_update)

	_initialize_containers.call_deferred()


func _initialize_containers() -> void:
	_clear_containers()

	_score_container.columns = _scorekeeper.get_course().get_levels().size()
	for level in _scorekeeper.get_course().get_levels():
		_create_par_square(level.get_par())

	for i in _scorekeeper.get_scores().size():
		var scores := _scorekeeper.get_scores()[i]
		_create_player_name(_scorekeeper.get_players()[i].name)
		for j in range(_score_container.columns):
			_create_score_square(scores.scores[j])
		_create_total_score_square(scores.course_score())


func _clear_containers() -> void:
	for child in _player_names_container.get_children():
		child.queue_free()
	for child in _pars_container.get_children():
		child.queue_free()
	for child in _score_container.get_children():
		child.queue_free()
	for child in _score_totals_container.get_children():
		child.queue_free()


func _create_player_name(player_name: String) -> Label:
	var player_name_label := Label.new()
	_player_names_container.add_child(player_name_label)
	player_name_label.text = player_name
	return player_name_label


func _create_par_square(score: int) -> ScoreSquare:
	var score_square: ScoreSquare = _par_square_scene.instantiate()
	_pars_container.add_child(score_square)
	score_square.set_score(score)
	return score_square


func _create_score_square(score: int) -> ScoreSquare:
	var score_square: ScoreSquare = _score_square_scene.instantiate()
	_score_container.add_child(score_square)
	score_square.set_score(score)
	return score_square


func _create_total_score_square(score: int) -> ScoreSquare:
	var score_square: ScoreSquare = _score_square_scene.instantiate()
	_score_totals_container.add_child(score_square)
	score_square.set_score(score)
	return score_square


func _update() -> void:
	var scores := _scorekeeper.get_scores()
	for i in scores.size():
		for j in range(_score_container.columns):
			_get_score_square(i, j).set_score(scores[i].scores[j])
		_score_totals_container.get_child(i).set_score(scores[i].course_score())


func _get_score_square(player_index: int, level_index: int) -> ScoreSquare:
	var index := player_index * _score_container.columns + level_index
	if index < 0 or index >= _score_container.get_child_count():
		return null

	return _score_container.get_child(index)
