class_name ScreenshotComponent
extends Node

signal setup_started
signal setup_completed
signal teardown_started
signal teardown_completed

const GROUP_NAME := "ScreenshotComponent"
const SETTLE_FRAMES := 2

@export var resolution := Vector2i.ZERO
@export var hide_nodes: Array[CanvasItem] = []
@export var adjustments: Array[ScreenshotAdjustment] = []

var _visibility_cache: Dictionary = { }


# collect returns all ScreenshotComponents in the given SceneTree
static func collect(tree: SceneTree) -> Array[ScreenshotComponent]:
	var screenshot_components: Array[ScreenshotComponent] = []

	for node in tree.get_nodes_in_group(GROUP_NAME):
		if node is ScreenshotComponent:
			screenshot_components.append(node)

	return screenshot_components


func _init() -> void:
	add_to_group(GROUP_NAME)


func setup() -> void:
	setup_started.emit()

	_visibility_cache.clear()
	for node in hide_nodes:
		if is_instance_valid(node):
			_visibility_cache[node] = node.visible
			node.hide()

	for adjustment in adjustments:
		if adjustment:
			adjustment.apply(self)

	if resolution != Vector2i.ZERO:
		get_viewport().get_window().size = resolution

	for i in range(SETTLE_FRAMES):
		await get_tree().process_frame

	setup_completed.emit()


func teardown() -> void:
	teardown_started.emit()

	for node in hide_nodes:
		if is_instance_valid(node) and node in _visibility_cache:
			node.visible = _visibility_cache[node]

	for adjustment in adjustments:
		if adjustment:
			adjustment.revert(self)

	if resolution != Vector2i.ZERO:
		get_viewport().get_window().size = Vector2i(
			ProjectSettings.get_setting("display/window/size/viewport_width"),
			ProjectSettings.get_setting("display/window/size/viewport_height"),
		)

	await get_tree().process_frame

	teardown_completed.emit()


func take_screenshot(output_path: String) -> Error:
	var image := get_viewport().get_texture().get_image()

	var err: Error = OK
	match output_path.get_extension().to_lower():
		"png":
			err = image.save_png(output_path)
		"jpg", "jpeg":
			err = image.save_jpg(output_path)
		_:
			err = ERR_INVALID_PARAMETER

	return err


func get_output_path(output_path: String) -> String:
	var screenshot_name := name.replace("ScreenshotComponent", "").to_lower()

	if "%s" in output_path:
		output_path = output_path % screenshot_name

	return output_path
