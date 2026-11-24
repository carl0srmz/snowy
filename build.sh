#!/usr/bin/env bash
# Converts the original Flash data to native assets, then builds the game.
#   ORIGINAL=/path/to/Mission-in-Snowdriftland ./build.sh
# (a checkout of the original game files: the .swf files plus the data/ folder)
set -euo pipefail
cd "$(dirname "$0")"
ORIGINAL="${ORIGINAL:-original}"
if [ ! -f "$ORIGINAL/misnowdriftland_final.swf" ]; then
  echo "original game files not found in '$ORIGINAL' (set ORIGINAL=/path/to/checkout)" >&2
  exit 1
fi
cargo build --release
./target/release/swfx convert "$ORIGINAL" assets
echo "run:  ./target/release/snowdrift --assets assets --data $ORIGINAL"
