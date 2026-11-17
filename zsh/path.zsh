# ==============================================================================
# path.zsh: the ONE place PATH is built.
#
#   typeset -U path   -> duplicate entries are dropped automatically
#   (N-/) filter      -> directories that don't exist are dropped
#
# Earlier entries win. Add new tools here rather than with `export PATH=...`
# elsewhere. (The node/nvm bin dir is prepended in node.zsh.)
# ==============================================================================

typeset -U path

path=(
    $JAVA_HOME/bin
    $HOME/.grok/bin
    $PNPM_HOME/bin
    $HOME/.antigravity/antigravity/bin
    /Applications/WebStorm.app/Contents/MacOS
    $HOME/bin
    $HOME/.config/phpmon/bin
    $HOME/.local/bin
    $BUN_INSTALL/bin
    /opt/homebrew/opt/postgresql@18/bin
    $HOME/.composer/vendor/bin
    $path                                   # system + Homebrew + ~/.zprofile entries
    $ANDROID_HOME/platform-tools
    $ANDROID_HOME/emulator
    $ANDROID_HOME/cmdline-tools/latest/bin
    $HOME/.fzf/bin
)
path=( ${^path}(N-/) )
