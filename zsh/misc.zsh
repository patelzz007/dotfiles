# ==============================================================================
# misc.zsh: assorted utilities (local server, weather, downloads, deploys).
# ==============================================================================

##
# Serve a folder with PHP's built-in server and open it in the browser.
# @param   $1  string  folder to serve (default: .)
# @param   $2  int     port (default: 3000)
# @return  1 if the folder or php is missing
##
startserver () {
    emulate -L zsh
    local -r dir="${1:-.}"
    local -ri port=${2:-3000}
    [[ -d $dir ]] || { print -u2 -- "startserver: no such folder: $dir"; return 1 }
    (( $+commands[php] )) || { print -u2 -- 'startserver: php is not installed'; return 1 }

    ( sleep 1; open "http://localhost:${port}" ) &!
    php -S "localhost:${port}" -t "$dir"
}

##
# Show the weather from wttr.in.
# @param   $@  string  place, e.g. `weather kuala lumpur` (omit to detect from your IP)
##
weather () {
    emulate -L zsh
    local -r location="${(j:+:)@}"
    curl -fsS "https://wttr.in/${location}?lang=en"
}

##
# Download a website for offline viewing.
# @param   --polite      optional: wait 2s between requests, cap speed at 50KB/s
# @param   $1  string    URL
# @return  1 on bad usage or if wget is missing
##
dl-website () {
    emulate -L zsh
    local -a opts=( --recursive --page-requisites --convert-links --user-agent=Mozilla )
    if [[ $1 == --polite ]]; then
        opts+=( --wait=2 --limit-rate=50K )
        shift
    fi
    [[ -n $1 ]] || { print -u2 -- 'Usage: dl-website [--polite] <url>'; return 1 }
    (( $+commands[wget] )) || { print -u2 -- "dl-website: wget isn't installed. Run: brew install wget"; return 1 }
    wget $opts "$1"
}

##
# Re-run the previous command with sudo (shows it first).
# @return  status of the re-run command, 1 if there's no previous command
##
function fuck {
    emulate -L zsh
    zmodload -F zsh/parameter p:history
    local -r last="${history[$(( HISTCMD - 1 ))]}"
    [[ -n $last ]] || { print -u2 -- 'fuck: no previous command found'; return 1 }
    print -r -- "${CLR[yellow_b]}sudo ${last}${CLR[reset]}"
    eval "sudo ${last}"
}

##
# Copy the current folder to a remote destination with rsync.
# @param   $1  string  destination, e.g. user@host:/path
##
dir-to-remote () {
    [[ -n $1 ]] || { print -u2 -- 'Usage: dir-to-remote <user@host:/path>'; return 1 }
    rsync -avz . "$1"
}

##
# Pull from or push to a Capistrano stage, after confirmation.
# @param   $1  string  stage: staging | production
# @return  0 on success, 1 if cancelled, otherwise the failing cap command's status
##
_cap_sync () {
    emulate -L zsh
    local -r stage=$1 label=${1:u}
    local action

    while true; do
        read "action?Pull or push ${label} site? [pull/push] " || return 1
        [[ $action == (pull|push) ]] && break
        print -u2 -- "Please type 'pull' or 'push' (Ctrl-C to cancel)."
    done

    local -r direction=$([[ $action == pull ]] && print -n from || print -n to)
    if ! read -q "?Are you sure you want to ${action:u} changes ${direction} ${label}? [y/N] "; then
        print -- '\nCancelled.'
        return 1
    fi
    print

    if [[ $action == pull ]]; then
        bundle exec cap "$stage" db:pull && bundle exec cap "$stage" uploads:pull
    else
        bundle exec cap "$stage" deploy \
            && bundle exec cap "$stage" db:push \
            && bundle exec cap "$stage" uploads:push
    fi
}
cap-staging ()    { _cap_sync staging }
cap-production () { _cap_sync production }
