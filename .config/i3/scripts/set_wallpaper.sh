#! /bin/bash

DATE=`date +%y%m%d`
IMG_PATH="$HOME/.config/wallpaper"
IMG_FILE_NAME="$IMG_PATH/bing-$DATE.jpg"

[ ! -d "$IMG_PATH" ] && mkdir -p "$IMG_PATH"

if [ ! -f "$IMG_FILE_NAME" ]; then
	#rm "$IMG_PATH"/*
	python3 "$HOME"/.config/i3/scripts/download_bing_wallpaper.py "$IMG_FILE_NAME"
fi
feh --bg-scale "$IMG_FILE_NAME" || feh --randomize --bg-scale "$IMG_PATH"/*.jpg
