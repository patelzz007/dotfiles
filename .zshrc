eval `ssh-agent -s`

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/opt/homebrew/bin:$PATH"

# Composer
export PATH=$PATH:$HOME/.composer/vendor/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# get colors on ls in emacs!

#---------------------------------------------------------------------------------------------------------------------------------------
#   1.  ENVIRONMENT SETUP
#---------------------------------------------------------------------------------------------------------------------------------------

# Set colors to variables
NC='\033[0m'                    # No Color
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

# Misc Commands
alias resource='source ~/.zshrc'                                                # Source zshrc
alias ls='ls --color=auto'                                                      # Color ls
alias ll='ls -alh'                                                              # List files
alias llr='ls -alhr'                                                            # List files (reverse)
alias lls='ls -alhS'                                                            # List files by size
alias llsr='ls -alhSr'                                                          # List files by size (reverse)
alias lld='ls -alht'                                                            # List files by date
alias lldr='ls -alhtr'                                                          # List files by date (reverse)
alias lldc='ls -alhtU'                                                          # List files by date created
alias lldcr='ls -alhtUr'                                                        # List files by date created (reverse)
h() { history | grep "$1"; }                                                    # Shorthand for `history` with added grepping
alias perm="stat -f '%Lp'"                                                      # View the permissions of a file/dir as a number
alias mkdir='mkdir -pv'                                                         # Make parent directories if needed
alias tree="find . -print | sed -e 's;[^/]*/;|_;g;s;_|; |;g'"             # List the file structure of the current directory
alias getsshkey="pbcopy < ~/.ssh/id_rsa.pub"                                    # Copy SSH key to the keyboard
bash-as() { sudo -u $1 /bin/bash; }                                             # Run a bash shell as another user
disk-usage() { du -hs "$@" | sort -nr; }                                        # List disk usage of all the files in a directory (use -hr to sort on server)
dirdiff() { diff -u <( ls "$1" | sort)  <( ls "$2" | sort ); }                  # Compare the contents of 2 directories


# Editing common files
alias edithosts='atom /etc/hosts'                                               # Edit hosts file
alias editbash='code ~/.bashrc'                                                 # Edit bashrc
alias editzsh='code ~/.zshrc'                                                   # Edit zshrc
alias editsshconfig='code ~/.ssh/config'                                        # Edit ssh config file
alias editsharedbash='code ~/Dropbox/Preferences/home/.shared_bash_profile'     # Edit shared bash profile in Dropbox

# Navigation Shortcuts
alias cls="clear"
alias x="exit"
alias ..='cl ../'
alias ...='cl ../../'
alias ....='cl ../../../'
alias .....='cl ../../../../'
alias ......='cl ../../../../'
alias .......='cl ../../../../../'
alias ........='cl ../../../../../../'
alias home='clear && cl ~ && ll'                                                                                                # Home directory
alias desktop='cl ~/Desktop/'           

alias angular='cl ~/Desktop/Bishen/Angular/'                                                                                     # Angular directory
alias react='cl ~/Desktop/Bishen/ReactJS/'                                                                                       # React directory
alias laravel123='cl ~/Desktop/Bishen/Laravel/'                                                                                  # Laravel directory
alias ionic123='cl ~/Desktop/Bishen/Ionic/'                                                                                      # Laravel directory
alias next='cl ~/Desktop/Bishen/NextJS/'                                                                                         # NextJS directory
alias LP='cl ~/Desktop/Bishen/Landing-Page/'                                                                                     # LP directory
alias downloads='clear && cl ~/Downloads/'                                                                                       # Downloads directory
alias delete_node='delete_node_queries'                                                                                         # Delete node_modules, .angular, .next, yarn.lock & package-lock.json files


######### Start NextJS #########
alias bishen='cl ~/Desktop/Bishen/NextJS/Bishen-Dev/'
alias avo='cl ~/Desktop/Bishen/NextJS/Avo-React-Creative-Agency-Showcase-Portfolio/'
alias rustic='cl ~/Desktop/Bishen/NextJS/Rustic-Business-Template/'
alias next_template_1='cl ~/Desktop/Bishen/NextJS/NextJS-Tailwind-Dashboard/'


### NextJS Dashboard ###
alias next_template_1='cl ~/Desktop/Bishen/NextJS/NextJS-Tailwind-Dashboard/'
### NextJS Dashboard ###
######### End NextJS #########

######### Start Angular #########
alias ng_template_1='cl ~/Desktop/Bishen/Angular/Angular-Tailwind-Template-1/'                                                      # Angular-Tailwind-Template-1 directory
alias ng_template_2='cl ~/Desktop/Bishen/Angular/Angular-Tailwind-Template-2/'                                                      # Angular-Tailwind-Template-2 directory
alias ng_template_3='cl ~/Desktop/Bishen/Angular/Angular-Tailwind-Template-3/'                                                      # Angular-Tailwind-Template-3 directory
alias ng_template_4='cl ~/Desktop/Bishen/Angular/Angular-Tailwind-Template-4/'                                                      # Angular-Tailwind-Template-3 directory
alias ng_ecommerce='cl ~/Desktop/Bishen/Angular/Angular-14-ECommerce/'                                                              # Angular-Tailwind-Template-3 directory
alias boilerplate_14='cl ~/Desktop/Bishen/Angular/Angular-14-Tailwind-Boilerplate/'                                                 # Angular-14-Tailwind-Boilerplate
alias boilerplate_15='cl ~/Desktop/Bishen/Angular/Angular-15-Tailwind-Boilerplate/'                                                 # Angular-15-Tailwind-Boilerplate
alias asc='cl ~/Desktop/Bishen/Angular/ASC-Legal/'                                                                                   # ASC-Legal directory
alias selfown='cl ~/Desktop/Bishen/Angular/Selfown-Angular14-TailwindCSS/'                                                           # Self Own Landing Page directory
alias fuse_rewrite='cl ~/Desktop/Bishen/Angular/Fuse/Fuse-14-Rewrite/'

alias fuse_13_demo='cl ~/Desktop/Bishen/Angular/Fuse/Angular-13/Fuse-Angular-13-Demo/'
alias fuse_13_skeleton='cl ~/Desktop/Bishen/Angular/Fuse/Angular-13/Fuse-Angular-13-Skeleton/'
alias fuse_13_starter='cl ~/Desktop/Bishen/Angular/Fuse/Angular-13/Fuse-Angular-13-Starter/'

alias fuse_14='cl ~/Desktop/Bishen/Angular/Fuse/Angular-14/Fuse-Angular-14/'
alias fuse_14_demo='cl ~/Desktop/Bishen/Angular/Fuse/Angular-14/Fuse-Angular-14-Demo/'
alias fuse_14_starter='cl ~/Desktop/Bishen/Angular/Fuse/Angular-14/Fuse-Angular-14-Starter/'

alias fuse_15_demo='cl ~/Desktop/Bishen/Angular/Fuse/Angular-15/Fuse-Angular-15-Demo/'
alias fuse_15_starter='cl ~/Desktop/Bishen/Angular/Fuse/Angular-15/Fuse-Angular-15-Starter/'
alias fuse_15_dev_starter='cl ~/Desktop/Bishen/Angular/Fuse/Angular-15/Fuse-Angular-15-Dev-Starter/'
######### End Angular #########

######### Start Ionic #########
alias ionic_boilerplate='cl ~/Desktop/Bishen/Ionic/ionic-boilerplate/'
alias ionic_todolist='cl ~/Desktop/Bishen/Ionic/ionic-to-do-list-training/'
######### End Angular #########

cs() { cd "$@" &&  ls; }                                                                                    # Enter directory and list contents with ls
cl() { cd "$@" && ll; }                                                                                     # Enter directory and list contents with ll
site() { clear && cl $HOME/sites/"$@"; }                                                                    # Access site folders easier
wp-theme() { clear && cl $HOME/sites/"$@"/content/themes/"$@"; }                                            # Access a site theme folders easier
project() { clear && cl $HOME/projects/"$@"; }                                                              # Access project folders easier
email() { clear && cl $HOME/projects/emails/"$@"; }                                                         # Access email folders easier

# various command shortcuts
# alias cls='clear'
# alias og='ls -ogrt'
# alias l='ls -lah'
# alias lc='ls -C'
# alias dir='ls -lrt'
# alias h='history'
# alias p='pwd -P'  # shows the "real" path in bash, not the path via symlinks
# alias et='emacs-tty'
# alias genome-mysql='mysql --user=genome --host=genome-mysql.soe.ucsc.edu -A'
# alias python=python2.7


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

mktar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }    # Creates a *.tar.gz archive of a file or folder
mkzip() { zip -r "${1%%/}.zip" "$1" ; }               # Create a *.zip archive of a file or folder

#---------------------------------------------------------------------------------------------------------------------------------------
#   4.  MISC ALIAS'
#---------------------------------------------------------------------------------------------------------------------------------------

# Homebrew
alias brewup='brew update && brew upgrade && brew cleanup'
alias brewup-cask='brew update && brew upgrade && brew cleanup && brew cask outdated | awk "{print $1}" | xargs brew cask reinstall && brew cask cleanup'

# Hyper
alias update-hyper-plugins='cl ~/.hyper_plugins && rm -rf node_modules && rm package-lock.json && npm install && cl -'

# browser-sync
alias bs='browser-sync'    # Browser Sync shorthand
bsdev() { browser-sync start --server --files '*/.css, */.js, */.php, */.html, */.mustache, */.twig' --tunnel 'kjbrum'; }    # Start local project server
bsproxy() { browser-sync start --proxy "$1" --files '*/.css, */.js, */.php, */.html, */.mustache, */.twig' --tunnel 'kjbrum'; }    # Proxy a local project

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
    cl ~/sites/"$@"
    . config/prepare.sh
}

# npm
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

    if [[ $* == --polite ]]; then
        polite="--wait=2 --limit-rate=50K"
    fi

    wget --recursive --page-requisites --convert-links --user-agent="Mozilla" $polite "$1";
}



#---------------------------------------------------------------------------------------------------------------------------------------
#   5.  GIT SHORTCUTS
#---------------------------------------------------------------------------------------------------------------------------------------

alias config_HLBB='git config user.name "Bishen Patel" && git config user.email "tbishen@hlbb.hongleong.com.my" '
alias config_personal=' git config user.name "Bishen Patel" && git config user.email "patelzz007@gmail.com" '
alias init='git init && git config user.name "Bishen Patel" && git config user.email "patelzz007@gmail.com"'
alias gitstats='git-stats'
alias gits='git status -s'
alias gita='git add -A && git status -s'
alias gitcom='git commit -am'
alias gitacom='git add -A && git commit -am'
alias gitc='git checkout'
alias gitcm='git checkout master'
alias gitcd='git checkout development'
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

delete_node_queries() {
    if [ -d node_modules ]; then
        echo -e "${REDB}Deleting Node Modules.${NC}"
        rm -rf node_modules/
        echo -e "${REDB}Done deleting Node Modules.${NC}"
    else
        echo -e "${CYANB}Node Modules not found.${NC}"
    fi

    if [ -d .angular ]; then
        echo -e "${GREENB}Deleting .angular.${NC}"
        rm -rf .angular
        echo -e "${GREENB}Done deleting .angular.${NC}"
    else
        echo -e "${CYANB}.angular not found.${NC}"
    fi

    if [ -d .next ]; then
        echo -e "${GREENB}Deleting .next.${NC}"
        rm -rf .next
        echo -e "${GREENB}Done deleting .next.${NC}"
    else
        echo -e "${CYANB}.next not found.${NC}"
    fi

    if [ -f package-lock.json ]; then
        echo -e "${YELLOWB}Deleting package-lock.json.${NC}"
        rm -rf package-lock.json
        echo -e "${YELLOWB}Done deleting package-lock.json.${NC}"
    else
        echo -e "${CYANB}package-lock.json not found.${NC}"
    fi

    if [ -f yarn.lock ]; then
        echo -e "${BLUEB}Deleting yarn.lock.${NC}"
        rm -rf yarn.lock
        echo -e "${BLUEB}Done deleting yarn.lock.${NC}"
    else
        echo -e "${CYANB}yarn.lock not found.${NC}"
    fi

    if [ -f pnpm-lock.yaml ]; then
        echo -e "${BLUEB}Deleting pnpm-lock.yaml.${RESET}"
        rm -rf pnpm-lock.yaml
        echo -e "${BLUEB}Done deleting pnpm-lock.yaml.${RESET}"
    else
        echo -e "${CYANB}pnpm-lock.yaml not found.${RESET}"
    fi
    
    if [ -f yarn-error.log ]; then 
        echo -e "${BLUEB}Deleting yarn-error.lock.${NC}"
        rm -rf yarn-error.log
        echo -e "${BLUEB}Done deleting yarn-error.lock.${NC}"
    else
        echo -e "${CYANB}yarn-error.lock not found.${NC}"
    fi
}

gitpush () {
    git add .
    git commit -m "$*"
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3-)"
    [ -n "${branch}" ] && echo -e "This Is ${BLUEB}${branch}${NC} Branch."
    echo -e "Pushing To ${BLUEB}${branch}${NC} Branch."
    git push -u origin ${branch}
    echo -e "Successfully Pushed To ${BLUEB}${branch}${NC} Branch."
    echo "\e[32m"
    figlet '200 OK'
    echo "\e[0m"
}

gitprompt() {
    local branch="$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3-)"
    local branch_truncated="${branch:0:30}"
    if (( ${#branch} > ${#branch_truncated} )); then
        branch="${branch_truncated}..."
    fi

    [ -n "${branch}" ] && echo -e "This Is ${BLUEB}${branch}${NC} Branch."
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
        # then echo -e "" git:\($(git branch 2>/dev/null| sed -n '/^\/s/^\ //p')\)
        then echo -e "" \[$(git branch 2>/dev/null| sed -n '/^\/s/^\ //p')\]
    else
        echo ""
    fi
}

# Set a specific color for the status of the Git repo
git_color() {
    local STATUS=`git status 2>&1`
    if [[ "$STATUS" == 'Not a git repository' ]]
        then echo "" # nothing
    else
        if [[ "$STATUS" != 'working tree clean' ]]
            then echo -e '\033[0;31m' # red if need to commit
        else
            if [[ "$STATUS" == 'Your branch is ahead' ]]
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
# source <(ng completion script)

unsetopt INTERACTIVE_COMMENTS
unsetopt BAD_PATTERN