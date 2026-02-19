# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Hammerspoon (`~/.hammerspoon`) configuration for macOS automation. Hammerspoon is a Lua-based automation tool that bridges macOS APIs. All code is Lua using the `hs.*` API namespace.

## Reload

- **Shift+F1** reloads the config (defined in `init.lua`)
- Or call `hs.reload()` from the Hammerspoon console
- After any code change, reload is required — there is no hot-reload

## Architecture

**`init.lua`** — Thin entry point that loads modules:
```lua
require("modules/wifi_watcher")
require("modules/ctrl_escape")
require("modules/app_switcher")
```

**`modules/`** — Active feature modules:
- `ctrl_escape.lua`: Solo ctrl tap → Escape + switch to English input. Mouse click cancels solo-ctrl detection. Uses global `eventtap` variables (`ctrl_eventtab`, `ctrl_eventtab_2`) to prevent GC.
- `app_switcher.lua`: F13 hold + key → toggle app. Shows "F13 Mode" overlay indicator. Uses `hs.hotkey.modal` with a 3-second watchdog timer to prevent stuck state.
- `wifi_watcher.lua`: Launches apps and controls mute based on WiFi network (work/home).

**`Spoons/`** — Third-party plugin directory (empty).

### F13 App Bindings (`modules/app_switcher.lua`)

| Key | App |
|-----|-----|
| Space | Ghostty |
| B | Firefox |
| C | Google Chrome |
| N | Obsidian |
| V | Visual Studio Code |
| S | Slack |
| A | ChatGPT |
| H | Heynote |
| Y | YouTube Music |
| T | Akiflow |

### WiFi Networks (`modules/wifi_watcher.lua`)

- **Work** (`MODUSIGN-SEOUL`, `MODUSIGN-Guest`): Launch Slack + 1Password, mute audio
- **Home** (`gilsang`): Unmute audio

## Version Control (chezmoi)

This project is managed with [chezmoi](https://www.chezmoi.io/) for dotfiles versioning.

- **Source directory**: `~/.local/share/chezmoi/dot_hammerspoon/`
- **Remote**: `https://github.com/atobaum/dotfiles.git`
- Edit files directly in `~/.hammerspoon/` (working directory), then sync back to source.

### Workflow: Sync, Review, and Commit Changes

```bash
# 1. Sync working directory changes back to chezmoi source
chezmoi re-add ~/.hammerspoon/

# 2. Review what changed before committing
chezmoi git status
chezmoi git diff --staged

# 3. Stage and commit with a descriptive message based on the actual diff
chezmoi git add -- dot_hammerspoon/
chezmoi git commit -- -m "feat(hammerspoon): ..."
chezmoi git push
```

**Commit message tips:**
- Read the diff first — don't guess the message from memory
- Use conventional commits: `feat:`, `fix:`, `refactor:`, `docs:`, `chore:`
- Be specific: `feat: add Akiflow and Heynote to F13 app switcher` not `update config`

### Notes
- After editing `~/.hammerspoon/` files, always run `chezmoi re-add` to sync to source before committing.
- After editing source directly, run `chezmoi apply` to apply changes to the working directory.
- Use `chezmoi diff` to preview pending changes before committing.

## Conventions

- Comments and UI strings are in Korean
- App toggle pattern: `f13_mode:bind({}, "key", toggleApp("AppName"))` — `toggleApp` hides if frontmost, otherwise launches and centers mouse
- The `inputEnglish` source ID `"com.apple.keylayout.ABC"` is used in multiple places for Korean↔English switching

## Hammerspoon/Lua Lifecycle Gotchas

### GC (Garbage Collection) — Always capture in variables
- Lua GC destroys any object it believes is no longer in use. Timing is unpredictable (minutes to hours), based on how active your Lua code is.
- A variable that only exists inside a function/loop/scope is available for GC as soon as that scope finishes — **including `init.lua` itself**, which is a single scope that finishes after the final line runs.
- If you create objects in `init.lua` without capturing them in a variable, they will be silently destroyed later:
  ```lua
  -- BAD: uncaptured, will be GC'd unpredictably
  hs.pathwatcher.new(.....):start()

  -- GOOD: captured in global, survives until reload/quit
  myWatcher = hs.pathwatcher.new(.....):start()
  ```
- Global variables never go out of scope, so they survive until config reload or Hammerspoon quit.
- Same applies to all long-lived objects: `hs.eventtap`, `hs.timer`, `hs.canvas`, `hs.chooser`, `hs.pathwatcher`, etc.
- **Console note:** Each line entered in the Hammerspoon Console creates a distinct scope that closes on Enter — `local` variables become immediately inaccessible.

### Lua Variable Scope and Closures
- Closures capture **variable bindings (references), not values**. Multiple closures referencing the same local share its value.
- Referencing a local inside `local function foo()` before it's declared will reference the **global** instead — forward declaration is required.
- Forward declaration pattern: declare `local fn` first, then assign `fn = function() ... end`.

### hs.hotkey.modal
- `exit()` is safe to call multiple times (idempotent).
- `enter()` → `exit()` → `enter()` cycling works fine.
- To avoid redundant calls, guard with a state flag (e.g. `f13_held`).

### hs.timer
- Calling `timer:stop()` inside an `hs.timer.doEvery` callback is safe.
- No automatic cleanup — always call `stop()` explicitly.

### hs.canvas
- Modern versions auto-delete on GC. Explicit `delete()` call is for immediate cleanup.
