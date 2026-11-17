# ==============================================================================
# node.zsh: Node.js via nvm, lazy-loaded.
#
# Loading nvm.sh costs ~0.5s per new shell, so instead:
#   1. the default Node version's bin dir is put straight onto PATH, so `node`,
#      `npm`, `pnpm`, `ng` and other global tools work instantly;
#   2. nvm itself is only loaded the first time you actually type `nvm`.
# ==============================================================================

##
# Resolve nvm's "default" alias to an installed version's bin directory.
# @stdout  absolute path, e.g. ~/.nvm/versions/node/v24.22.1/bin
# @return  0 if found, 1 otherwise
##
_nvm_default_bin () {
    emulate -L zsh
    local -r alias_file="$NVM_DIR/alias/default"
    [[ -r $alias_file ]] || return 1

    local -r wanted="${$(<$alias_file)#v}"
    # Exact version first (24.22.1), else newest install matching a prefix (24 -> v24.x.y).
    local -a candidates=( $NVM_DIR/versions/node/v${wanted}(N-/) )
    (( $#candidates )) || candidates=( $NVM_DIR/versions/node/v${wanted}.*(N-/nOn) )
    (( $#candidates )) || return 1

    print -r -- "$candidates[1]/bin"
}

##
# Load the real nvm (and its completions).
# @return  status of sourcing nvm.sh
##
_nvm_load () {
    [[ -s $NVM_DIR/nvm.sh ]] || return 1
    source "$NVM_DIR/nvm.sh"
    [[ -r $NVM_DIR/bash_completion ]] && source "$NVM_DIR/bash_completion"
    return 0
}

() {
    local bin
    if bin=$(_nvm_default_bin); then
        path=( $bin $path )
        # Stand-in for `nvm`: replaces itself with the real one on first use.
        nvm () {
            unfunction nvm
            _nvm_load && nvm "$@"
        }
    else
        # Default alias is something like "lts/*" that we can't resolve cheaply: load normally.
        _nvm_load
    fi
}
