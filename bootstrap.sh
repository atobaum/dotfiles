#!/usr/bin/env bash



git pull origin main;

function doIt() {
	args=()

	# verbose, recursive, update
	args+=( -avh --no-perms )

	# git
	args+=( --exclude "'.git'" )
	args+=( --exclude "'.gitignore'" )
	args+=( --exclude "'README.md'" )

	args+=( --exclude "'bootstrap.sh'" )

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
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;
