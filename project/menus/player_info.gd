extends Node

# Constant for now, add system to decide which player is hole later
const HOLE_PLAYER = 0

var players: int = 2
var colors: Array[Color] = [Color.WHITE, Color.WHITE]


var player_colors: Dictionary[int, Color] = {
	1: Color.WHITE,
	2: Color.WHITE,
}


func _ready() -> void:
	print(player_colors)


func add_player() -> void:
	if players < 4:
		players += 1
		player_colors[players] = Color.WHITE
		print(player_colors)
