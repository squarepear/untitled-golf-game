extends Control

const PLAYER_CUSTOMIZER = preload("res://menus/player_customizer.tscn")
@onready var _h_box_container: HBoxContainer = %HBoxContainer


func _ready() -> void:
	for n in PlayerInfo.players:
		_create_player_customizer(n)


func _on_button_pressed() -> void:
	if PlayerInfo.players < 4:
		PlayerInfo.add_player()
		_create_player_customizer(PlayerInfo.players - 1)


func _create_player_customizer(n) -> void:
		var _player_customizer: PlayerCustomizer = PLAYER_CUSTOMIZER.instantiate()
		_h_box_container.add_child(_player_customizer)
		_player_customizer.set_player_name(str(n + 1))


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")
