extends Node

@onready var _button_click_player: AudioStreamPlayer = %ButtonClickPlayer


func play_button_click() -> void:
	_button_click_player.play()
