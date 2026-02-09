_default:
    @just --list

lint:
    gdscript-formatter lint --pretty $(find project -name "*.gd")

format:
    gdscript-formatter --reorder-code $(find project -name "*.gd")

build platform="web":
    rm -r builds/{{ platform }}/ || true
    mkdir -p builds/{{ platform }}/
    godot --headless --path project --export-release {{ platform }}
    zip -r builds/{{ platform }}.zip builds/{{ platform }}/

dev:
    godot --path project --editor

play:
    godot --path project
