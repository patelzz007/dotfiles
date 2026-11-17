# ==============================================================================
# node.zsh: Node.js via fnm (Fast Node Manager).
#
#   - Switches Node automatically when you cd into a project that has a .nvmrc
#     or .node-version file (also found in parent folders).
#   - package.json `engines.node` is deliberately NOT used for switching: fnm
#     would pick the newest installed version matching ranges like ">=20", i.e.
#     Node 26, where your global tools (ng, pnpm, nest...) aren't installed.
#     For those projects use `fnm use <version>`, or add a .nvmrc.
#
#   fnm list | fnm install 26 | fnm use 26 | fnm default 24.22.1
# ==============================================================================

if (( $+commands[fnm] )); then
    eval "$(fnm env --use-on-cd --version-file-strategy=recursive --resolve-engines=false --shell zsh)"
fi

##
# Muscle-memory shim: translates common nvm commands to fnm.
# @param   $@  string  nvm-style command: use | install | uninstall | current |
#                      ls | ls-remote | alias default <version>
# @return  fnm's status, or 1 for commands without an fnm equivalent
##
nvm () {
    emulate -L zsh
    local -r cmd=$1
    (( $# )) && shift
    case $cmd in
        (ls|list)                         fnm list "$@" ;;
        (ls-remote)                       fnm list-remote "$@" ;;
        (use|install|uninstall|current)   fnm "$cmd" "$@" ;;
        (alias)
            if [[ $1 == default ]]; then
                shift
                fnm default "$@"
            else
                fnm alias "$@"
            fi ;;
        (*)
            print -u2 -- "nvm has been replaced by fnm. Try: fnm ${cmd:-help} $*"
            return 1 ;;
    esac
}
