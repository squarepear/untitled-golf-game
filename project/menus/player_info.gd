extends Node

# Constant for now, add system to decide which player is hole later
const HOLE_PLAYER = 0

var players: int = 2
var colors: Array[Color] = [Color.WHITE, Color.WHITE]
var names: Array[String] = ["Player 1", "Player 2"]


func add_player() -> void:
	if players < 4:
		players += 1
		colors.append(Color.WHITE)
		names.append("Player %d" % players)


func delete_player() -> void:
	players -= 1
	colors.remove_at(players)
	names.remove_at(players)
