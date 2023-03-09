function centerMouse()
  local screen = hs.window.focusedWindow():frame()
  local pt = hs.geometry.rectMidPoint(screen)
  hs.mouse.absolutePosition(pt)
end

function toggleApp(name)
  return function()
    local activated = hs.application.frontmostApplication()
    local path = string.lower(activated:path())

    if string.match(path, string.lower(name) .. '%.app$') then
      activated:hide()
      return
    end

    hs.application.launchOrFocus(name)
    centerMouse()
  end
end

local f13_mode = hs.hotkey.modal.new()

f13_mode:bind({}, "space", toggleApp("WezTerm"))
f13_mode:bind({}, "b", toggleApp("Google Chrome"))
f13_mode:bind({}, "n", toggleApp("Obsidian"))
f13_mode:bind({}, "v", toggleApp("Visual Studio Code"))

hs.hotkey.bind({}, "f13",
	function() f13_mode:enter() end,
	function() f13_mode:exit() end
)

require("modules.inputsource_aurora")

hs.alert.show("hammerspoon loaded")

-- hs.hotkey.bind({'shift'}, 'F1', hs.hints.windowHints)
-- hs.hotkey.bind({'shift'}, 'F1', hs.reload)
