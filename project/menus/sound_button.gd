class_name AudioButton
extends Button


func _ready() -> void:
	pressed.connect(SFX.play_button_click)
