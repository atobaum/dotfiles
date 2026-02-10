-- ctrl만 누르면 esc 누르고 영어로 바꾸기
local only_ctrl = false
local inputEnglish = "com.apple.keylayout.ABC"

hs.eventtap
	.new({ hs.eventtap.event.types.flagsChanged, hs.eventtap.event.types.keyDown }, function(event)
		if event:getKeyCode() == hs.keycodes.map.ctrl then
			if event:getFlags()["ctrl"] then
				only_ctrl = true
			elseif only_ctrl then
				hs.eventtap.event.newKeyEvent({}, hs.keycodes.map.escape, true):post()
				hs.eventtap.event.newKeyEvent({}, hs.keycodes.map.escape, false):post()
				hs.keycodes.currentSourceID(inputEnglish)
			end
		else
			only_ctrl = false
		end
	end)
	:start()

-- 마우스 클릭 시 solo ctrl 취소
hs.eventtap
	.new({ hs.eventtap.event.types.leftMouseDown, hs.eventtap.event.types.rightMouseDown }, function(event)
		only_ctrl = false
	end)
	:start()
