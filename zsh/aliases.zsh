# ==============================================================================
# aliases.zsh: general-purpose aliases.
# Git aliases live in git.zsh; folder shortcuts in navigation.zsh.
# ==============================================================================

# ---- Shell -------------------------------------------------------------------
alias resource='source ~/.zshrc'                       # Reload config
alias cls='clear'
alias x='exit'
alias shell-to-zsh='chsh -s "$(command -v zsh)"'
alias shell-to-bash='chsh -s "$(command -v bash)"'

# ---- Listing (eza: git status per file, icons, folders first) ----------------
# Plain `ls` is kept as-is so its familiar flags (ls -lt etc.) still work.
# Sort orders match the old ls versions: largest / newest first.
alias ls='ls --color=auto'
alias ll='eza -la --header --git --icons --group-directories-first'
alias llr='eza -la --header --git --icons --group-directories-first --reverse'
alias lls='eza -la --header --git --icons --sort=size --reverse'        # by size
alias llsr='eza -la --header --git --icons --sort=size'                 # by size, reversed
alias lld='eza -la --header --git --icons --sort=modified --reverse'    # by date modified
alias lldr='eza -la --header --git --icons --sort=modified'             # by date modified, reversed
alias lldc='eza -la --header --git --icons --sort=created --reverse'    # by date created
alias lldcr='eza -la --header --git --icons --sort=created'             # by date created, reversed
alias tree='eza --tree --icons --git-ignore --ignore-glob="node_modules|.git"'   # tree -L 2 for depth

# ---- Viewing -----------------------------------------------------------------
alias cat='bat --paging=never --style=plain'           # Syntax-highlighted cat (bat FILE for line numbers)
alias lg='lazygit'                                     # Terminal UI for git

# ---- Files -------------------------------------------------------------------
alias perm="stat -f '%Lp'"                             # Permissions as a number, e.g. 644
alias mkdir='mkdir -pv'                                # Create parent dirs, show what was made
alias t='trash'                                        # Move to Trash (macOS built-in)

# ---- Edit config files -------------------------------------------------------
alias edithosts='code /etc/hosts'
alias editbash='code ~/.bashrc'
alias editzsh='code "$DOTFILES"'                        # Whole dotfiles repo
alias editsshconfig='code ~/.ssh/config'

# ---- Homebrew ----------------------------------------------------------------
alias brewup='brew update && brew upgrade && brew cleanup'

# ---- npm / yarn --------------------------------------------------------------
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrb='npm run build'
alias ys='yarn start'
alias yd='yarn dev'
alias yb='yarn build'

# ---- Laravel Valet -----------------------------------------------------------
alias v='valet'

# ---- Capistrano (bundle) -----------------------------------------------------
alias bec='bundle exec cap'
alias becs='bundle exec cap staging'
alias becp='bundle exec cap production'
