# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Hammerspoon (`~/.hammerspoon`) configuration for macOS automation. Hammerspoon is a Lua-based automation tool that bridges macOS APIs. All code is Lua using the `hs.*` API namespace.

## Reload

- **Shift+F1** reloads the config (defined in `init.lua:102`)
- Or call `hs.reload()` from the Hammerspoon console
- After any code change, reload is required — there is no hot-reload

## Architecture

**`init.lua`** — All features in a single file:
- **Ctrl-as-Escape**: Solo ctrl tap → Escape + switch to English input. Mouse click cancels solo-ctrl detection.
- **F13 App Switcher**: F13 hold + key → toggle app (Space=Ghostty, B=Firefox, etc.). Uses `hs.hotkey.modal` with a 3-second watchdog to prevent stuck state.
- **WiFi Watcher**: Launches apps and controls mute based on work/home WiFi network.

**`modules/`** — Unused modules storage.
- `inputsource_aurora.lua`: Green overlay when non-English input source is active. Currently not wired up.

**`Spoons/`** — Third-party plugin directory (empty).

## Conventions

- Comments and UI strings are in Korean
- App toggle pattern: `f13_mode:bind({}, "key", toggleApp("AppName"))` — `toggleApp` hides if frontmost, otherwise launches and centers mouse
- The `inputEnglish` source ID `"com.apple.keylayout.ABC"` is used in multiple places for Korean↔English switching

## Hammerspoon/Lua Lifecycle Gotchas

### GC (Garbage Collection) — Always store references
- If you don't store a reference (e.g. `hs.eventtap.new():start()` without assignment), the object becomes eligible for GC. It will silently stop working minutes to hours later.
- **Always** store in a module-level variable: `local myTap = hs.eventtap.new():start()`.
- Same applies to all long-lived objects: `hs.timer`, `hs.canvas`, `hs.chooser`, etc.
- GC timing is unpredictable — timer callbacks, canvas creation/deletion, etc. can trigger collection of unreferenced objects in other modules.

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
