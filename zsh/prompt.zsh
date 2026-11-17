# ==============================================================================
# prompt.zsh: starship prompt. Loaded last so nothing overrides it.
# Config: ~/.config/starship.toml (a symlink to dotfiles/starship.toml).
# ==============================================================================

(( $+commands[starship] )) && eval "$(starship init zsh)"
