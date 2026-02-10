-- 위치 서비스 권한 요청 (WiFi SSID 접근에 필요)
hs.location.start()

local companySSIDs = { ["MODUSIGN-SEOUL"] = true, ["MODUSIGN-Guest"] = true }
local homeSSIDs = { ["gilsang"] = true }

hs.wifi.watcher.new(function()
	local ssid = hs.wifi.currentNetwork()
	print("[WiFi] SSID changed: " .. (ssid or "nil"))

	if ssid and companySSIDs[ssid] then
		-- 회사: Slack, 1Password 실행 + 음소거
		hs.application.launchOrFocus("Slack")
		hs.application.launchOrFocus("1Password")
		hs.audiodevice.defaultOutputDevice():setMuted(true)
		hs.alert.show("회사 WiFi: Slack, 1Password 실행 / 음소거")
	elseif ssid and homeSSIDs[ssid] then
		-- 집: 음소거 해제
		hs.audiodevice.defaultOutputDevice():setMuted(false)
		hs.alert.show("집 WiFi: 스피커 켜짐")
	end
end):start()
