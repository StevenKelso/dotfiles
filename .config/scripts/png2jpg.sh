#!/usr/bin/env bash
set -euo pipefail

# png2jpg - convert a PNG (or any image) to a JPG with a white background
#
# Usage: png2jpg <file.png> [more files...]


if [ "$#" -eq 0 ]; then
    echo "Usage: png2jpg <file.png> [more files...]" >&2
    exit 1
fi

for input in "$@"; do
    if [ ! -f "$input" ]; then
        echo "Skipping '$input': file not found" >&2
        continue
    fi

    output="${input%.*}.jpg"

    magick "$input" -background white -alpha remove -alpha off "$output"
    echo "Converted: $input -> $output"
done
