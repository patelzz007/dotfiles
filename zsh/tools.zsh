# ==============================================================================
# tools.zsh: third-party tool integrations (loaded after oh-my-zsh).
# ==============================================================================

# fzf: Ctrl-R history search, Ctrl-T file picker, Alt-C cd, ** completion.
# (~/.fzf.zsh runs `source <(fzf --zsh)` itself, so it's only loaded once.)
[[ -r $HOME/.fzf.zsh ]] && source "$HOME/.fzf.zsh"

# bun completions
[[ -s $BUN_INSTALL/_bun ]] && source "$BUN_INSTALL/_bun"
