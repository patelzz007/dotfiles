# ==============================================================================
# files.zsh: file, folder and history helpers.
# Anything destructive moves items to the macOS Trash instead of deleting
# permanently, and asks first.
# ==============================================================================

##
# Search the FULL shell history (zsh's `history` alone only shows the last 16).
# @param   $1  string  text to search for (case-insensitive); omit to show all
# @stdout  matching history lines
##
h () {
    if [[ -n $1 ]]; then
        fc -l 1 | grep -i -- "$1"
    else
        fc -l 1
    fi
}

##
# Open a bash shell as another user.
# @param   $1  string  username
# @return  1 if no user given
##
bash-as () {
    [[ -n $1 ]] || { print -u2 -- 'Usage: bash-as <user>'; return 1 }
    sudo -u "$1" /bin/bash
}

##
# Disk usage of the given items (default: everything here, incl. hidden), largest first.
# @param   $@  string  files/folders (optional)
##
disk-usage () {
    emulate -L zsh
    (( $# )) || set -- *(DN)
    (( $# )) || return 0
    du -hs -- "$@" | sort -hr
}

##
# Compare the file listings of two directories.
# @param   $1  string  first directory
# @param   $2  string  second directory
##
dirdiff () {
    [[ -d $1 && -d $2 ]] || { print -u2 -- 'Usage: dirdiff <dir1> <dir2>'; return 1 }
    diff -u <(ls -- "$1" | sort) <(ls -- "$2" | sort)
}

##
# Archive a file or folder as <name>.tar.gz / <name>.zip.
# @param   $1  string  file or folder
##
mktar () { tar cvzf "${1%%/}.tar.gz" "${1%%/}/" }
mkzip () { zip -r "${1%%/}.zip" "$1" }

##
# Move EVERYTHING in the current directory (including hidden files) to the Trash.
# Refuses to run in / or your home folder.
# @return  0 on success/empty dir, 1 if refused or declined
##
cleardir () {
    emulate -L zsh
    local -r dir=$PWD
    if [[ $dir == / || $dir == $HOME ]]; then
        print -u2 -- "cleardir: refusing to clear $dir"
        return 1
    fi

    local -a items=( *(DN) )
    if (( ! $#items )); then
        print -- 'Directory is already empty.'
        return 0
    fi

    print -- "This moves ${#items} item(s) in ${CLR[red_b]}${dir}${CLR[reset]} to the Trash."
    if ! read -q "?Continue? [y/N] "; then
        print -- '\nSkipped clearing the directory.'
        return 1
    fi
    print
    trash ${items/#/./}
}

##
# Clear JS build artefacts and lockfiles from the current project (moved to Trash).
# @return  0 on success, non-zero if trash failed
##
function delete_node {
    emulate -L zsh
    local -ra targets=(
        node_modules .angular .next
        package-lock.json yarn.lock pnpm-lock.yaml bun.lock bun.lockb
        yarn-error.log
    )
    local -a found=()
    local item

    for item in $targets; do
        if [[ -e $item ]]; then
            found+=( $item )
            print -- "${CLR[yellow_b]}Trashing ${item}${CLR[reset]}"
        else
            print -- "${CLR[dim]}${item} not found${CLR[reset]}"
        fi
    done

    (( $#found )) || return 0
    trash ${found/#/./} && print -- "${CLR[green_b]}Done.${CLR[reset]}"
}
alias delete_node_queries='delete_node'

##
# Copy an SSH public key to the clipboard.
# @param   $1  string  key name without .pub (default: id_ed25519). Tab-completes.
# @return  1 if the key doesn't exist
##
getsshkey () {
    emulate -L zsh
    local -r key="$HOME/.ssh/${1:-id_ed25519}.pub"
    if [[ ! -r $key ]]; then
        local -a available=( $HOME/.ssh/*.pub(N:t:r) )
        print -u2 -- "getsshkey: $key not found. Available: ${(j:, :)available}"
        return 1
    fi
    pbcopy < "$key" && print -- "Copied ${key/#$HOME/~} to the clipboard."
}
_getsshkey () { compadd -- $HOME/.ssh/*.pub(N:t:r) }
(( $+functions[compdef] )) && compdef _getsshkey getsshkey
