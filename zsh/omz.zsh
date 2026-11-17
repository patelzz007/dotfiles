# ==============================================================================
# omz.zsh: Oh My Zsh plugins and completion setup.
# Options reference: https://github.com/ohmyzsh/ohmyzsh/wiki/Settings
# ==============================================================================

# No Oh My Zsh theme: the prompt is drawn by starship (see prompt.zsh).
ZSH_THEME=""

# Plugin order matters: fzf-tab must come before autosuggestions and
# syntax-highlighting. (Directory jumping is zoxide's job now; see tools.zsh.)
plugins=(
    git
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Extra completion directories must be on fpath BEFORE oh-my-zsh runs compinit,
# so that compinit only runs once.
fpath=( $HOME/.grok/completions/zsh(N-/) $fpath )

source "$ZSH/oh-my-zsh.sh"

unsetopt BAD_PATTERN
