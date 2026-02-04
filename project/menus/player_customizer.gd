class_name PlayerCustomizer
extends PanelContainer

var _number: int
var _current_color: Color = Color.WHITE
var _current_name: String
@onready var _texture_rect: TextureRect = %TextureRect
@onready var _player_label: Label = %PlayerLabel
@onready var _line_edit: LineEdit = %LineEdit


func _on_color_picker_color_changed(color: Color) -> void:
	_current_color = color
	_texture_rect.modulate = _current_color
	PlayerInfo.colors[_number] = _current_color


func set_player_name(player_number: String) -> void:
	_number = int(player_number)
	if _number == PlayerInfo.HOLE_PLAYER:
		_player_label.text = "Hole"
	else:
		_player_label.text = "Ball"


func get_color() -> Color:
	return _current_color


func _on_line_edit_text_changed(new_text) -> void:
	_current_name = new_text
	PlayerInfo.names[_number] = _current_name
