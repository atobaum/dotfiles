# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Hammerspoon (`~/.hammerspoon`) configuration for macOS automation. Hammerspoon is a Lua-based automation tool that bridges macOS APIs. All code is Lua using the `hs.*` API namespace.

## Reload

- **Shift+F1** reloads the config (defined in `init.lua:102`)
- Or call `hs.reload()` from the Hammerspoon console
- After any code change, reload is required — there is no hot-reload

## Architecture

**`init.lua`** — Single entry point. Contains:
- **F13 modal layer**: Hold F13 + key to toggle-launch apps (e.g., Space=Ghostty, B=Firefox, S=Slack). Uses `hs.hotkey.modal` — press F13 enters modal, release exits.
- **Ctrl-as-Escape**: An eventtap that fires Escape + switches input to English (`com.apple.keylayout.ABC`) when Ctrl is pressed and released alone. Mouse clicks cancel the solo-Ctrl detection.
- **Chooser** (F13+R): Quick-launch bookmarks/actions via `hs.chooser`.

**`modules/`** — Standalone feature modules.
- `inputsource_aurora.lua`: Draws green overlay bars at screen edges when a non-English input source is active. Currently **not wired** into init.lua (the event listener is commented out).

**`Spoons/`** — Directory for third-party Hammerspoon plugins (currently empty).

## Conventions

- Comments and UI strings are in Korean
- App toggle pattern: `f13_mode:bind({}, "key", toggleApp("AppName"))` — `toggleApp` hides if frontmost, otherwise launches and centers mouse
- The `inputEnglish` source ID `"com.apple.keylayout.ABC"` is used in multiple places for Korean↔English switching
