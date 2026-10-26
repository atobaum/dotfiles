# repo: fzf-based git repository switcher
# Searches ~/modusign, ~/github, ~/test for git repos
# Supports regular repos, bare repos (.git dirs), and linked worktrees (.git files)
# Sorted by usage frequency (most visited first)

repo() {
  local dir
  local roots=(~/modusign ~/github ~/test)
  local history_file="${XDG_DATA_HOME:-$HOME/.local/share}/repo_history"

  # --list / -l: print all repos (same as fzf list) with full paths
  if [[ "$1" == "--list" || "$1" == "-l" ]]; then
    {
      fd --type d --hidden --max-depth 3 '^\.git$' "${roots[@]}" 2>/dev/null \
        | sed -E 's|/.git/?$||'
      fd --type f --hidden --max-depth 4 '^\.git$' "${roots[@]}" 2>/dev/null \
        | sed -E 's|/.git$||'
      fd --type d --max-depth 3 '\.git$' "${roots[@]}" 2>/dev/null \
        | grep -vE '(^|/)\.git$' \
        | sed 's|/$||'
    } | sort -u
    return 0
  fi

  [[ -f "$history_file" ]] || touch "$history_file"

  local all_repos
  all_repos=$(
    {
      # Regular repos: .git directory
      fd --type d --hidden --max-depth 3 '^\.git$' "${roots[@]}" 2>/dev/null \
        | sed -E 's|/.git/?$||'

      # Linked worktrees: .git file (not directory)
      fd --type f --hidden --max-depth 4 '^\.git$' "${roots[@]}" 2>/dev/null \
        | sed -E 's|/.git$||'

      # Bare repos: directory ending in .git (but not named exactly .git)
      fd --type d --max-depth 3 '\.git$' "${roots[@]}" 2>/dev/null \
        | grep -vE '(^|/)\.git$' \
        | sed 's|/$||'
    } \
    | sed "s|$HOME/||" \
    | sort -u
  )

  local sorted_repos
  if [[ -s "$history_file" ]]; then
    sorted_repos=$(
      printf '%s\n' "$all_repos" \
      | awk '
          NR==FNR { count[$0]++; next }
          { print (count[$0] ? count[$0] : 0) "\t" $0 }
        ' "$history_file" - \
      | sort -t$'\t' -k1 -rn -k2 \
      | cut -f2-
    )
  else
    sorted_repos=$(printf '%s\n' "$all_repos")
  fi

  dir=$(printf '%s\n' "$sorted_repos" \
    | fzf \
        --prompt="  repo > " \
        --layout=reverse \
        --height=50% \
        --query "${1:-}" \
        --preview '
          export PATH="/opt/homebrew/bin:/usr/local/bin:/bin:/usr/bin:$PATH";
          [[ -n "$HOMEBREW_PREFIX" ]] && export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH";
          path=~/{};
          if [[ $(git -C "$path" rev-parse --is-bare-repository 2>/dev/null) == "true" ]]; then
            echo "[bare repo]" && echo &&
            git -C "$path" branch -a --color=always &&
            echo &&
            git -C "$path" log --oneline --color=always -8
          else
            if command -v eza &>/dev/null; then
              eza --tree --color=always --level=2 "$path"
            else
              ls -la "$path"
            fi &&
            echo &&
            git -C "$path" log --oneline --color=always -8
          fi
        ' \
        --preview-window=right:55%)

  if [[ -n "$dir" ]]; then
    echo "$dir" >> "$history_file"
    local tmp; tmp=$(tail -500 "$history_file") && printf '%s\n' "$tmp" > "$history_file"
    cd ~/"$dir"
  fi
}
