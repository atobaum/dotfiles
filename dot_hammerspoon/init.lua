local wifiWatcher = require("modules/wifi_watcher")
local ctrlEscape = require("modules/ctrl_escape")
local appSwitcher = require("modules/app_switcher")

-- for debug
hs.hotkey.bind({ "shift" }, "F1", hs.reload)

hs.alert.show("hammerspoon loaded")
