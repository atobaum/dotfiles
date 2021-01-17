#!/bin/bash

args=()

# verbose, recursive, update
args+=( -vru )

# git
args+=( --exclude "'.git'" )
args+=( --exclude "'.gitignore'" )
args+=( --exclude "'README.md'" )

args+=( --exclude "'sync.sh'" )

# mac
if [[ uname == "Darwin" ]]; then
	args+=( --exclude "'.Xmodmap'" )
	args+=( --exclude "'.Xresources'" )
	args+=( --exclude "'.xbindkeysrc'" )
	args+=( --exclude "'.xpofile'" )
	args+=( --exclude "'.config/i3'" )
	args+=( --exclude "'.config/polybar'" )
fi

rsync "${args[@]}" . ~
