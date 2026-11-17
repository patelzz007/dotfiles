# ==============================================================================
# ~/.zshrc: loader only.  (~/.zshrc is a symlink to dotfiles/.zshrc)
#
# The real config lives in dotfiles/zsh/ (linked as ~/.config/zsh/), one file per
# topic. Open the repo with `editzsh`. New machine: run dotfiles/install.sh.
#   env.zsh         environment variables
#   path.zsh        PATH, built in one place
#   omz.zsh         Oh My Zsh plugins (incl. fzf-tab)
#   history.zsh     history size + sharing between terminals
#   node.zsh        Node via fnm (auto-switches per project)
#   tools.zsh       fzf, zoxide, bat, bun completions
#   colors.zsh      $CLR colour table
#   aliases.zsh     general aliases (eza, bat, lazygit...)
#   navigation.zsh  cl/cs, up, folder shortcuts, `p` project jumper
#   files.zsh       file/folder helpers (cleardir, delete_node, getsshkey...)
#   misc.zsh        startserver, weather, dl-website, cap-*, fuck...
#   dev.zsh         killport, ports, gco, nr
#   search.zsh      ff / fw: Telescope-style fuzzy file + live text search
#   git.zsh         git aliases, gitpush, gitreset, gitrinse...
#   ramcheck.zsh    ramcheck
# Prompt: Oh My Zsh's "ys" theme (set in omz.zsh).
# ==============================================================================

ZSH_CONFIG_DIR="$HOME/.config/zsh"

# On a reload (`resource`), start from a clean slate: a leftover alias with the
# same name as a function would otherwise break that function's definition.
# Oh My Zsh and the files below re-create every alias they need.
unalias -m '*'

# Tools that were removed (starship, autojump): on a reload, drop the hooks they
# left behind in an already-open terminal. Otherwise autojump's cd hook keeps
# calling the uninstalled `autojump` ("command not found" after every cd/z/j),
# and starship keeps drawing its prompt instead of "ys".
chpwd_functions=( ${chpwd_functions:#autojump_*} )
precmd_functions=( ${precmd_functions:#(starship|autojump)_*} )
preexec_functions=( ${preexec_functions:#(starship|autojump)_*} )
(( $+functions[autojump_chpwd] )) && unfunction autojump_chpwd
(( $+functions[j] )) && unfunction j                # autojump's `j`; tools.zsh maps j to zoxide
(( $+functions[gitdiffs] )) && unfunction gitdiffs  # removed (it needed Neovim)
[[ $PROMPT == *starship* ]] && PROMPT=''
[[ $RPROMPT == *starship* ]] && RPROMPT=''      # ys has no right prompt, so clear starship's
[[ $PROMPT2 == *starship* ]] && PROMPT2='%_> '
[[ ${widgets[zle-keymap-select]} == *starship* ]] && zle -D zle-keymap-select
unset STARSHIP_SHELL STARSHIP_SESSION_KEY STARSHIP_START_TIME STARSHIP_CMD_STATUS STARSHIP_PIPE_STATUS STARSHIP_DURATION

# Order matters: env -> path -> oh-my-zsh -> everything else.
for _zsh_file in env path omz history node tools colors aliases navigation files misc dev search git ramcheck; do
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
# Testing 123.
