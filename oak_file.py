from pathlib import Path
from shutil import rmtree

from oak_build import task, run


BUILD_DIR = Path("./build").absolute()

COMMON_FILES = set([
    "common.scad",
])

@task
def build():
    BUILD_DIR.mkdir(exist_ok=True)

    for scad_file in sorted(Path('.').glob('*.scad')):
        print(scad_file, scad_file.name, scad_file.name in COMMON_FILES)
        if scad_file.name in COMMON_FILES:
            continue

        out_file = BUILD_DIR / (scad_file.stem + ".stl")

        run(f"openscad -o '{out_file}' --export-format binstl {scad_file}")
        run(f"slic3r --split  '{out_file}'")

    


@task
def clean():
    rmtree(BUILD_DIR)
