local function centerMouse()
	local screen = hs.window.focusedWindow():frame()
	local pt = hs.geometry.rectMidPoint(screen)
	hs.mouse.absolutePosition(pt)
end

local function toggleApp(name)
	return function()
		local activated = hs.application.frontmostApplication()
		local path = string.lower(activated:path())

		if string.match(path, string.lower(name) .. "%.app$") then
			activated:hide()
			return
		end

		hs.application.launchOrFocus(name)
		centerMouse()
	end
end

local f13_mode = hs.hotkey.modal.new()

-- f13_mode:bind({}, "space", toggleApp("WezTerm"))
f13_mode:bind({}, "space", toggleApp("Ghostty"))
f13_mode:bind({}, "b", toggleApp("Firefox"))
f13_mode:bind({}, "c", toggleApp("Google Chrome"))
f13_mode:bind({}, "n", toggleApp("Obsidian"))
f13_mode:bind({}, "v", toggleApp("Visual Studio Code"))
-- f13_mode:bind({}, "v", toggleApp("Cursor"))
f13_mode:bind({}, "s", toggleApp("Slack"))
-- f13_mode:bind({}, "m", toggleApp("Spark Desktop"))
f13_mode:bind({}, "a", toggleApp("ChatGPT"))
f13_mode:bind({}, "h", toggleApp("Heynote"))
f13_mode:bind({}, "y", toggleApp("YouTube Music"))
f13_mode:bind({}, "t", toggleApp("Akiflow"))

local chooser = hs.chooser.new(function(choice)
	if choice.type == "bookmark" then
		hs.execute("open " .. choice.url)
	else
		hs.alert.show(choice.text)
	end
end)

f13_mode:bind({}, "r", function()
	local list = {}
	table.insert(list, {
		text = "Readwise",
		subText = "화면에 첫 번째 알림을 띄웁니다",
		type = "bookmark",
		url = "https://read.readwise.io/",
		-- image = hs.image.imageFromPath( 이미지 주소 .. '.jpg'),
	})
	table.insert(list, {
		text = "alert2",
		subText = "화면에 두 번째 알림을 띄웁니다",
		-- image = hs.image.imageFromPath( 이미지 주소 .. '.jpg'),
	})
	chooser:choices(list)
	chooser:show()
end)

hs.hotkey.bind({}, "f13", function()
	f13_mode:enter()
end, function()
	f13_mode:exit()
end)
