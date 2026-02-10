class_name ScreenshotTool
extends SceneTree

const MAIN_SCENE := preload("res://menus/player_join.tscn")
const DEFAULT_PATH := "user://screenshot.png"


func _init() -> void:
	var args := OS.get_cmdline_user_args()
	var screenshot_path = args[0] if args.size() > 0 else DEFAULT_PATH

	change_scene_to_packed(MAIN_SCENE)
	await process_frame
	await process_frame

	var err = take_screenshot(screenshot_path)
	if err == OK:
		print("Screenshot saved to '%s'" % screenshot_path)
		quit()
	else:
		push_error("Failed to save screenshot to '%s': %s" % [screenshot_path, error_string(err)])
		quit(1)


func take_screenshot(output_path: String) -> Error:
	var image = get_root().get_viewport().get_texture().get_image()
	var err: Error = OK

	match output_path.get_extension().to_lower():
		"png":
			err = image.save_png(output_path)
		"jpg", "jpeg":
			err = image.save_jpg(output_path)
		_:
			err = ERR_INVALID_PARAMETER

	return err
