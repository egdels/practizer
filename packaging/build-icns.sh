#!/usr/bin/env bash
set -euo pipefail
this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if ! command -v iconutil >/dev/null 2>&1; then
  echo "iconutil not found. Install Xcode command line tools (xcode-select --install)." >&2
  exit 1
fi
iconutil -c icns "$this_dir/Practizer.iconset" -o "$this_dir/Practizer.icns"
echo "Created $this_dir/Practizer.icns"
