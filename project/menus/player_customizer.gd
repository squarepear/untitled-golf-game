class_name PlayerCustomizer
extends Control

var _number: int
var _current_color: Color = Color.WHITE
@onready var _texture_rect: TextureRect = %TextureRect
@onready var _player_label: Label = %PlayerLabel


func _on_color_picker_color_changed(color: Color) -> void:
	_current_color = color
	_texture_rect.modulate = _current_color
	PlayerInfo.colors[_number] = _current_color


func set_player_name(player_number) -> void:
	_number = int(player_number)
	_player_label.text = "Player " + str(_number + 1)


func get_color() -> Color:
	return _current_color


func _on_button_pressed() -> void:
	PlayerInfo.add_player()
	
