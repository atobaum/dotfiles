local wezterm = require 'wezterm'
local appearnce = require 'appearance'

local config = wezterm.config_builder()

local act = wezterm.action

-- -- Use it!
-- if appearance.is_dark() then
--   config.color_scheme = 'Tokyo Night'
-- else
--   config.color_scheme = 'Tokyo Night Day'
-- end

config.color_scheme = 'Tokyo Night'

-- 가나다
config.font = wezterm.font_with_fallback(
  { family = 'JetBrains Mono' }
)
config.font_size = 13

config.window_padding = {
  left   = '10px',
  right  = '10px',
  top    = '20px',
  bottom = '20px',
}

-- Slightly transparent and blurred background
config.window_background_opacity = 0.9
config.macos_window_background_blur = 30
-- Removes the title bar, leaving only the tab bar. Keeps
-- the ability to resize by dragging the window's edges.
-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
-- you want to keep the window controls visible and integrate
-- them into the tab bar.
config.window_decorations = 'INTEGRATED_BUTTONS'
-- Sets the font for the window frame (tab bar)
config.window_frame = {
  -- Berkeley Mono for me again, though an idea could be to try a
  -- serif font here instead of monospace for a nicer look?
  font = wezterm.font({ family = 'JetBrains Mono', weight = 'Bold' }),
  font_size = 11,
}

wezterm.on('update-status', function(window)
  -- Grab the utf8 character for the "powerline" left facing
  -- solid arrow.
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  local right_status_table = {}

  -- Grab the current window's configuration, and from it the
  -- palette (this is the combination of your chosen colour scheme
  -- including any overrides).
  local color_scheme = window:effective_config().resolved_palette
  local bg = color_scheme.background
  local fg = color_scheme.foreground

  -- show active key table
  local key_table_status = ""
  local key_table_bg = bg
  local arrow_color = fg

  local active_key_table = window:active_key_table()
  if active_key_table then
    key_table_status = 'TABLE: ' .. active_key_table
    key_table_bg = "#008080"  -- key table 활성화 시 주황색 배경

    table.insert(right_status_table, { Background = { Color = 'none' } })
    table.insert(right_status_table, { Foreground = { Color = key_table_bg } })
    table.insert(right_status_table, { Text = SOLID_LEFT_ARROW })

    table.insert(right_status_table, { Background = { Color = key_table_bg } })
    table.insert(right_status_table, { Foreground = { Color = fg } })
    table.insert(right_status_table, { Text = ' ' .. key_table_status .. ' ' })
  end

  table.insert(right_status_table, { Background = { Color = 'none' } })
  table.insert(right_status_table, { Foreground = { Color = bg } })
  table.insert(right_status_table, { Text = SOLID_LEFT_ARROW })
  table.insert(right_status_table, { Background = { Color = bg } })
  table.insert(right_status_table, { Foreground = { Color = fg } })
  table.insert(right_status_table, { Text = ' ' .. wezterm.strftime('%a %b %-d %H:%M') .. ' ' })

  window:set_right_status(wezterm.format(right_status_table))
end
)


config.set_environment_variables = {
  PATH = '/opt/homebrew/bin:' .. os.getenv('PATH')
}

local function move_pane(key, direction)
  return {
    key = key,
    mods = 'LEADER',
    action = wezterm.action.ActivatePaneDirection(direction),
  }
end

local function resize_pane(key, direction)
  return {
    key = key,
    action = wezterm.action.AdjustPaneSize { direction, 3 }
  }
end

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = 'a',
    -- When we're in leader mode _and_ CTRL + A is pressed...
    mods = 'LEADER|CTRL',
    -- Actually send CTRL + A key to the terminal
    action = wezterm.action.SendKey { key = 'a', mods = 'CTRL' },
  },

  -- multiplexer
  move_pane('j', 'Down'),
  move_pane('k', 'Up'),
  move_pane('h', 'Left'),
  move_pane('l', 'Right'),
  {
    key = ',',
    mods = 'SUPER',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.config_dir,
      args = { 'nvim', wezterm.config_file },
    },
  },
  {
    key = '"',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = ':',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    mods = "LEADER",
    key  = "x",
    action = wezterm.action.CloseCurrentPane { confirm = false }
  },
  {
    key = 'r',
    mods = 'LEADER',
    -- Activate the `resize_panes` keytable
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_panes',
      -- Ensures the keytable stays active after it handles its
      -- first keypress.
      one_shot = false,
      -- Deactivate the keytable after a timeout.
      timeout_milliseconds = 1000,
    },
  },
  { mods = 'LEADER', key = ']', action = act.RotatePanes "Clockwise" },
  { mods = 'LEADER', key = '[', action = act.RotatePanes "CounterClockwise" },
  { mods = 'LEADER', key = 'p', action = act.PaneSelect { alphabet = "1234567890" }, },

  -- command palette
  {
    key = 'p',
    mods = 'CMD',
    action = wezterm.action.ActivateCommandPalette,
  }
}

config.key_tables = {
  resize_panes = {
    resize_pane('j', 'Down'),
    resize_pane('k', 'Up'),
    resize_pane('h', 'Left'),
    resize_pane('l', 'Right'),
  },
}

return config
