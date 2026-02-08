class_name PlayerIndicator
extends Node3D

const SCENE := preload("res://controller/player_indicator.tscn")
const VISIBLE_TIME := 2.0

@onready var _animation_player: AnimationPlayer = %AnimationPlayer
@onready var _mesh_instance_3d: MeshInstance3D = %MeshInstance3D


static func create(target: Node3D, color: Color) -> PlayerIndicator:
	var indicator: PlayerIndicator = SCENE.instantiate()
	target.add_child(indicator)
	indicator.set_color(color)
	return indicator


func _ready() -> void:
	get_tree().create_timer(VISIBLE_TIME).timeout.connect(_stop)
	_start()


func set_color(color: Color) -> void:
	_mesh_instance_3d.mesh.material.albedo_color = color


func _start() -> void:
	_animation_player.play("start")


func _stop() -> void:
	_animation_player.play("start", -1, -1, true)
	_animation_player.animation_finished.connect(queue_free.unbind(1))
