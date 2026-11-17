#!/usr/bin/env bash
# ==============================================================================
# install.sh: set up a Mac from this dotfiles repo. Safe to re-run.
#
#   1. Homebrew packages, apps and VS Code extensions (Brewfile)
#   2. Oh My Zsh + plugins (autosuggestions, syntax-highlighting, fzf-tab)
#   3. Symlinks: ~/.zshrc, ~/.config/zsh
#      (anything already there is renamed to *.backup-<timestamp>, never deleted)
#   4. git: include the delta settings from git/delta.gitconfig
#   5. Node: latest LTS via fnm, set as default, + global npm packages
#
# Usage:  ./install.sh
# Needs:  Homebrew (https://brew.sh). A Nerd Font in your terminal for icons.
# ==============================================================================
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NPM_GLOBALS=(
    @angular/cli @nestjs/cli corepack figlet freebuff
    npm-check-updates pnpm typescript vercel yarn
)

info() { printf '\033[1;34m==>\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m==>\033[0m %s\n' "$*" >&2; }

# ---- 1. Homebrew ---------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
    warn "Homebrew is not installed. Install it from https://brew.sh, then re-run."
    exit 1
fi
info "Installing Homebrew packages from Brewfile"
brew bundle --file="$DOTFILES/Brewfile"

# ---- 2. Oh My Zsh + plugins ----------------------------------------------------
ZSH_DIR="$HOME/.oh-my-zsh"
if [ ! -d "$ZSH_DIR" ]; then
    info "Installing Oh My Zsh"
    RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
PLUGINS_DIR="${ZSH_CUSTOM:-$ZSH_DIR/custom}/plugins"
clone_plugin() {
    if [ ! -d "$PLUGINS_DIR/$1" ]; then
        info "Installing zsh plugin $1"
        git clone --depth 1 "$2" "$PLUGINS_DIR/$1"
    fi
}
clone_plugin zsh-autosuggestions     https://github.com/zsh-users/zsh-autosuggestions
clone_plugin zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting
clone_plugin fzf-tab                 https://github.com/Aloxaf/fzf-tab

# ---- 3. Symlinks ---------------------------------------------------------------
link() {
    local src="$1" dst="$2"
    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
        return 0
    fi
    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mv "$dst" "$dst.backup-$(date +%Y%m%d%H%M%S)"
        info "Backed up existing $dst"
    fi
    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    info "Linked $dst -> $src"
}
link "$DOTFILES/.zshrc"  "$HOME/.zshrc"
link "$DOTFILES/zsh"     "$HOME/.config/zsh"
# (starship.toml is for Windows only and is deliberately not linked on macOS.)

# ---- 4. git + delta ------------------------------------------------------------
DELTA_CONFIG="$DOTFILES/git/delta.gitconfig"
if ! git config --global --get-all include.path 2>/dev/null | grep -qxF "$DELTA_CONFIG"; then
    git config --global --add include.path "$DELTA_CONFIG"
    info "Added delta settings to ~/.gitconfig"
fi

# ---- 5. Node: latest LTS via fnm -------------------------------------------------
# Later on, run `node-lts` in the shell to move to a newer LTS (it also carries
# your global packages across).
eval "$(fnm env --shell bash)"
info "Installing the latest Node LTS"
fnm install --lts
NODE_LTS="$(fnm exec --using=lts-latest node -v)"
fnm default "$NODE_LTS"
fnm use "$NODE_LTS" >/dev/null
info "Default Node: $NODE_LTS. Installing global npm packages"
npm install -g --no-fund --no-audit --allow-scripts=pnpm,yarn,esbuild "${NPM_GLOBALS[@]}"

info "Done. Open a new terminal to start using it."
