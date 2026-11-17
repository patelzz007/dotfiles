# ==============================================================================
# node.zsh: Node.js via fnm (Fast Node Manager).
#
#   - The default Node is the latest LTS. Nothing is hardcoded: run `node-lts`
#     whenever a new LTS comes out (install.sh does the same on a new Mac).
#   - Switches Node automatically when you cd into a project that has a .nvmrc
#     or .node-version file (also found in parent folders).
#   - package.json `engines.node` is deliberately NOT used for switching: fnm
#     would pick the newest installed version matching ranges like ">=20",
#     which may not be the LTS your global tools are installed on.
#     For those projects use `fnm use <version>`, or add a .nvmrc.
#
#   fnm list | fnm install 22 | fnm use 22 | node-lts
# ==============================================================================

if (( $+commands[fnm] )); then
    eval "$(fnm env --use-on-cd --version-file-strategy=recursive --resolve-engines=false --shell zsh)"
fi

##
# List the global npm packages installed on a Node version, skipping the ones
# that ship with Node (npm, corepack) and local `npm link`s.
# @param   $1  string  Node version, e.g. v24.22.1
# @stdout  one package name per line
##
_npm_globals () {
    fnm exec --using="$1" npm ls -g --depth=0 --json 2>/dev/null \
        | fnm exec --using="$1" node -e '
            const deps = JSON.parse(require("fs").readFileSync(0, "utf8")).dependencies || {};
            for (const [name, info] of Object.entries(deps)) {
                if (["npm", "corepack"].includes(name)) continue;
                if (!info.version || String(info.resolved || "").startsWith("file:")) continue;
                console.log(name);
            }'
}

##
# Install the latest Node LTS, make it the default, and reinstall your global
# npm packages (latest versions) on it from the previous default.
# Safe to run any time; does nothing heavy if you're already on the latest LTS.
# @return  0 on success, 1 if the install or package migration failed
##
node-lts () {
    emulate -L zsh
    local -r old=$(fnm default 2>/dev/null)

    print -- "${CLR[blue_b]}Checking for the latest Node LTS...${CLR[reset]}"
    fnm install --lts || return 1
    local -r new=$(fnm exec --using=lts-latest node -v) || return 1

    if [[ $old == $new ]]; then
        print -- "Already on the latest LTS: ${CLR[green_b]}${new}${CLR[reset]}"
        return 0
    fi

    fnm default "$new" || return 1
    print -- "Default Node: ${old:-none} -> ${CLR[green_b]}${new}${CLR[reset]}"

    if [[ -n $old ]]; then
        local -a pkgs=( ${(f)"$(_npm_globals "$old")"} )
        if (( $#pkgs )); then
            print -- "Reinstalling global packages on ${new}: ${(j:, :)pkgs}"
            fnm exec --using="$new" npm install -g --no-fund --no-audit \
                --allow-scripts=pnpm,yarn,esbuild $pkgs || return 1
        fi
    fi

    fnm use "$new" >/dev/null
    print -- "${CLR[green_b]}Done.${CLR[reset]} Old versions stay installed; remove one with: fnm uninstall <version>"
}

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
