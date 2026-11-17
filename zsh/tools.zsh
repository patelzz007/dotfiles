# ==============================================================================
# tools.zsh: third-party tool integrations (loaded after oh-my-zsh).
# ==============================================================================

# ---- fzf ---------------------------------------------------------------------
# Ctrl-R history search, Ctrl-T file picker, Alt-C cd, ** completion.
# File/folder lists come from fd (fast, respects .gitignore); previews use bat/eza.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
export FZF_DEFAULT_OPTS='--height=40% --reverse --border'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always --icons {}'"

if [[ -r $HOME/.fzf.zsh ]]; then
    source "$HOME/.fzf.zsh"                # git-installed fzf (runs `fzf --zsh` itself)
elif (( $+commands[fzf] )); then
    source <(fzf --zsh)                    # Homebrew fzf
fi

# ---- fzf-tab (Tab completion through fzf; plugin is loaded in omz.zsh) --------
zstyle ':completion:*' menu no                          # let fzf-tab draw the menu
zstyle ':completion:*:descriptions' format '[%d]'       # group headers; switch with < >
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':fzf-tab:complete:(cd|z|__zoxide_z):*' fzf-preview 'eza -1 --color=always --icons $realpath'
zstyle ':fzf-tab:complete:git-(checkout|switch):*' fzf-preview 'git log --oneline --graph --color=always -15 $word 2>/dev/null'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,comm -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview '[[ $group == "[process ID]" ]] && ps -p $word -o command= -ww'

# ---- zoxide (smarter cd; replaces autojump) ------------------------------------
#   z rew   -> jump to the best match, e.g. ~/Desktop/Bishen/NextJS/rewardhub-monorepo
#   zi      -> pick from a list with fzf
if (( $+commands[zoxide] )); then
    eval "$(zoxide init zsh)"
    alias j='z'                            # old autojump habit
fi

# ---- bun completions -----------------------------------------------------------
[[ -s $BUN_INSTALL/_bun ]] && source "$BUN_INSTALL/_bun"
