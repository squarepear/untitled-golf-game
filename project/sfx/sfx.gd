extends Node

@onready var _button_click_player: AudioStreamPlayer = %ButtonClickPlayer
@onready var _ball_hit_player: AudioStreamPlayer = %BallHitPlayer


func play_button_click() -> void:
	_button_click_player.play()


func play_ball_hit() -> void:
	_ball_hit_player.play()
