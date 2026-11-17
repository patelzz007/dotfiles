# dotfiles

My macOS terminal setup: zsh + Oh My Zsh, split into one file per topic.

## New Mac

```sh
git clone git@github.com:patelzz007/dotfiles.git ~/Desktop/Bishen/dotfiles
~/Desktop/Bishen/dotfiles/install.sh
```

`install.sh` installs everything in the `Brewfile`, Oh My Zsh and its plugins,
Node via fnm, and links the config files into place (existing files are backed
up, never deleted). It is safe to re-run.

## Layout

| Path | What |
|---|---|
| `.zshrc` | Loader only (linked as `~/.zshrc`) |
| `zsh/*.zsh` | The config, one topic per file (linked as `~/.config/zsh`) |
| `starship.toml` | Prompt (linked as `~/.config/starship.toml`) |
| `git/delta.gitconfig` | Git diff styling, included from `~/.gitconfig` |
| `Brewfile` | Homebrew packages, apps, VS Code extensions |
| `.bashrc`, `terminal-settings.json`, `vscode-settings.json` | Not linked automatically |

Because the files are symlinked, editing your live config edits this repo:
open it with `editzsh`, reload with `resource`, then commit.

## Handy commands

| Command | Does |
|---|---|
| `p <name>` | Jump to a project under `~/Desktop/Bishen` (fzf picker if ambiguous) |
| `z <name>` / `zi` | Jump to a frequently used folder (zoxide) |
| `gitpush <message>` | Stage, commit and push, with a clear FAILED reason if anything breaks |
| `gco` | Pick a git branch with fzf (most recent first) |
| `nr` | Pick and run a `package.json` script with the project's package manager |
| `killport 3000` / `ports` | Free a port / list what's listening and from which project |
| `lg` | lazygit |
| `ll`, `tree`, `cat` | eza / bat versions |
| `ramcheck` | RAM usage grouped by app |
| Ctrl-R / Ctrl-T / Tab | fzf history search / file picker / fuzzy completion |
