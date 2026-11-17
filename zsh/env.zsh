# ==============================================================================
# env.zsh: environment variables. PATH is built separately in path.zsh.
# ==============================================================================

export ZSH="$HOME/.oh-my-zsh"
export DOTFILES="${${:-$HOME/.config/zsh}:A:h}"   # the dotfiles repo (resolved through the symlink)
export BUN_INSTALL="$HOME/.bun"
export PNPM_HOME="$HOME/Library/pnpm"
export ANDROID_HOME="$HOME/Library/Android/sdk"

# Ask macOS where JDK 17 is instead of hardcoding it; fall back to the known install.
export JAVA_HOME="$(/usr/libexec/java_home -v 17 2>/dev/null \
    || print -r -- /Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home)"

# Coloured `ls` output (BSD ls).
export CLICOLOR=1
export LSCOLORS=GxExBxBxFxegedabagacad

# eza (ll, tree): two spaces between each file icon and its name, for readability.
export EZA_ICON_SPACING=2

# Man pages rendered with bat's syntax highlighting.
if (( $+commands[bat] )); then
    export MANPAGER="sh -c 'col -bx | bat -l man -p'"
    export MANROFFOPT='-c'
fi
