#!/bin/bash

# change key binding
xmodmap ~/.Xmodmap
xcape -e 'Control_L=Escape'

# for mouse button
xbindkeys
# mouse sensitivity
xinput --set-prop 11 "Coordinate Transformation Matrix" 1.7 0 0 0 1.7 0 0 0 1 &

# monitor setup
if [ $(xrandr | grep -o "HDMI1") == "HDMI1" ]; then
	xrandr --output HDMI1 --mode 1920x1080 --primary
	xrandr --output eDP1 --off
fi

compton -b

export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"
rm /tmp/xidlehook.sock
xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 900 \
    "xrandr --output $PRIMARY_DISPLAY --brightness .5" \
    "xrandr --output $PRIMARY_DISPLAY --brightness 1" \
  --timer 300 \
    "xrandr --output $PRIMARY_DISPLAY --brightness 1 && systemctl suspend" \
    '' \
  --socket "/tmp/xidlehook.sock"
