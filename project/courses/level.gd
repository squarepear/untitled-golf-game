class_name Level
extends Node3D

@export var _par: int


func get_par() -> int:
	return _par


func get_spawn_positions() -> Array[Vector3]:
	return $SpawnPatch.get_positions()


func get_hole_spawn_position() -> Vector3:
	return $HoleSpawn.global_position
