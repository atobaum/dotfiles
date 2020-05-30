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
	export PRIMARY_DISPLAY=HDMI1
else
	export PRIMARY_DISPLAY=eDP1
fi

compton -b

xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 600 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .5' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  --timer 300 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1 && systemctl suspend' \
    ''
