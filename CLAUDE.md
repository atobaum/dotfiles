# Chezmoi Dotfiles

This repository manages dotfiles via [chezmoi](https://www.chezmoi.io/).

## Key Commands

```bash
chezmoi status          # Show pending changes
chezmoi add <file>      # Track a new/modified file
chezmoi forget <file>   # Untrack a file
chezmoi apply           # Apply source to home directory
chezmoi diff            # Preview changes before apply
```

## Workflow

When editing dotfiles:
1. Edit the actual file (e.g. `~/.config/nvim/init.lua`)
2. Run `chezmoi add <file>` to sync changes into the source directory
3. Commit and push from `~/.local/share/chezmoi`

For deleted files: remove directly from `~/.local/share/chezmoi/` (chezmoi forget may require TTY).

## File Naming Conventions

chezmoi source files use a naming convention:
- `dot_` prefix → `.` (e.g. `dot_zshrc` → `~/.zshrc`)
- `private_` prefix → file with restricted permissions
- `private_dot_config/` → `~/.config/`

## Managed Configs

- **Neovim** (`private_dot_config/nvim/`) — lazy.nvim plugin manager; treesitter uses built-in `vim.treesitter` for highlighting (nvim-treesitter kept for parser management only)
- **Zsh** (`dot_zshrc`)
- **tmux** (`dot_tmux.conf`)
- **Git** (`dot_gitconfig.tmpl`)
- **Hammerspoon** (`dot_hammerspoon/`)
- **Homebrew** (`Brewfile`)
