class_name Level
extends Node3D

@export var _par: int = 3

@onready var _spawn_patch := $SpawnPatch
@onready var _hole_spawn := $HoleSpawn


func get_par() -> int:
	return _par


func get_spawn_positions() -> Array[Vector3]:
	return _spawn_patch.get_positions()


func get_hole_spawn_position() -> Vector3:
	return _hole_spawn.global_position
