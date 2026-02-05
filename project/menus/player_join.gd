extends Node3D

const PLAYER_CUSTOMIZER = preload("res://menus/player_customizer.tscn")

var _camera_rotation_speed: float = 0.05

@onready var _h_box_container: HBoxContainer = %HBoxContainer
@onready var _camera_3d: Camera3D = %Camera3D
@onready var _player_join: CanvasLayer = %PlayerJoin
@onready var _opening_screen: CanvasLayer = %OpeningScreen
@onready var _credits: CanvasLayer = $Credits



func _ready() -> void:
	for n in PlayerInfo.players:
		_create_player_customizer(n)


func _process(delta: float) -> void:
	_camera_3d.rotation.y += _camera_rotation_speed * delta


func _on_button_pressed() -> void:
	if PlayerInfo.players < 4:
		PlayerInfo.add_player()
		_create_player_customizer(PlayerInfo.players - 1)


func _create_player_customizer(n) -> void:
	var _player_customizer: PlayerCustomizer = PLAYER_CUSTOMIZER.instantiate()
	_h_box_container.add_child(_player_customizer)
	_player_customizer.set_player_name(str(n))


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://game/game.tscn")


func _on_delete_player_button_pressed() -> void:
	if PlayerInfo.players > 2:
		PlayerInfo.delete_player()
		var current_player_customizer = _h_box_container.get_child(PlayerInfo.players)
		_h_box_container.remove_child(current_player_customizer)
		current_player_customizer.queue_free()


func _on_main_menu_button_pressed() -> void:
	_player_join.hide()
	_opening_screen.show()


func _on_play_game_button_pressed() -> void:
	_player_join.show()
	_opening_screen.hide()


func _on_close_button_pressed() -> void:
	_credits.hide()


func _on_credits_button_pressed() -> void:
	_credits.show()
