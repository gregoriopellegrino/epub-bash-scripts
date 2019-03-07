#!/bin/bash

# This script is part of Bash scripts for EPUB production #eprdctn
# url: https://github.com/gregoriopellegrino/epub-bash-scripts/
# author: Gregorio Pellegrino
# license: MIT License https://github.com/gregoriopellegrino/epub-bash-scripts/blob/master/LICENSE

# The script is based on https://stackoverflow.com/a/15875821

# DISCLAIMER
# Pixels should not be transformed in em: pixels are an absolute unit of measures, ems depends on the parent element (https://stackoverflow.com/a/4575518)
# Use these script at your own risk!

version="1.0"
dir_path="$1"

find "$dir_path" -name '*.css' |
while read file_path; do
    echo "$file_path"
	perl -p -i -e 's/(\d+)px/($1\/16).em/ge' "$file_path"
done
