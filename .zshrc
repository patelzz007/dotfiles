# ==============================================================================
# ~/.zshrc: loader only.
#
# The real config lives in ~/.config/zsh/, one file per topic. Edit it with `editzsh`.
#   env.zsh         environment variables
#   path.zsh        PATH, built in one place
#   omz.zsh         Oh My Zsh theme + plugins
#   node.zsh        Node/nvm (lazy-loaded)
#   tools.zsh       fzf, bun completions
#   colors.zsh      $CLR colour table
#   aliases.zsh     general aliases
#   navigation.zsh  cl/cs, up, folder shortcuts, `p` project jumper
#   files.zsh       file/folder helpers (cleardir, delete_node, getsshkey...)
#   misc.zsh        startserver, weather, dl-website, cap-*, fuck...
#   git.zsh         git aliases, gitpush, gitreset, gitrinse...
#   ramcheck.zsh    ramcheck
#
# Previous single-file version: ~/.zshrc.bak-2026-11-18
# ==============================================================================

ZSH_CONFIG_DIR="$HOME/.config/zsh"

# On a reload (`resource`), start from a clean slate: a leftover alias with the
# same name as a function would otherwise break that function's definition.
# Oh My Zsh and the files below re-create every alias they need.
unalias -m '*'

# Order matters: env -> path -> oh-my-zsh -> everything else.
for _zsh_file in env path omz node tools colors aliases navigation files misc git ramcheck; do
    if [[ -r $ZSH_CONFIG_DIR/$_zsh_file.zsh ]]; then
        source "$ZSH_CONFIG_DIR/$_zsh_file.zsh"
    else
        print -u2 -- "zshrc: missing $ZSH_CONFIG_DIR/$_zsh_file.zsh"
    fi
done
unset _zsh_file

# Startup line: current date and time (12-hour clock).
date '+%I:%M:%S %p / %A / %B %-d, %Y'

# Tool installers that append to this file will add their lines below.
# Move them into path.zsh / tools.zsh when convenient.
