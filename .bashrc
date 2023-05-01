eval "$(starship init bash)"
eval `ssh-agent -s`

# get colors on ls in emacs!

#---------------------------------------------------------------------------------------------------------------------------------------
#   1.  ENVIRONMENT SETUP
#---------------------------------------------------------------------------------------------------------------------------------------

# Set colors to variables
BLACK="\033[0;30m"
BLACKB="\033[1;30m"
RED="\033[0;31m"
REDB="\033[1;31m"
GREEN="\033[0;32m"
GREENB="\033[1;32m"
YELLOW="\033[0;33m"
YELLOWB="\033[1;33m"
BLUE="\033[0;34m"
BLUEB="\033[1;34m"
PURPLE="\033[0;35m"
PURPLEB="\033[1;35m"
CYAN="\033[0;36m"
CYANB="\033[1;36m"
WHITE="\033[0;37m"
WHITEB="\033[1;37m"
RESET="\033[0;0m"

# Modify the prompt - Spacegray
# export PS1=$CYAN'\u'$WHITE' at '$BLUE'\h'$WHITE' → '$PURPLE'[\w]\e[0m$(git_color)$(git_branch)\n'$WHITE'\$ '

# Set tab name to the current directory
# export PROMPT_COMMAND='echo -ne "\033]0;${PWD##*/}\007"'

# Add color to terminal
export CLICOLOR=1
export LSCOLORS=GxExBxBxFxegedabagacad

# Setup RBENV stuff
# export RBENV_ROOT=/usr/local/var/rbenv
# if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Set our Homebrew Cask application directory
# export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Print the date
date '+%H:%M:%S %p / %A / %B %-d, %Y'



#---------------------------------------------------------------------------------------------------------------------------------------
#   2.  MAKE TERMINAL BETTER
#---------------------------------------------------------------------------------------------------------------------------------------

# Editing common files
alias edithosts='atom /etc/hosts'                                               # Edit hosts file
alias editbash='code ~/.bashrc'                                                 # Edit bashrc
alias editzsh='code ~/.zshrc'                                                   # Edit zshrc
alias editsshconfig='code ~/.ssh/config'                                        # Edit ssh config file
alias editsharedbash='code ~/Dropbox/Preferences/home/.shared_bash_profile'     # Edit shared bash profile in Dropbox

# Navigation Shortcuts
alias x='exit'
alias ..='cl ..'
alias ...='cl ../../'
alias ....='cl ../../../'
alias .....='cl ../../../../'
alias ......='cl ../../../../'
alias .......='cl ../../../../../'
alias ........='cl ../../../../../../'
alias .........='cl ../../../../../../../'
alias home='clear && cl ~'

alias resource='source ~/.bashrc'
alias delete_node='delete_node_modules'
alias angular='cl D:laragon/www/Angular/'
alias ionic123='cl D:laragon/www/Ionic/'
alias react='cl D:laragon/www/ReactJS/'
alias next='cl D:laragon/www/NextJS/'
alias laravel123='cl D:laragon/www/Laravel/'
alias nest='cl D:laragon/www/NestJS/'


######### Start Angular #########
### HLBB Templates ###
alias ng_template_1='cl D:laragon/www/Angular/Angular-Tailwind-Templates/Angular-Tailwind-Template-1/'
alias ng_template_2='cl D:laragon/www/Angular/Angular-Tailwind-Templates/Angular-Tailwind-Template-2/'
alias ng_template_3='cl D:laragon/www/Angular/Angular-Tailwind-Templates/Angular-Tailwind-Template-3/'
alias ng_template_4='cl D:laragon/www/Angular/Angular-Tailwind-Templates/Angular-Tailwind-Template-4/'

### Angular Boilerplate ###
alias boilerplate_14='cl D:laragon/www/Angular/Angular-Tailwind-Templates/Angular-14-Tailwind-Boilerplate/'
alias boilerplate_15='cl D:laragon/www/Angular/Angular-Tailwind-Templates/Angular-15-Tailwind-Boilerplate/'

### Fuse-12 ###
alias fuse_12_demo='cl D:laragon/www/Angular/Fuse/Angular-12/Fuse-Angular-12-Demo/'
alias fuse_12_starter='cl D:laragon/www/Angular/Fuse/Angular-12/Fuse-Angular-12-Starter/'

### Fuse-13 ###
alias fuse_13_demo='cl D:laragon/www/Angular/Fuse/Angular-13/Fuse-Angular-13-Demo/'
alias fuse_13_skeleton='cl D:laragon/www/Angular/Fuse/Angular-13/Fuse-Angular-13-Skeleton/'
alias fuse_13_starter='cl D:laragon/www/Angular/Fuse/Angular-13/Fuse-Angular-13-Starter/'

### Fuse-14 ###
alias fuse_14='cl D:laragon/www/Angular/Fuse/Angular-14/Fuse-Angular-14/'
alias fuse_14_demo='cl D:laragon/www/Angular/Fuse/Angular-14/Fuse-Angular-14-Demo/'
alias fuse_14_starter='cl D:laragon/www/Angular/Fuse/Angular-14/Fuse-Angular-14-Starter/'

### Fuse-15 ###
alias fuse_15='cl D:laragon/www/Angular/Fuse/Angular-15/Fuse-Angular-15/'
alias fuse_15_demo='cl D:laragon/www/Angular/Fuse/Angular-15/Fuse-Angular-15-Demo/'
alias fuse_15_starter='cl D:laragon/www/Angular/Fuse/Angular-15/Fuse-Angular-15-Starter/'

### Landing Page ###
alias asc='cl D:laragon/www/Angular/ASC-Legal/'
alias selfown='cl D:laragon/www/Angular/Selfown-Angular14-TailwindCSS/'

### Envato Element Angular Landing Page ###
alias envato-ng='cl D:laragon/www/Angular/Envato-Element-Templates/'
# alias finsa1='cl D:laragon/www/Angular/Envato-Element-Templates/finsa-ng'
alias finsa='cl D:laragon/www/Angular/Envato-Element-Templates/Finsa/Angular-Template/'
alias apzie='cl D:laragon/www/Angular/Envato-Element-Templates/apzie-ng/'
alias dizo='cl D:laragon/www/Angular/Envato-Element-Templates/dizo-ng/'
alias ervy='cl D:laragon/www/Angular/Envato-Element-Templates/ervy-ng/'
alias ezlu='cl D:laragon/www/Angular/Envato-Element-Templates/ezlu-ng/'
alias kiaz='cl D:laragon/www/Angular/Envato-Element-Templates/kiaz-ng/'
alias levi='cl D:laragon/www/Angular/Envato-Element-Templates/levi-ng/'
alias lufz='cl D:laragon/www/Angular/Envato-Element-Templates/lufz-ng/'
alias peof='cl D:laragon/www/Angular/Envato-Element-Templates/peof-ng/'
alias pilar='cl D:laragon/www/Angular/Envato-Element-Templates/pilar-ng/'
alias ribo='cl D:laragon/www/Angular/Envato-Element-Templates/ribo-ng/'
######### End Angular #########

######### Start Ionic #########
alias ionic_boilerplate='cl D:laragon/www/Ionic/ionic-boilerplate/'
alias ionic_todolist='cl D:laragon/www/Ionic/ionic-to-do-list-training/'
######### End Ionic #########

######### Start NextJS #########
alias bishen-dev='cl D:laragon/www/NextJS/bishen-dev/'
alias bishen-dev-v2='cl D:laragon/www/NextJS/bishen-dev-v2/'
alias clonlee-tech='cl D:laragon/www/NextJS/clonlee-tech/'
alias avo='cl D:laragon/www/NextJS/avo/'
alias rustic='cl D:laragon/www/NextJS/rustic/'
alias vie='cl D:laragon/www/NextJS/vie-react-creative-portfolio/'


### NextJS Dashboard ###
alias next_template_1='cl D:laragon/www/NextJS/NextJS-Tailwind-Dashboard/'
### NextJS Dashboard ###

######### End NextJS #########

cl() { cd "$@" && ls -lah; }

alias cls='clear'
alias ll='ls -alh'                                                    # List files
alias llr='ls -alhr'                                                   # List files (reverse)
alias lls='ls -alhS'                                                   # List files by size
alias llsr='ls -alhSr'                                                 # List files by size (reverse)
alias lld='ls -alht'                                                   # List files by date
alias lldr='ls -alhtr'                                                 # List files by date (reverse)
alias lldc='ls -alhtU'                                                 # List files by date created
alias lldcr='ls -alhtUr'                                               # List files by date created (reverse)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion


#---------------------------------------------------------------------------------------------------------------------------------------
#   3.  FOLDER MANAGEMENT
#---------------------------------------------------------------------------------------------------------------------------------------

# Clear a directory
cleardir() {
    while true; do
        read -ep 'Completely clear current directory? [y/N] ' response
        case $response in
            [Yy]* )
                bash -c 'rm -rfv ./*'
                bash -c 'rm -rfv ./.*'
                break;;
            * )
                echo 'Skipped clearing the directory...'
                break;;
        esac
    done
}

# mktar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }    # Creates a *.tar.gz archive of a file or folder
# mkzip() { zip -r "${1%%/}.zip" "$1" ; }               # Create a *.zip archive of a file or folder


#---------------------------------------------------------------------------------------------------------------------------------------
#   4.  MISC ALIAS'
#---------------------------------------------------------------------------------------------------------------------------------------

# Homebrew
alias brewup='brew update && brew upgrade && brew cleanup'
alias brewup-cask='brew update && brew upgrade && brew cleanup && brew cask outdated | awk "{print $1}" | xargs brew cask reinstall && brew cask cleanup'

# Hyper
alias update-hyper-plugins='cd ~/.hyper_plugins && rm -rf node_modules && rm package-lock.json && npm install && cd -'

# browser-sync
alias bs='browser-sync'    # Browser Sync shorthand
bsdev() { browser-sync start --server --files '**/*.css, **/*.js, **/*.php, **/*.html, **/*.mustache, **/*.twig' --tunnel 'kjbrum'; }    # Start local project server
bsproxy() { browser-sync start --proxy "$1" --files '**/*.css, **/*.js, **/*.php, **/*.html, **/*.mustache, **/*.twig' --tunnel 'kjbrum'; }    # Proxy a local project

# Grunt
alias gw='grunt watch'    # Start the Grunt "watch" task
alias gbs='grunt bs'      # Start the Grunt "browser-sync" task

# Valet
alias v='valet'

# Copy local files to a remote server
dir-to-remote() { rsync -avz . $1; }

# 1Password
1pass() { eval $(op signin "$1"); }

# Trash
alias t='trash'

# New WordPress site
new-wp() {
    cp -r ~/projects/sf-wp-deploy ~/sites/"$@"
    cd ~/sites/"$@"
    . config/prepare.sh
}

# npm
alias ni='npm install'
alias nrs='npm run start'
alias nrd='npm run dev'
alias nrb='npm run build'

# yarn
alias ys='yarn start'
alias yd='yarn dev'
alias yb='yarn build'

# Homebrew
alias bci='brew cask install'
alias bcun='brew cask uninstall'
alias bcup='brew cask reinstall'

# Compass
alias cw='compass watch'

# Create a new Foundation for Emails project
alias ffe='foundation new --framework emails'

# Run last command with sudo
alias fuck='sudo $(fc -ln -1)'

# Switching shells
alias shell-to-zsh='chsh -s $(which zsh)'
alias shell-to-bash='chsh -s $(which bash)'

# Bundle shortcuts
alias bec='bundle exec cap'
alias becs='bundle exec cap staging'
alias becp='bundle exec cap production'


cap-staging() {
    while true; do
        read -ep 'Pull or push STAGING site? [pull/push] ' response
        case $response in
            pull )
                while true; do
                    read -ep 'Are you sure you want to PULL changes from STAGING? [y/N] ' yesno
                    case $yesno in
                        [Yy]* )
                            bash -c 'bundle exec cap staging db:pull && bundle exec cap staging uploads:pull'
                            break
                            ;;
                        * )
                            break
                            ;;
                    esac
                done
                break
                ;;
            push )
                while true; do
                    read -ep 'Are you sure you want to PUSH changes to STAGING? [y/N] ' yesno
                    case $yesno in
                        [Yy]* )
                            bash -c 'bundle exec cap staging deploy && bundle exec cap staging db:push && bundle exec cap staging uploads:push'
                            break
                            ;;
                        * )
                            break
                            ;;
                    esac
                done
                break
                ;;
        esac
    done
}

cap-production() {
    while true; do
        read -ep 'Pull or push PRODUCTION site? [pull/push] ' response
        case $response in
            pull )
                while true; do
                    read -ep 'Are you sure you want to PULL changes from PRODUCTION? [y/N] ' yesno
                    case $yesno in
                        [Yy]* )
                            bash -c 'bundle exec cap production db:pull && bundle exec cap production uploads:pull'
                            break
                            ;;
                        * )
                            break
                            ;;
                    esac
                done
                break
                ;;
            push )
                while true; do
                    read -ep 'Are you sure you want to PUSH changes to PRODUCTION? [y/N] ' yesno
                    case $yesno in
                        [Yy]* )
                            bash -c 'bundle exec cap production deploy && bundle exec cap production db:push && bundle exec cap production uploads:push'
                            break
                            ;;
                        * )
                            break
                            ;;
                    esac
                done
                break
                ;;
        esac
    done
}

# Start a web server to share the files in the current directory
startserver() {
    # PHP
    path="$1"
    if [ -z "$path" ]; then
        path="."
    fi
    open http://localhost:3000
    php -t $path -S localhost:3000
}

# Display the weather using wttr.in
weather() {
    location="$1"
    if [ -z "$location" ]; then
        location="dsm"
    fi

    curl http://wttr.in/$location?lang=en
}

# Download a website
dl-website() {
    polite=''

    if [[ $* == *--polite* ]]; then
        polite="--wait=2 --limit-rate=50K"
    fi

    wget --recursive --page-requisites --convert-links --user-agent="Mozilla" $polite "$1";
}


#---------------------------------------------------------------------------------------------------------------------------------------
#   5.  GIT SHORTCUTS
#---------------------------------------------------------------------------------------------------------------------------------------

alias config_HLBB='git config user.name "Bishen Patel" && git config user.email "tbishen@hlbb.hongleong.com.my" '
alias config_personal=' git config user.name "Bishen Patel" && git config user.email "patelzz007@gmail.com" '
alias init='git init'
alias gitstats='git-stats'
alias gits='git status -s'
alias gita='git add -A && git status -s'
alias gitcom='git commit -am'
alias gitacom='git add -A && git commit -am'
alias gitc='git checkout'
alias gitcm='git checkout main'
alias gitcd='git checkout develop'
alias gitcnd='git checkout new-develop'
alias gitcgh='git checkout gh-pages'
alias gitb='git branch'
alias gitcb='git checkout -b'
alias gitdb='git branch -d'
alias gitDb='git branch -D'
alias gitdr='git push origin --delete'
alias gitf='git fetch'
alias gitr='git rebase'
alias gitp='git push -u'
alias gitpl='git pull'
alias gfp='git fetch && git pull'
alias gitfr='git fetch && git rebase'
alias gitfrp='git fetch && git rebase && git push -u'
alias gitpo='git push -u origin'
alias gitpom='git push -u origin main'
alias gitphm='git push heroku master'
alias gitm='git merge'
alias gitmd='git merge development'
alias gitmm='git merge main'
alias gitcl='git clone'
alias gitclr='git clone --recursive'
alias gitamend='git commit --amend'
alias gitundo='git reset --soft HEAD~1'
alias gitm2gh='git checkout gh-pages && git merge master && git push -u && git checkout master'
alias gitrao='git remote add origin'
alias gitrso='git remote set-url origin'
alias gittrack='git update-index --no-assume-unchanged'
alias gituntrack='git update-index --assume-unchanged'
alias gitpls='git submodule foreach git pull origin master'
alias gitremoveremote='git rm -r --cached'
alias gitcount="git shortlog -sne"
alias gitlog="git log --oneline"
alias gitlog-full="git log --graph --abbrev-commit --decorate --all --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)'"
alias gitlog-changes="git log --oneline --decorate --stat --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(dim white) - %an%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n %C(white)%s%C(reset)'"
alias gp='gitpush'

delete_node_modules () {
    if [ -d node_modules ]; then
        echo -e "${REDB}Deleting Node Modules.${RESET}"
        rm -rf node_modules/
        echo -e "${REDB}Done deleting Node Modules.${RESET}"
    else
        echo -e "${CYANB}Node Modules not found.${RESET}"
    fi

    if [ -d .angular ]; then
        echo -e "${GREENB}Deleting .angular.${RESET}"
        rm -rf .angular
        echo -e "${GREENB}Done deleting .angular.${RESET}"
    else
        echo -e "${CYANB}.angular not found.${RESET}"
    fi

    if [ -d .next ]; then
        echo -e "${GREENB}Deleting .next.${RESET}"
        rm -rf .next
        echo -e "${GREENB}Done deleting .next.${RESET}"
    else
        echo -e "${CYANB}.next not found.${RESET}"
    fi

    if [ -f package-lock.json ]; then
        echo -e "${YELLOWB}Deleting package-lock.json.${RESET}"
        rm -rf package-lock.json
        echo -e "${YELLOWB}Done deleting package-lock.json.${RESET}"
    else
        echo -e "${CYANB}package-lock.json not found.${RESET}"
    fi

    if [ -f yarn.lock ]; then
        echo -e "${BLUEB}Deleting yarn.lock.${RESET}"
        rm -rf yarn.lock
        echo -e "${BLUEB}Done deleting yarn.lock.${RESET}"
    else
        echo -e "${CYANB}yarn.lock not found.${RESET}"
    fi
    
    if [ -f yarn-error.log ]; then
        echo -e "${PURPLEB}Deleting yarn-error.log.${RESET}"
        rm -rf yarn-error.log
        echo -e "${PURPLEB}Done deleting yarn-error.log.${RESET}"
    else
        echo -e "${CYANB}yarn-error.log not found.${RESET}"
    fi
}

# gitpush() {
#     git add .
#     git commit -m "$*"
#     if git rev-parse --git-dir >/dev/null 2>&1
#         then
#             echo -e "Branch Name :" \[$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')\]
#             echo -e "Pushing To ${BLUEB}$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')${NC} Branch"
#             git push -u origin $(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
#             echo -e "Successfully Pushed To ${BLUEB}$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')${NC} Branch"
#     fi
# }

gitpush () {
    git add .
    git commit -m "$*"
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3-)"
    [ -n "${branch}" ] && echo -e "This Is ${BLUEB}${branch}${RESET} Branch."
    echo -e "Pushing To ${BLUEB}${branch}${RESET} Branch."
    git push -u origin ${branch}
    echo -e "Successfully Pushed To ${BLUEB}${branch}${RESET} Branch."
    figlet '200 OK'
}

gitprompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3-)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo -e "This Is ${BLUEB}${branch}${RESET} Branch."
}

gitdbr() { git branch -d "$@" && git push origin --delete "$@"; }
gitupstream() { git branch --set-upstream-to="$@"; }
gitreset() {
    if [ -z "$1" ]; then
        while true; do
            read -ep 'Reset to HEAD? [y/N] ' response
            case $response in
                [Yy]* )
                    bash -c 'git reset --hard HEAD'
                    break;;
                * )
                    echo 'Skipped resetting to HEAD...'
                    break;;
            esac
        done
    else
        while true; do
            read -ep "Reset to $1? [y/N] " response
            case $response in
                [Yy]* )
                    bash -c "git reset --hard $1"
                    break;;
                * )
                    echo "Skipped resetting to $1..."
                    break;;
            esac
        done
    fi
}

gitrinse() {
    if [[ "$1" == "all" ]]; then
        while true; do
            read -ep "Are you sure you want to gitrinse this repo and it's submodules? [y/N] " response
            case $response in
                [Yy]* )
                    git clean -xfd;
                    git submodule foreach --recursive git clean -xfd;
                    git reset --hard;
                    git submodule foreach --recursive git reset --hard;
                    git submodule update --init --recursive;
                    break;;
                * )
                    echo "Skipped gitrinse..."
                    break;;
            esac
        done
    else
        while true; do
            read -ep "Are you sure you want to gitrinse this repo's submodules? [y/N] " response
            case $response in
                [Yy]* )
                    git submodule foreach --recursive git clean -xfd;
                    git submodule foreach --recursive git reset --hard;
                    git submodule update --init --recursive;
                    break;;
                * )
                    echo "Skipped gitrinse..."
                    break;;
            esac
        done
    fi

}

# Get Git branch of current directory
git_branch () {
    if git rev-parse --git-dir >/dev/null 2>&1
        # then echo -e "" git:\($(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')\)
        then echo -e "" \[$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')\]
    else
        echo ""
    fi
}

# Set a specific color for the status of the Git repo
git_color() {
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == *'Not a git repository'* ]]
        then echo "" # nothing
    else
        if [[ "$STATUS" != *'working tree clean'* ]]
            then echo -e '\033[0;31m' # red if need to commit
        else
            if [[ "$STATUS" == *'Your branch is ahead'* ]]
                then echo -e '\033[0;33m' # yellow if need to push
            else
                echo -e '\033[0;32m' # else green
            fi
        fi
    fi
}

# Shorten a Github URL with git.io (https://github.com/blog/985-git-io-github-url-shortener)
gitio() {
    # Check for a URL
    if [ -z "$1" ]; then
        echo "You need to supply a URL to shorten..."
        return
    fi

    # Check for a code
    if [ -z "$2" ]; then
        echo "You need to supply a name for your shortened URL..."
        return
    fi

    curl -i https://git.io -F "url=$1" -F "code=$2"
    printf "\n"
}

# Set a specific color for the status of the Git repo
git_color() {
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == *'Not a git repository'* ]]
        then echo "" # nothing
    else
        if [[ "$STATUS" != *'working tree clean'* ]]
            then echo -e '\033[0;31m' # red if need to commit
        else
            if [[ "$STATUS" == *'Your branch is ahead'* ]]
                then echo -e '\033[0;33m' # yellow if need to push
            else
                echo -e '\033[0;32m' # else green
            fi
        fi
    fi
}

# Shorten a Github URL with git.io (https://github.com/blog/985-git-io-github-url-shortener)
gitio() {
    # Check for a URL
    if [ -z "$1" ]; then
        echo "You need to supply a URL to shorten..."
        return
    fi

    # Check for a code
    if [ -z "$2" ]; then
        echo "You need to supply a name for your shortened URL..."
        return
    fi

    curl -i https://git.io -F "url=$1" -F "code=$2"
    printf "\n"
}

# Load Angular CLI autocompletion.
source <(ng completion script)

# unsetopt INTERACTIVE_COMMENTS
# unsetopt BAD_PATTERN