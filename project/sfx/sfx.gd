extends Node

const MIN_BOUNCE_STRENGTH := 0.3
const BOUNCE_DB_SCALE := 6.0

@onready var _button_click_player: AudioStreamPlayer = %ButtonClickPlayer
@onready var _ball_hit_player: AudioStreamPlayer = %BallHitPlayer
@onready var _ball_in_hole_player: AudioStreamPlayer = %BallInHolePlayer
@onready var _ball_bounce_player: AudioStreamPlayer = $BallBouncePlayer


func play_button_click() -> void:
	_button_click_player.play()


func play_ball_hit() -> void:
	_ball_hit_player.play()


func play_ball_enter_hole() -> void:
	_ball_in_hole_player.play()

func play_ball_bounce(strength := 1.0) -> void:
	if strength < MIN_BOUNCE_STRENGTH:
		return

	var db := (strength * BOUNCE_DB_SCALE) - BOUNCE_DB_SCALE
	_ball_bounce_player.volume_db = db
	_ball_bounce_player.play()
