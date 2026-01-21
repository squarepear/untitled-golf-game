extends Node

# Constant for now, add system to decide which player is hole later
const HOLE_PLAYER = 0

var players: int = 2
var colors: Array[Color] = [Color.WHITE, Color.WHITE]


func _ready() -> void:
	print(colors)


func add_player() -> void:
	if players < 4:
		players += 1
		colors.append(Color.WHITE)
		print(colors)
