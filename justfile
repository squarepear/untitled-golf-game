_default:
    @just --list

lint:
    gdscript-formatter lint --pretty $(find project -name "*.gd")

format:
    gdscript-formatter --reorder-code $(find project -name "*.gd")

test:
    godot --headless -d -s --path project addons/gut/gut_cmdln.gd \
        -gdir=res://test/ -ginclude_subdirs=true -gprefix="" \
        -gsuffix="_test.gd" -gexit

build platform="web":
    @echo -e "Building {{ platform }} version of the game..."
    rm -r builds/{{ platform }}/ || true
    mkdir -p builds/{{ platform }}/
    godot --headless --path project --export-release {{ platform }}
    zip -r builds/{{ platform }}.zip builds/{{ platform }}/

publish platform="web": (build platform)
    @echo -e "Publishing {{ platform }} build to itch.io..."
    butler push builds/{{ platform }}.zip squarepear/golf-but-the-hole-plays-too:{{ platform }}

status:
    butler status squarepear/golf-but-the-hole-plays-too

dev:
    godot --path project --editor

play:
    godot --path project

screenshot path="screenshots/%s.png":
    mkdir -p $(dirname "{{ path }}")
    godot --path project -s "uid://dfpbq23ycuc70" -- $(pwd)/{{ path }} $(grep -rl "uid://d02f7u7rffdbn" --include="*.tscn" project | sed 's|^project/||')
