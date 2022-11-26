function centerMouse()
  local screen = hs.window.frontmostWindow():frame()
  hs.alert.show(screen)
  local pt = hs.geometry.rectMidPoint(screen)
  hs.alert.show(pt)
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
  end
end

local f13_mode = hs.hotkey.modal.new()

f13_mode:bind({}, "space", toggleApp("WezTerm"))
f13_mode:bind({}, "b", toggleApp("Google Chrome"))
f13_mode:bind({}, "o", toggleApp("Obsidian"))

hs.hotkey.bind({}, "f13",
	function() f13_mode:enter() end,
	function() f13_mode:exit() end
)

hs.alert.show("hammerspoon loaded")
