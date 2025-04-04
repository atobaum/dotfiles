function centerMouse()
	local screen = hs.window.focusedWindow():frame()
	local pt = hs.geometry.rectMidPoint(screen)
	hs.mouse.absolutePosition(pt)
end

function toggleApp(name)
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

f13_mode:bind({}, "space", toggleApp("WezTerm"))
f13_mode:bind({}, "b", toggleApp("Firefox"))
f13_mode:bind({}, "c", toggleApp("Google Chrome"))
f13_mode:bind({}, "n", toggleApp("Obsidian"))
f13_mode:bind({}, "v", toggleApp("Visual Studio Code"))
f13_mode:bind({}, "s", toggleApp("Slack"))
f13_mode:bind({}, "m", toggleApp("Spark"))

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

-- hs.hotkey.bind({'shift'}, 'F1', hs.hints.windowHints)

-- ctrl만 누르면 esc 누르고 영어로 바꾸기
only_ctrl = false
ctrl_eventtab = hs.eventtap
	.new({ hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown }, function(event)
		if event:getKeyCode() == hs.keycodes.map.ctrl then
			-- when pressed ctrl
			if event:getFlags()["ctrl"] then
				only_ctrl = true
			elseif only_ctrl then
				hs.eventtap.event.newKeyEvent({}, hs.keycodes.map.escape, true):post()
				hs.eventtap.event.newKeyEvent({}, hs.keycodes.map.escape, false):post()

				-- change keyboard to eng
				local inputEnglish = "com.apple.keylayout.ABC"
				hs.keycodes.currentSourceID(inputEnglish)
			end
		else
			only_ctrl = false
		end
	end)
	:start()

-- 마우스 지원 추가
ctrl_eventtab_2 = hs.eventtap
	.new({ hs.eventtap.event.types.leftMouseDown, hs.eventtap.event.types.rightMouseDown }, function(event)
		only_ctrl = false
	end)
	:start()

-- for debug
hs.hotkey.bind({ "shift" }, "F1", hs.reload)

hs.alert.show("hammerspoon loaded")
