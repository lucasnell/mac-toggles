# mac-toggles

Two one-click macOS AppleScript apps.

- **Toggle Cloud** — if any of Google Drive, OneDrive, or Box is running, quits them all; otherwise opens them all. Edit `cloudApps` in `src/Nimbus.applescript` to change the list.
- **Toggle WiscVPN** — toggles GlobalProtect by running `launchctl unload` (if loaded) or `launchctl load` (if not) on `/Library/LaunchAgents/com.paloaltonetworks.gp.pangp*`.

## Build

```bash
brew install librsvg   # provides rsvg-convert, used for icons
./build.sh             # writes the apps to build.noindex/
```

Copy the apps from `build.noindex/` to `/Applications`. The `.noindex` suffix keeps Spotlight (and launchers like Alfred) from listing the build copies. On first run, Toggle Cloud asks permission to control System Events and the cloud apps.
