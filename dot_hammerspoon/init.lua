require("modules.app_switcher")
require("modules.ctrl_escape")
require("modules.wifi_watcher")

-- for debug
hs.hotkey.bind({ "shift" }, "F1", hs.reload)

hs.alert.show("hammerspoon loaded")
