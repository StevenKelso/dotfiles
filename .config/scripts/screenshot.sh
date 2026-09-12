#!/usr/bin/env bash
set -euo pipefail

mode="${1:-region}"
save_dir="$HOME/Pictures/Screenshots"
mkdir -p "$save_dir"

case "$mode" in
    region)
        geometry=$(slurp -d) || exit 1
        grim -g "$geometry" -t ppm - | satty -f - \
            --output-filename "$save_dir/satty-$(date +%Y%m%d-%H%M%S).png" \
            --early-exit --initial-tool arrow \
            --copy-command wl-copy
        ;;
    output)
        grim -t ppm - | satty -f - \
            --output-filename "$save_dir/satty-$(date +%Y%m%d-%H%M%S).png" \
            --early-exit --initial-tool arrow \
            --copy-command wl-copy
        ;;
esac
