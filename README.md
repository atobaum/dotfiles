# dotfiles
My dotfiles

- tmux
- neovim
- github
  - gpg

## Install [Homebrew](https://brew.sh/)
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Neovim config
### Install
```shell
brew install neovim
```

### Install [vim-plug](https://github.com/junegunn/vim-plug)
```shell
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

After install `vim-plug`, run nvim and install plugins by ex command `PlugInstall`

Prvider install
```shell
pip3 install neovim
```

## Git config
