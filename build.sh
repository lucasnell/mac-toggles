#!/bin/bash
# Build the toggle apps from src/<src>.applescript with icons from icons/<src>.svg.
# Requires rsvg-convert (brew install librsvg).
set -euo pipefail
cd "$(dirname "$0")"
build() {  # $1 = source/icon basename, $2 = app name
  local src="$1" app="$2.app"
  osacompile -o "$app" "src/$src.applescript"
  local set_dir; set_dir="$(mktemp -d)/$src.iconset"; mkdir -p "$set_dir"
  for s in 16 32 128 256 512; do
    rsvg-convert -w $s -h $s "icons/$src.svg" -o "$set_dir/icon_${s}x${s}.png"
    rsvg-convert -w $((s*2)) -h $((s*2)) "icons/$src.svg" -o "$set_dir/icon_${s}x${s}@2x.png"
  done
  iconutil -c icns "$set_dir" -o "icons/$src.icns"
  cp "icons/$src.icns" "$app/Contents/Resources/applet.icns"
  rm -f "$app/Contents/Resources/Assets.car"
  /usr/libexec/PlistBuddy -c "Delete :CFBundleIconName" "$app/Contents/Info.plist" 2>/dev/null || true
  codesign --force -s - "$app"
  touch "$app"
  echo "Built: $app"
}
build Nimbus "Toggle Cloud"
build Tunnel "Toggle WiscVPN"
