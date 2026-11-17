# ==============================================================================
# dev.zsh: day-to-day dev-server and project helpers.
# (`mkcd <dir>`, make a folder and cd into it, comes with Oh My Zsh.)
# ==============================================================================

##
# Kill whatever is listening on the given TCP port(s), e.g. a stuck dev server.
# Asks politely first (SIGTERM), forces (SIGKILL) only if it's still alive.
# @param   $@  int  port numbers, e.g. `killport 3000 4200`
# @return  0 if every port ended up free, 1 otherwise
##
killport () {
    emulate -L zsh
    (( $# )) || { print -u2 -- 'Usage: killport <port>...'; return 1 }
    local port pid
    local -a pids
    local -i failed=0

    for port in "$@"; do
        if [[ $port != <1-65535> ]]; then
            print -u2 -- "killport: '$port' is not a port number"
            failed=1
            continue
        fi
        pids=( ${(f)"$(lsof -nP -t -iTCP:$port -sTCP:LISTEN 2>/dev/null)"} )
        if (( ! $#pids )); then
            print -- "Nothing is listening on :$port"
            continue
        fi
        for pid in $pids; do
            print -- "Stopping ${CLR[yellow_b]}${$(ps -p $pid -o comm= 2>/dev/null):t}${CLR[reset]} (pid $pid) on :$port"
            kill $pid 2>/dev/null
        done
        sleep 0.5
        for pid in $pids; do
            if kill -0 $pid 2>/dev/null; then
                print -- "  pid $pid is still running, forcing it."
                kill -9 $pid 2>/dev/null || failed=1
            fi
        done
    done
    return $failed
}

##
# List listening TCP ports with the process and the folder it was started from.
# @stdout  table: PORT  PID  PROCESS  FOLDER
##
ports () {
    emulate -L zsh
    local line pid cmd addr port cwd
    local -A seen
    local -a rows

    for line in ${(f)"$(lsof -nP -iTCP -sTCP:LISTEN 2>/dev/null | awk 'NR > 1 { print $2, $1, $9 }')"}; do
        read -r pid cmd addr <<< "$line"
        port=${addr##*:}
        [[ -n ${seen[$pid:$port]} ]] && continue        # same process on IPv4 + IPv6
        seen[$pid:$port]=1
        cwd=$(lsof -a -p $pid -d cwd -Fn 2>/dev/null | sed -n 's/^n//p')
        rows+=( "$(printf '%-6s %-7s %-20s %s' $port $pid ${cmd//\\x20/ } ${cwd/#$HOME/~})" )
    done

    if (( ! $#rows )); then
        print -- 'Nothing is listening.'
        return 0
    fi
    print -- "${CLR[dim]}$(printf '%-6s %-7s %-20s %s' PORT PID PROCESS FOLDER)${CLR[reset]}"
    print -rl -- ${(on)rows}
}

##
# Pick a git branch with fzf (local + remote, most recently used first) and switch to it.
# Replaces Oh My Zsh's `gco` alias; `gco <branch>` still switches directly when
# the name matches exactly.
# @param   $1  string  optional branch name or search text
# @return  0 on success, 1 if not a repo or nothing chosen
##
unalias gco 2>/dev/null
function gco {
    emulate -L zsh
    git rev-parse --is-inside-work-tree &>/dev/null || { print -u2 -- 'gco: not a git repository'; return 1 }

    if [[ -n $1 ]] && git show-ref --verify --quiet "refs/heads/$1"; then
        git switch "$1"
        return
    fi

    local branch
    branch=$(git for-each-ref --sort=-committerdate --format='%(refname:short)' refs/heads refs/remotes \
        | grep -v -e '/HEAD$' -e '^origin$' \
        | fzf --query="$1" --select-1 --exit-0 --prompt='branch> ' \
              --preview 'git log --oneline --graph --color=always -20 {}') || return 1

    if git show-ref --verify --quiet "refs/remotes/$branch"; then
        git switch "${branch#*/}"          # remote branch: creates/updates a local tracking branch
    else
        git switch "$branch"
    fi
}

##
# Detect the project's package manager from the nearest lockfile (searching upward,
# so it works inside monorepo packages).
# @stdout  pnpm | bun | yarn | npm
##
_detect_pm () {
    emulate -L zsh
    local dir=$PWD
    while true; do
        if   [[ -e $dir/pnpm-lock.yaml ]];                  then print pnpm; return
        elif [[ -e $dir/bun.lock || -e $dir/bun.lockb ]];   then print bun;  return
        elif [[ -e $dir/yarn.lock ]];                       then print yarn; return
        elif [[ -e $dir/package-lock.json ]];               then print npm;  return
        fi
        [[ $dir == / ]] && break
        dir=${dir:h}
    done
    print npm
}

##
# Run a package.json script with the right package manager.
# No argument: pick the script with fzf (its command is shown as a preview).
# @param   $1  string  script name (or search text); extra args are passed to the script
# @return  the script's exit status, 1 if there's nothing to run
##
nr () {
    emulate -L zsh
    [[ -r package.json ]] || { print -u2 -- 'nr: no package.json in this folder'; return 1 }

    local -r pm=$(_detect_pm)
    local -a scripts=( ${(f)"$(node -e '
        const s = require("./package.json").scripts || {};
        for (const [k, v] of Object.entries(s)) console.log(k + "\t" + v);
    ')"} )
    (( $#scripts )) || { print -u2 -- 'nr: package.json has no scripts'; return 1 }

    local choice
    local -a names=( ${scripts%%$'\t'*} )
    if [[ -n $1 ]] && (( ${names[(Ie)$1]} )); then
        choice=$1
    else
        choice=$(print -rl -- $scripts \
            | fzf --query="$1" --select-1 --exit-0 --delimiter=$'\t' --with-nth=1 \
                  --preview='echo {2}' --preview-window=down,3,wrap --prompt="$pm run> ") || return 1
        choice=${choice%%$'\t'*}
    fi

    print -- "${CLR[dim]}\$ $pm run $choice ${*[2,-1]}${CLR[reset]}"
    $pm run "$choice" "${@[2,-1]}"
}
