# ==============================================================================
# history.zsh: shell history. Loaded after oh-my-zsh so these values win.
# ==============================================================================

HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY        # save when each command ran and how long it took
setopt SHARE_HISTORY           # commands show up in your other open terminals immediately
setopt HIST_IGNORE_ALL_DUPS    # running a command again replaces its older copy
setopt HIST_IGNORE_SPACE       # commands typed with a leading space aren't saved (secrets)
setopt HIST_REDUCE_BLANKS      # tidy extra spaces before saving
setopt HIST_VERIFY             # `!!`-style expansions are shown for a check before running
