class_name ScreenshotAdjustment
extends Resource

@export var target_path: NodePath
@export var value: Variant

var _original_value: Variant


func apply(node: Node, new_value: Variant = value) -> void:
	var node_and_resource := node.get_node_and_resource(target_path)

	var target = node_and_resource[1] if node_and_resource[1] else node_and_resource[0]

	assert(target)

	_original_value = target.get_indexed(node_and_resource[2])
	target.set_indexed(node_and_resource[2], new_value)


func revert(node: Node) -> void:
	apply(node, _original_value)
