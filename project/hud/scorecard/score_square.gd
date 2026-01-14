class_name ScoreSquare
extends CenterContainer

@onready var _label: Label = $Label


func set_score(score: int) -> void:
	_label.text = str(score)
