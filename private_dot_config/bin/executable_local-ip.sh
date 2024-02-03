#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title local ip
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.author Kim Hyunyoung
# @raycast.authorURL https://github.com/atobaum

echo $(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}')
