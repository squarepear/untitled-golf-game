class_name ScreenshotTool
extends SceneTree

const DEFAULT_SCENE_PATH := "res://menus/player_join.tscn"
const DEFAULT_PATH := "user://screenshot_%s.png"
const SETTLE_FRAMES := 2


func _init() -> void:
	var args := OS.get_cmdline_user_args()
	var screenshot_path = args[0] if args.size() > 0 else DEFAULT_PATH
	var scene_paths = Array(args.slice(1)) if args.size() > 1 else [DEFAULT_SCENE_PATH]

	ProjectSettings.set_setting("display/window/stretch/aspect", "expand")

	for scene_path in scene_paths:
		change_scene_to_file(scene_path)

		for i in range(SETTLE_FRAMES):
			await process_frame

		for screenshot_component in ScreenshotComponent.collect(self):
			screenshot_component.setup()
			await screenshot_component.setup_completed

			var output_path := screenshot_component.get_output_path(screenshot_path)

			var err = screenshot_component.take_screenshot(output_path)
			if err != OK:
				push_error("Failed to save screenshot to '%s': %s" % [output_path, error_string(err)])
				quit(1)

			print("Screenshot saved to '%s'" % output_path)

			screenshot_component.teardown()
			await screenshot_component.teardown_completed

	quit()
