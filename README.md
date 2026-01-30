# Dotfiles

macOS 개발 환경 설정을 위한 dotfiles. [chezmoi](https://www.chezmoi.io/)로 관리됩니다.

## 포함된 설정

- **Shell**: zsh (starship prompt, zoxide, fzf)
- **Terminal**: Ghostty
- **Editor**: Neovim
- **Git**: gitconfig, git-trim
- **Window Manager**: Hammerspoon
- **Keyboard**: Kanata

## 설치

```shell
# Homebrew 설치
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# chezmoi 설치 및 dotfiles 적용
brew install chezmoi
chezmoi init --apply https://github.com/atobaum/dotfiles.git
```

## Brew 패키지 설치

```shell
brew bundle
```

## macOS 설정

### 키보드
- 키보드 단축키에서 Spotlight 비활성화
- 입력 소스 전환: `Cmd + Space`
- [구름 입력기](https://github.com/gureum/gureum) 설치

### 폰트
- Nerd Font 설치 (Brewfile에 포함)

### 브라우저
- Chrome
- Arc

## Brewfile 업데이트

현재 설치된 패키지로 Brewfile 갱신:

```shell
brew bundle dump --force --file=~/.local/share/chezmoi/Brewfile
```

또는 chezmoi source 디렉토리에서:

```shell
cd ~/.local/share/chezmoi
brew bundle dump --force
chezmoi apply
```