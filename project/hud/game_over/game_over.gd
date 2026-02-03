class_name GameOver
extends Control

@export var _scorecard: Scorecard

@onready var _winning_player_label: Label = %WinningPlayerLabel
@onready var _scorecard_container: Control = %ScorecardContainer


func _ready() -> void:
	hide()


func activate() -> void:
	_winning_player_label.text = _scorecard.get_scorekeeper().get_winner().name
	_scorecard.get_parent().remove_child(_scorecard)
	_scorecard_container.add_child(_scorecard)
	show()
