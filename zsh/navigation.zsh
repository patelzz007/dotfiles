# ==============================================================================
# navigation.zsh: moving around: cd+list helpers, `up`, folder shortcuts and
# the `p` project jumper (replaces the old per-project aliases).
# ==============================================================================

##
# cd into a directory, then list it (short / long form).
# @param   $@  string  arguments for cd
# @return  0 on success, non-zero if cd failed
##
cs () { cd "$@" && ls }
cl () { cd "$@" && eza -la --header --git --icons --group-directories-first }

##
# Go up N directories and list.
# @param   $1  int  levels to go up (default 1)
# @return  0 on success, 1 on bad input
##
up () {
    emulate -L zsh
    local -i levels=${1:-1}
    if (( levels < 1 )); then
        print -u2 -- 'Usage: up [levels]   (levels must be 1 or more)'
        return 1
    fi
    cl "${(pl:levels*3::../:)}"
}

alias ..='up 1'
alias ...='up 2'
alias ....='up 3'
alias .....='up 4'
alias ......='up 5'
alias .......='up 6'
alias ........='up 7'

# ---- Fixed folders -----------------------------------------------------------
alias home='clear && cl ~'
alias desktop='cl ~/Desktop'
alias downloads='clear && cl ~/Downloads'
alias angular='cl ~/Desktop/Bishen/Angular'
alias laravel123='cl ~/Desktop/Bishen/laravel'
alias next='cl ~/Desktop/Bishen/NextJS'

# ---- Project jumper ----------------------------------------------------------
# Folders searched by `p`. Add more roots here if you keep projects elsewhere.
typeset -ga PROJECT_ROOTS=( $HOME/Desktop/Bishen )

##
# List candidate project directories: everything 1-2 levels under each root
# (skipping node_modules and hidden folders).
# @stdout  one absolute path per line
# @return  0
##
_project_dirs () {
    emulate -L zsh
    setopt extended_glob
    local root
    for root in $PROJECT_ROOTS; do
        print -rl -- $root/*(N-/) $root/*/^node_modules(N-/)
    done
}

##
# Jump to a project by (partial, case-insensitive) name, e.g. `p rewardhub`.
# A single match jumps straight there; otherwise an fzf picker opens.
# @param   $1  string  optional search text
# @return  0 on success, 1 if nothing was chosen
##
p () {
    emulate -L zsh
    setopt extended_glob
    local -a dirs=( ${(f)"$(_project_dirs)"} ) matches

    if [[ -n $1 ]]; then
        matches=( ${(M)dirs:#(#i)*/${(b)1}} )                     # exact folder name
        (( $#matches == 1 )) || matches=( ${(M)dirs:#(#i)*/[^/]#${(b)1}[^/]#} )  # partial name
    fi

    if (( $#matches == 1 )); then
        cl "$matches[1]"
        return
    fi

    if (( ! $+commands[fzf] )); then
        print -u2 -- "p: no unique match for '$1'. Candidates:"
        print -rl -- ${${matches:-$dirs}/#$HOME/\~} >&2
        return 1
    fi

    local choice
    choice=$(print -rl -- ${${matches:-$dirs}/#$HOME/\~} \
        | fzf --query="$1" --select-1 --exit-0 --height=40% --reverse --prompt='project> ') \
        || return 1
    cl "${choice/#\~/$HOME}"
}

# Tab completion for `p`: offer project folder names.
_p () { compadd -- ${${(f)"$(_project_dirs)"}:t} }
(( $+functions[compdef] )) && compdef _p p
