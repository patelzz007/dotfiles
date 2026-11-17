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

# ---- Listing -----------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls -alh'                                     # List files
alias llr='ls -alhr'                                   # ...reversed
alias lls='ls -alhS'                                   # by size
alias llsr='ls -alhSr'                                 # by size, reversed
alias lld='ls -alht'                                   # by date modified
alias lldr='ls -alhtr'                                 # by date modified, reversed
alias lldc='ls -alhtU'                                 # by date created
alias lldcr='ls -alhtUr'                               # by date created, reversed
alias tree="find . -print | sed -e 's;[^/]*/;|_;g;s;_|; |;g'"   # Simple tree (no tree binary installed)

# ---- Files -------------------------------------------------------------------
alias perm="stat -f '%Lp'"                             # Permissions as a number, e.g. 644
alias mkdir='mkdir -pv'                                # Create parent dirs, show what was made
alias t='trash'                                        # Move to Trash (macOS built-in)

# ---- Edit config files -------------------------------------------------------
alias edithosts='code /etc/hosts'
alias editbash='code ~/.bashrc'
alias editzsh='code ~/.zshrc ~/.config/zsh'
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
