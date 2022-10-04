local f13_mode = hs.hotkey.modal.new()

f13_mode:bind({}, "space", function()
	hs.application.launchOrFocus("WezTerm")
end)

f13_mode:bind({}, "c", function()
	hs.application.launchOrFocus("Google Chrome")
end)

f13_mode:bind({}, "o", function()
	hs.application.launchOrFocus("Obsidian")
end)

hs.hotkey.bind({}, "f13",
	function() f13_mode:enter() end,
	function() f13_mode:exit() end
)
