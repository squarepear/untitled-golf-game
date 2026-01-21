extends Control

var _current_player: Controller
var _scorekeeper: Scorekeeper

@onready var _current_player_label = %CurrentPlayerLabel
@onready var _time_left_label = %TimeLeftLabel
@onready var _time_left: HBoxContainer = %TimeLeft
@onready var _scorecard: Scorecard = %Scorecard
@onready var _game_over: Control = %GameOver
@onready var _winning_player_label: Label = %WinningPlayerLabel



func _process(_delta: float) -> void:
	if _current_player is HoleController:
		_time_left_label.text = str(_current_player.get_time_remaining())


func set_current_player(current_player: Controller) -> void:
	_current_player = current_player
	_current_player_label.text = str(_current_player)
	if _current_player is HoleController:
		_time_left.show()
	else:
		_time_left.hide()


func set_scorekeeper(scorekeeper: Scorekeeper) -> void:
	_scorekeeper = scorekeeper
	_scorecard.set_scorekeeper(scorekeeper)


func show_game_over() -> void:
	_winning_player_label.text = _scorekeeper.get_winner().name
	_game_over.show()
