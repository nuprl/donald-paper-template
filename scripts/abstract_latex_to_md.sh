#!/bin/bash

in_path="$1"
out_path="$2"

pandoc -f latex -t json -o "$in_path.json" "$in_path"
python3 scripts/strip_bad_pandoc_formats.py "$in_path.json" "$in_path.clean.json"
pandoc -f json -t markdown -o "$out_path" "$in_path.clean.json"
rm "$in_path.json" "$in_path.clean.json"
