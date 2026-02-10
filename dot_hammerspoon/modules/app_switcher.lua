print("[modules] app_switcher loaded")
local function centerMouse()
	local win = hs.window.focusedWindow()
	if not win then return end
	local pt = hs.geometry.rectMidPoint(win:frame())
	hs.mouse.absolutePosition(pt)
end

local function toggleApp(name)
  print("[toggleApp] setting up for: " .. name)
	return function()
		print("[toggleApp] triggered: " .. name)
		local activated = hs.application.frontmostApplication()
		if not activated then return end
		local path = string.lower(activated:path() or "")

		if string.match(path, string.lower(name) .. "%.app$") then
			activated:hide()
			return
		end

		hs.application.launchOrFocus(name)
		centerMouse()
	end
end

-- F13 모드 상태 변수 (함수보다 먼저 선언해야 closure에서 local 참조)
local f13_indicator = nil
local f13_watchdog = nil
local f13_last_down = 0
local f13_held = false
local hideF13Indicator
local f13_mode

local function showF13Indicator()
	if f13_indicator then f13_indicator:delete() end
	local screen = hs.screen.mainScreen():frame()
	local width = 120
	local height = 28
	f13_indicator = hs.canvas.new({
		x = screen.x + screen.w - width - 10,
		y = screen.y + 10,
		w = width,
		h = height,
	})
	f13_indicator:appendElements({
		type = "rectangle",
		action = "fill",
		roundedRectRadii = { xRadius = 6, yRadius = 6 },
		fillColor = { red = 0.2, green = 0.2, blue = 0.2, alpha = 0.85 },
	}, {
		type = "text",
		text = hs.styledtext.new("F13 Mode", {
			font = { name = "Helvetica Neue", size = 14 },
			color = { red = 0.4, green = 1, blue = 0.4, alpha = 1 },
			paragraphStyle = { alignment = "center" },
		}),
		frame = { x = 0, y = "3%", w = "100%", h = "100%" },
	})
	f13_indicator:level(hs.canvas.windowLevels.overlay)
	f13_indicator:show()
	-- watchdog 타이머 시작
	f13_last_down = hs.timer.secondsSinceEpoch()
	if f13_watchdog then f13_watchdog:stop() end
	f13_watchdog = hs.timer.doEvery(0.5, function()
		if hs.timer.secondsSinceEpoch() - f13_last_down > 3 then
			print("[F13] watchdog: 강제 해제 (3초 초과)")
			f13_mode:exit()
			hideF13Indicator()
			f13_held = false
		end
	end)
end

hideF13Indicator = function()
	if f13_watchdog then
		f13_watchdog:stop()
		f13_watchdog = nil
	end
	if f13_indicator then
		f13_indicator:delete()
		f13_indicator = nil
	end
end

local f13_mode = hs.hotkey.modal.new()

f13_mode:bind({}, "space", toggleApp("Ghostty"))
f13_mode:bind({}, "b", toggleApp("Firefox"))
f13_mode:bind({}, "c", toggleApp("Google Chrome"))
f13_mode:bind({}, "n", toggleApp("Obsidian"))
f13_mode:bind({}, "v", toggleApp("Visual Studio Code"))
f13_mode:bind({}, "s", toggleApp("Slack"))
f13_mode:bind({}, "a", toggleApp("ChatGPT"))
f13_mode:bind({}, "h", toggleApp("Heynote"))
f13_mode:bind({}, "y", toggleApp("YouTube Music"))
f13_mode:bind({}, "t", toggleApp("Akiflow"))

hs.hotkey.bind({}, "f13", function()
	f13_mode:enter()
end, function()
	f13_mode:exit()
end)