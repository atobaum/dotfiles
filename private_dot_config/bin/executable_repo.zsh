# repo: fzf-based git repository switcher
# Searches ~/modusign, ~/github, ~/test for git repos

repo() {
  local dir
  local roots=(~/modusign ~/github ~/test)

  dir=$(fd --type d --hidden --max-depth 2 '^\.git$' "${roots[@]}" 2>/dev/null \
    | sed -E 's|/.git/?$||' \
    | sed "s|$HOME/||" \
    | sort \
    | fzf \
        --prompt="  repo > " \
        --layout=reverse \
        --height=50% \
        --preview 'eza --tree --color=always --level=2 ~/{} && echo && git -C ~/{} log --oneline --color=always -8' \
        --preview-window=right:55%)

  [[ -n "$dir" ]] && cd ~/"$dir"
}
