_default:
    @just --list

lint:
    gdscript-formatter lint --pretty project/**/*.gd

format:
    gdscript-formatter --reorder-code project/**/*.gd

build platform="web":
    rm -r builds/{{ platform }}/ || true
    mkdir -p builds/{{ platform }}/
    godot --headless --path project --export-release {{ platform }}
    zip -r builds/{{ platform }}.zip builds/{{ platform }}/
