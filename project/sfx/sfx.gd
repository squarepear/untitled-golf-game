extends Node

@onready var _button_click_player: AudioStreamPlayer = %ButtonClickPlayer
@onready var _ball_hit_player: AudioStreamPlayer = %BallHitPlayer
@onready var _ball_in_hole_player: AudioStreamPlayer = %BallInHolePlayer


func play_button_click() -> void:
	_button_click_player.play()


func play_ball_hit() -> void:
	_ball_hit_player.play()


func play_ball_enter_hole() -> void:
	_ball_in_hole_player.play()
