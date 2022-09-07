# zinit
if ! [ -x "$(command -v zinit)" ]; then
	bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

# neovim
if ! [ -x "$(command -v nvim)" ]; then
	echo "install Neovim"
	brew install nvim
fi

