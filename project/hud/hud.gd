extends Control

var _current_player: Controller

@onready var _current_player_label = %CurrentPlayerLabel
@onready var _time_left_label = %TimeLeftLabel
@onready var _time_left: HBoxContainer = %TimeLeft


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
