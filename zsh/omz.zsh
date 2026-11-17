# ==============================================================================
# omz.zsh: Oh My Zsh theme, plugins and completion setup.
# Options reference: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
# ==============================================================================

ZSH_THEME="ys"

# autojump is loaded by its plugin; no need to source it again by hand.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    autojump
)

# Extra completion directories must be on fpath BEFORE oh-my-zsh runs compinit,
# so that compinit only runs once.
fpath=( $HOME/.grok/completions/zsh(N-/) $fpath )

source "$ZSH/oh-my-zsh.sh"

unsetopt BAD_PATTERN
