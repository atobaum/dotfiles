-- ctrl만 누르면 esc 누르고 영어로 바꾸기
print("[modules] ctrl_escape loaded")
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
