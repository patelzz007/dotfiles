# ==============================================================================
# git.zsh: git aliases and helpers.
# `git_main_branch` comes from oh-my-zsh's git plugin and returns main/master,
# whichever the repo uses, so these work in both kinds of repo.
# ==============================================================================

# ---- Identity ----------------------------------------------------------------
alias config_HLBB='git config user.name "Bishen Patel" && git config user.email "tbishen@hlbb.hongleong.com.my"'
alias config_personal='git config user.name "Bishen Patel" && git config user.email "patelzz007@gmail.com"'
alias init='git init && git config user.name "Bishen Patel" && git config user.email "patelzz007@gmail.com"'

# ---- Status / staging / committing -------------------------------------------
alias gits='git status -s'
alias gita='git add -A && git status -s'
alias gitcom='git commit -am'
alias gitacom='git add -A && git commit -m'
alias gitamend='git commit --amend'
alias gitundo='git reset --soft HEAD~1'

# ---- Branches ----------------------------------------------------------------
alias gitc='git checkout'
alias gitcm='git checkout "$(git_main_branch)"'
alias gitcd='git checkout development'
alias gitcgh='git checkout gh-pages'
alias gitb='git branch'
alias gitcb='git checkout -b'
alias gitdb='git branch -d'
alias gitDb='git branch -D'
alias gitdr='git push origin --delete'

# ---- Sync --------------------------------------------------------------------
alias gitf='git fetch'
alias gitr='git rebase'
alias gitp='git push -u'
alias gitpl='git pull'
alias gfp='git fetch && git pull'
alias gitfr='git fetch && git rebase'
alias gitfrp='git fetch && git rebase && git push -u'
alias gitpo='git push -u origin'
alias gitpom='git push -u origin "$(git_main_branch)"'
alias gitphm='git push heroku "$(git_main_branch)"'
alias gp='gitpush'

# ---- Merging -----------------------------------------------------------------
alias gitm='git merge'
alias gitmd='git merge development'
alias gitmm='git merge "$(git_main_branch)"'
alias gitm2gh='git checkout gh-pages && git merge "$(git_main_branch)" && git push -u && git checkout "$(git_main_branch)"'

# ---- Remotes / cloning / submodules ------------------------------------------
alias gitcl='git clone'
alias gitclr='git clone --recursive'
alias gitrao='git remote add origin'
alias gitrso='git remote set-url origin'
alias gitpls='git submodule update --remote --merge'   # Pull each submodule's tracked branch

# ---- Tracking ----------------------------------------------------------------
alias gittrack='git update-index --no-assume-unchanged'
alias gituntrack='git update-index --assume-unchanged'
alias gitrmcached='git rm -r --cached'                  # Stop tracking a path but keep the file

# ---- Logs --------------------------------------------------------------------
alias gitcount='git shortlog -sne'
alias gitlog='git log --oneline'
alias gitdiffs="git -c delta.side-by-side=true -c delta.line-numbers-right-format='│{np:>4} ' diff"   # GitHub-style split diff
alias gitlog-full="git log --graph --abbrev-commit --decorate --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)'"
alias gitlog-changes="git log --oneline --decorate --stat --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)'"


# ==============================================================================
# gitpush
# ==============================================================================

##
# Print a big coloured banner (figlet, or plain text if figlet is missing).
# @param   $1  string  ANSI colour code, e.g. 31 (red) / 32 (green)
# @param   $2  string  banner text
# @stdout  the banner
##
_gitpush_banner () {
    print -n -- "\e[${1}m"
    if (( $+commands[figlet] )); then
        figlet "$2"
    else
        print -r -- "===== $2 ====="
    fi
    print -n -- "\e[0m"
}

##
# Show the FAILED banner, then the reason and git's own output underneath.
# @param   $1  string  human-readable reason
# @param   $2  string  captured git output (optional)
# @stderr  reason + git output
# @return  1, always
##
_gitpush_fail () {
    _gitpush_banner 31 'FAILED'
    print -u2 -- "${CLR[red_b]}Reason:${CLR[reset]} $1"
    if [[ -n $2 ]]; then
        print -u2 -- "${CLR[dim]}---------- git output ----------${CLR[reset]}"
        print -u2 -r -- "$2"
    fi
    return 1
}

##
# Stage everything, commit, and push the current branch to origin.
# @param   $@  string  commit message
# @stdout  progress + "200 OK" banner on success
# @stderr  "FAILED" banner + reason on failure
# @return  0 on success, 1 on any failure
##
gitpush () {
    emulate -L zsh
    local -r msg="$*"
    local branch out reason

    # ---- Pre-flight checks -------------------------------------------------
    if [[ -z ${msg//[[:space:]]/} ]]; then
        _gitpush_fail 'No commit message given. Usage: gitpush <message>'
        return 1
    fi
    if ! git rev-parse --is-inside-work-tree &>/dev/null; then
        _gitpush_fail "Not inside a git repository ($PWD)."
        return 1
    fi
    branch=$(git symbolic-ref --short -q HEAD)
    if [[ -z $branch ]]; then
        _gitpush_fail "Detached HEAD: you're not on a branch. Run 'git switch <branch>' first."
        return 1
    fi
    if ! git remote get-url origin &>/dev/null; then
        _gitpush_fail "No remote named 'origin' is configured. Add one with 'git remote add origin <url>'."
        return 1
    fi

    print -- "On ${CLR[blue_b]}${branch}${CLR[reset]} branch."

    # ---- Stage -------------------------------------------------------------
    if ! out=$(git add -A 2>&1); then
        _gitpush_fail 'git add failed.' "$out"
        return 1
    fi

    # ---- Commit (skipped if there's nothing new) ---------------------------
    if git diff --cached --quiet; then
        print -- 'Nothing new to commit; pushing existing commits.'
    else
        if ! out=$(git commit -m "$msg" 2>&1); then
            _gitpush_fail 'git commit failed (a pre-commit hook may have rejected it). Your changes are still staged.' "$out"
            return 1
        fi
        print -r -- "$out"
    fi

    # ---- Push --------------------------------------------------------------
    print -- "Pushing to ${CLR[blue_b]}origin/${branch}${CLR[reset]}..."
    if ! out=$(git push -u origin "$branch" 2>&1); then
        reason="git push to origin/$branch failed."
        case $out in
            (*hook\ declined*|*pre-push*)
                reason+=" A git hook rejected the push." ;;
            (*non-fast-forward*|*fetch\ first*|*rejected*)
                reason+=" The remote has commits you don't have. Run 'git pull --rebase', then gitpush again." ;;
            (*Permission\ denied*|*Authentication\ failed*|*could\ not\ read\ Username*|*403*)
                reason+=" Authentication failed. Check your SSH key or credentials." ;;
            (*Could\ not\ resolve\ host*|*timed\ out*|*Connection\ refused*|*unable\ to\ access*)
                reason+=" Could not reach the remote. Check your network connection." ;;
        esac
        reason+=" Your commit is saved locally."
        _gitpush_fail "$reason" "$out"
        return 1
    fi
    print -r -- "$out"

    print -- "Successfully pushed to ${CLR[blue_b]}${branch}${CLR[reset]} branch."
    _gitpush_banner 32 '200 OK'
}


# ==============================================================================
# Other helpers
# ==============================================================================

##
# Delete a branch locally and on origin.
# @param   $@  string  branch name(s)
##
gitdbr () {
    (( $# )) || { print -u2 -- 'Usage: gitdbr <branch>...'; return 1 }
    git branch -d "$@" && git push origin --delete "$@"
}

##
# Set the upstream of the current branch.
# @param   $1  string  e.g. origin/main
##
gitupstream () {
    [[ -n $1 ]] || { print -u2 -- 'Usage: gitupstream <remote>/<branch>'; return 1 }
    git branch --set-upstream-to="$1"
}

##
# Hard-reset to a commit after confirmation. Uncommitted changes are lost.
# @param   $1  string  commit/branch/tag (default: HEAD)
# @return  0 on success, 1 if invalid or declined
##
gitreset () {
    emulate -L zsh
    local -r target="${1:-HEAD}"
    if ! git rev-parse --verify --quiet "${target}^{commit}" &>/dev/null; then
        print -u2 -- "gitreset: '$target' is not a valid commit."
        return 1
    fi
    if ! read -q "?Hard reset to ${target}? Uncommitted changes will be lost. [y/N] "; then
        print -- "\nSkipped resetting to ${target}."
        return 1
    fi
    print
    git reset --hard "$target" --
}

##
# Wipe untracked files and reset submodules (and, with `all`, the repo itself).
# @param   $1  string  "all" to include the main repo; omit for submodules only
# @return  0 on success, 1 if declined, otherwise the failing git command's status
##
gitrinse () {
    emulate -L zsh
    local scope="this repo's submodules"
    [[ $1 == all ]] && scope="this repo and its submodules"

    if ! read -q "?Are you sure you want to gitrinse ${scope}? Untracked files will be deleted. [y/N] "; then
        print -- '\nSkipped gitrinse.'
        return 1
    fi
    print

    if [[ $1 == all ]]; then
        git clean -xfd && git reset --hard || return
    fi
    git submodule foreach --recursive git clean -xfd \
        && git submodule foreach --recursive git reset --hard \
        && git submodule update --init --recursive
}
