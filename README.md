# dotfiles

My macOS terminal setup: **zsh + Oh My Zsh**, split into one small file per
topic, plus the tools, plugins and settings it relies on. Everything in this
README describes what's actually in the repo, so it doubles as a "what did I
install and why" reference.

- [Features at a glance](#features-at-a-glance)
- [Quick start (new Mac)](#quick-start-new-mac)
- [How it works](#how-it-works)
- [Everything that's installed](#everything-thats-installed)
- [Command reference](#command-reference)
- [Keyboard shortcuts](#keyboard-shortcuts)
- [Fuzzy search (Telescope-style)](#fuzzy-search-telescope-style)
- [Node.js](#nodejs)
- [Git](#git)
- [Customising](#customising)
- [Keeping things up to date](#keeping-things-up-to-date)
- [Troubleshooting](#troubleshooting)
- [Other files in this repo](#other-files-in-this-repo)
- [History of changes](#history-of-changes)

---

## Features at a glance

| Feature | How you use it |
|---|---|
| **fnm** (replaces nvm) | Node switches automatically in folders with a `.nvmrc` or `.node-version`. The default is always the latest LTS (`node-lts` to upgrade), with your globals (`ng`, `nest`, `pnpm`, `vercel`…) installed on it, and `nvm ls`/`use`/`install` still work. |
| **zoxide** (replaces autojump) | `z rewardhub` jumps there, `zi` opens a picker. Your 62 autojump folders were imported, and `j` still works. |
| **fzf-tab** | Tab completion becomes a fuzzy menu, with previews for `cd`, `git switch` and `kill`. |
| **Prompt** | Oh My Zsh's `ys` theme. (starship was tried and removed; `starship.toml` in this repo is for Windows only.) |
| **eza / bat / delta** | `ll` and `tree` show git status and icons, `cat` and man pages are syntax-highlighted, git diffs are highlighted (`gitdiffs` shows side-by-side). |
| **Dev helpers** | `killport 3000`, `ports`, `gco` (branch picker), `nr` (pick and run a script with the right package manager). `mkcd` already came with Oh My Zsh. |
| **History** | 100k entries shared across terminals, no duplicates, and commands typed with a leading space aren't saved. |
| **Repo** | `Brewfile`, `install.sh` (sets up a new Mac, safe to re-run), `README.md`, `git/delta.gitconfig`. |

---

## Quick start (new Mac)

**Before you start**

1. Install [Homebrew](https://brew.sh).
2. Use a **Nerd Font** in your terminal, or file icons in `ll`/`tree` show up as
   boxes. I use **Iosevka Nerd Font** in iTerm2
   (iTerm2 → Settings → Profiles → Text → Font).

**Install**

```sh
git clone git@github.com:patelzz007/dotfiles.git ~/Desktop/Bishen/dotfiles
~/Desktop/Bishen/dotfiles/install.sh
```

Then open a new terminal.

**What `install.sh` does** (safe to run again at any time):

| Step | What happens |
|---|---|
| 1. Homebrew | Installs every CLI tool, app and VS Code extension listed in `Brewfile` |
| 2. Oh My Zsh | Installs Oh My Zsh if missing, then the plugins `zsh-autosuggestions`, `zsh-syntax-highlighting` and `fzf-tab` |
| 3. Symlinks | Links `~/.zshrc` and `~/.config/zsh` to this repo. Anything already there is renamed to `*.backup-<timestamp>`, never deleted |
| 4. Git | Adds an `[include]` for `git/delta.gitconfig` to `~/.gitconfig` |
| 5. Node | Installs the **latest Node LTS** with fnm, makes it the default, installs the global npm packages |

---

## How it works

### The files are symlinked

```
~/.zshrc        ->  ~/Desktop/Bishen/dotfiles/.zshrc
~/.config/zsh   ->  ~/Desktop/Bishen/dotfiles/zsh/
```

So **editing your live config edits this repo**. The everyday loop is:

1. `editzsh`: opens this repo in VS Code
2. change something
3. `resource`: reloads the config in the current terminal
4. commit and push as usual

### Load order

`~/.zshrc` is only a loader. It sources these files, in this order:

| # | File | What's in it |
|---|---|---|
| 1 | `env.zsh` | Environment variables (`JAVA_HOME`, `ANDROID_HOME`, `DOTFILES`, eza/bat settings...) |
| 2 | `path.zsh` | The **only** place `PATH` is built. Duplicates and missing folders are dropped automatically |
| 3 | `omz.zsh` | Oh My Zsh: `ys` theme and the plugin list |
| 4 | `history.zsh` | History size and behaviour |
| 5 | `node.zsh` | Node via fnm, `node-lts`, the `nvm` shim |
| 6 | `tools.zsh` | fzf, fzf-tab styling, zoxide, bun completions |
| 7 | `colors.zsh` | `$CLR` colour table used by the functions |
| 8 | `aliases.zsh` | General aliases (`ll`, `tree`, `cat`, `lg`...) |
| 9 | `navigation.zsh` | `cl`, `cs`, `up`, folder shortcuts, `p` project jumper |
| 10 | `files.zsh` | `cleardir`, `delete_node`, `getsshkey`, `disk-usage`... |
| 11 | `misc.zsh` | `startserver`, `weather`, `dl-website`, `cap-*`, `fuck`... |
| 12 | `dev.zsh` | `killport`, `ports`, `gco`, `nr` |
| 13 | `search.zsh` | `ff`, `fw`: Telescope-style fuzzy search |
| 14 | `git.zsh` | Git aliases, `gitpush`, `gitreset`, `gitrinse`... |
| 15 | `ramcheck.zsh` | `ramcheck` |

On every `resource`, all aliases are cleared first and rebuilt, so a renamed
alias or function can never clash with a leftover from before.

### Conventions used in the zsh files

Every function has a header like this (zsh has no types or access modifiers,
so these comments and a naming rule stand in for them):

```zsh
##
# What it does.
# @param   $1  string  meaning
# @return  0 on success, 1 on failure
##
```

- Functions starting with `_` are internal helpers (the zsh convention for "private").
- Variables are declared with types where it helps: `local -r` (constant),
  `local -i` (integer), `local -a` (array), `local -A` (map).
- Anything destructive asks first and moves things to the **Trash** instead of deleting.

---

## Everything that's installed

### Oh My Zsh plugins

| Plugin | What it does | Where it comes from |
|---|---|---|
| `git` | 150+ git aliases (`gst`, `gaa`, `gcmsg`...) and the `git_main_branch` helper | Built into Oh My Zsh |
| `fzf-tab` | Turns **Tab completion** into an fzf fuzzy menu with previews | [Aloxaf/fzf-tab](https://github.com/Aloxaf/fzf-tab), cloned into `~/.oh-my-zsh/custom/plugins/` |
| `zsh-autosuggestions` | Grey "ghost text" suggestions from your history; press → to accept | [zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) |
| `zsh-syntax-highlighting` | Colours commands as you type: green = valid, red = not found | [zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) |

Plugin order matters: `fzf-tab` must load before the other two.

### Command-line tools (Homebrew)

These are the tools the zsh config actually uses. The full list of everything
installed (apps, databases, VS Code extensions) is in `Brewfile`.

| Tool | Replaces / adds | Used by |
|---|---|---|
| [`fnm`](https://github.com/Schniz/fnm) | Node version manager (replaced nvm) | `node.zsh` |
| [`zoxide`](https://github.com/ajeetdsouza/zoxide) | Smart `cd` that learns your folders (replaced autojump) | `z`, `zi`, `j` |
| [`fzf`](https://github.com/junegunn/fzf) | Fuzzy finder | Ctrl-R, Ctrl-T, `p`, `gco`, `nr`, `ff`, `fw` |
| [`fd`](https://github.com/sharkdp/fd) | Fast `find` that respects `.gitignore` | fzf file lists, `ff` |
| [`ripgrep`](https://github.com/BurntSushi/ripgrep) (`rg`) | Fast `grep` that respects `.gitignore` | `fw` |
| [`eza`](https://github.com/eza-community/eza) | Modern `ls` with git status and icons | `ll`, `tree`, `cl`, previews |
| [`bat`](https://github.com/sharkdp/bat) | `cat` with syntax highlighting | `cat`, man pages, previews |
| [`git-delta`](https://github.com/dandavison/delta) | Syntax-highlighted git diffs | `git diff`, `git log -p`, `gitdiffs` |
| [`lazygit`](https://github.com/jesseduffield/lazygit) | Full git UI in the terminal | `lg` |
| `figlet` (npm package) | Big ASCII banners | `gitpush` (`200 OK` / `FAILED`) |
| `gh` | GitHub CLI | — |

### Global npm packages (on the default Node)

Installed by `install.sh`, and carried over automatically by `node-lts`:

`@angular/cli` (`ng`), `@nestjs/cli` (`nest`), `figlet`, `freebuff`,
`npm-check-updates` (`ncu`), `pnpm`, `typescript` (`tsc`), `vercel`, `yarn`.

### Node versions

Managed by fnm in `~/.local/share/fnm`. Check with `fnm list`. The default is
always the **latest LTS** (26.13.1 "Lithium" as of November 2026).

---

## Command reference

### Navigation

| Command | Does |
|---|---|
| `p <name>` | Jump to a project under `~/Desktop/Bishen` by partial name (`p rewardhub`). Ambiguous or empty: fzf picker. Tab-completes names |
| `z <name>` | Jump to the folder you use most that matches (`z rew`). Learns as you `cd` |
| `zi` | Pick a folder from zoxide's list with fzf |
| `j <name>` | Same as `z` (old autojump habit) |
| `cl <dir>` | `cd` and list with `eza` |
| `cs <dir>` | `cd` and plain `ls` |
| `up [n]` | Go up `n` folders (default 1) and list |
| `..` `...` `....` … `........` | Up 1 to 7 folders |
| `home`, `desktop`, `downloads` | Jump to those folders |
| `angular`, `next`, `laravel123` | Jump to those project folders |
| `mkcd <dir>` | Create a folder and `cd` into it (from Oh My Zsh) |

### Listing and viewing files

| Command | Does |
|---|---|
| `ll` | Long list with git status, icons, folders first |
| `llr` | Same, reversed |
| `lls` / `llsr` | By size: largest first / smallest first |
| `lld` / `lldr` | By date modified: newest first / oldest first |
| `lldc` / `lldcr` | By date created: newest first / oldest first |
| `tree` | Folder tree, skips `node_modules`, `.git` and git-ignored files. `tree -L 2` limits depth |
| `cat <file>` | Syntax-highlighted output (bat). `bat <file>` shows line numbers too |
| `\cat <file>` | The original `cat` (needed for options like `cat -v`) |
| `ls` | Plain `ls`, unchanged, so flags like `ls -lt` still work |
| `perm <file>` | Permissions as a number, e.g. `644` |

### Files and folders

| Command | Does |
|---|---|
| `cleardir` | Move **everything** in the current folder (including hidden files) to the Trash, after asking. Refuses in `/` and `~` |
| `delete_node` | Move `node_modules`, `.angular`, `.next` and lockfiles (`package-lock.json`, `yarn.lock`, `pnpm-lock.yaml`, `bun.lock(b)`, `yarn-error.log`) to the Trash |
| `disk-usage [paths]` | Size of each item, largest first (default: everything here) |
| `dirdiff <a> <b>` | Compare the file lists of two folders |
| `mktar <path>` / `mkzip <path>` | Make `path.tar.gz` / `path.zip` |
| `getsshkey [name]` | Copy an SSH public key to the clipboard (default `id_ed25519`). Tab-completes key names |
| `h [text]` | Search your **full** history |
| `t <file>` | Move to Trash |
| `bash-as <user>` | Open a bash shell as another user |

### Dev servers and projects

| Command | Does |
|---|---|
| `killport <port>...` | Stop whatever is listening on a port (e.g. a stuck `next dev`). Tries a normal stop first, forces only if needed |
| `ports` | List listening ports with process name and the **project folder** it was started from |
| `nr [script]` | Run a `package.json` script. No argument: fzf picker with each script's command as preview. Uses pnpm / bun / yarn / npm based on the nearest lockfile (works inside monorepo packages) |
| `nrs` / `nrd` / `nrb` | `npm run start` / `dev` / `build` |
| `ys` / `yd` / `yb` | `yarn start` / `dev` / `build` |
| `startserver [dir] [port]` | Serve a folder with PHP's built-in server and open the browser (default `.` on 3000) |
| `ramcheck [rows]` | RAM usage grouped by app, biggest first |

### Fuzzy search

| Command | Does |
|---|---|
| `ff [text]` | **Find Files**: fuzzy-find by name with preview, open in your editor |
| `fw [text]` | **Find Word**: live-search file contents, open the file at the matching line |

Details in [Fuzzy search](#fuzzy-search-telescope-style).

### Git

**Functions**

| Command | Does |
|---|---|
| `gitpush <message>` (alias `gp`) | Stage all, commit, push the current branch. Shows a green `200 OK` banner, or a red `FAILED` banner with the reason (e.g. remote has new commits, auth failed, no network) and git's output |
| `gco [branch]` | Pick a branch with fzf, most recent first, local and remote. `gco <exact-name>` switches directly |
| `gitreset [ref]` | Hard reset to `ref` (default `HEAD`) after confirming |
| `gitrinse [all]` | Clean and reset submodules (`all`: the repo too) after confirming |
| `gitdbr <branch>` | Delete a branch locally and on origin |
| `gitupstream <remote/branch>` | Set the upstream of the current branch |
| `lg` | lazygit |
| `gitdiffs` | `git diff`, side by side |

**Aliases** (`main` or `master` is detected automatically where it says "main")

| Alias | Runs |
|---|---|
| `gits` | `git status -s` |
| `gita` | `git add -A && git status -s` |
| `gitcom <msg>` | `git commit -am <msg>` |
| `gitacom <msg>` | `git add -A && git commit -m <msg>` |
| `gitamend` | `git commit --amend` |
| `gitundo` | Undo the last commit, keep the changes staged |
| `gitc` / `gitcb` | `git checkout` / `git checkout -b` |
| `gitcm` / `gitcd` / `gitcgh` | Checkout main / `development` / `gh-pages` |
| `gitb` / `gitdb` / `gitDb` | `git branch` / delete / force delete |
| `gitdr <branch>` | Delete a remote branch |
| `gitf` / `gitpl` / `gfp` | Fetch / pull / fetch + pull |
| `gitr` / `gitfr` / `gitfrp` | Rebase / fetch + rebase / fetch + rebase + push |
| `gitp` / `gitpo` / `gitpom` | `push -u` / `push -u origin` / push main |
| `gitphm` | Push main to heroku |
| `gitm` / `gitmd` / `gitmm` | Merge / merge `development` / merge main |
| `gitm2gh` | Merge main into `gh-pages`, push, go back |
| `gitcl` / `gitclr` | Clone / clone with submodules |
| `gitrao` / `gitrso` | Add / change the `origin` URL |
| `gitpls` | Update submodules from their tracked branches |
| `gittrack` / `gituntrack` | Undo / set `assume-unchanged` on a file |
| `gitrmcached <path>` | Stop tracking a path but keep the file |
| `gitcount` | Commits per author |
| `gitlog` / `gitlog-full` / `gitlog-changes` | One-line log / graph of all branches / graph with changed files |
| `config_personal` / `config_HLBB` / `init` | Set this repo's name and email (personal / work) / `git init` with personal identity |

Plus all of Oh My Zsh's git plugin aliases (`gst`, `gaa`, `gcmsg`, `gl`, `gp`
is overridden to `gitpush`, `gco` is overridden to the branch picker).

### Everything else

| Command | Does |
|---|---|
| `weather [place]` | Weather from wttr.in (`weather kuala lumpur`). No place: based on your IP |
| `dl-website [--polite] <url>` | Download a site for offline viewing (needs `brew install wget`) |
| `dir-to-remote <user@host:/path>` | rsync the current folder to a server |
| `cap-staging` / `cap-production` | Capistrano pull or push, with confirmation |
| `bec` / `becs` / `becp` | `bundle exec cap` (staging / production) |
| `fuck` | Re-run the previous command with `sudo` (shows it first) |
| `brewup` | Update and upgrade Homebrew, clean up |
| `resource` | Reload the config |
| `editzsh` / `editbash` / `editsshconfig` / `edithosts` | Open those files in VS Code |
| `cls` / `x` | `clear` / `exit` |
| `v` | `valet` |
| `shell-to-zsh` / `shell-to-bash` | Change your login shell |

---

## Keyboard shortcuts

| Keys | Where | Does |
|---|---|---|
| **Ctrl-R** | Prompt | Fuzzy-search history |
| **Ctrl-T** | Prompt | Fuzzy-pick a file and paste its path (bat preview) |
| **Alt-C** | Prompt | Fuzzy-pick a folder and `cd` into it (tree preview) |
| **Tab** | Prompt | Fuzzy completion menu (fzf-tab): files, branches, processes, npm scripts... |
| `<` / `>` | fzf-tab menu | Switch between completion groups |
| **→** (right arrow) | Prompt | Accept the grey autosuggestion |
| `**` then Tab | Prompt | fzf's own path completion, e.g. `code src/**<Tab>` |

---

## Fuzzy search (Telescope-style)

Modelled on Neovim's **telescope.nvim**: a big floating picker with the
results on the left and a syntax-highlighted preview on the right.

| | `ff` (Find Files) | `fw` (Find Word / live grep) |
|---|---|---|
| Searches | File **names** | File **contents** (ripgrep), updated as you type |
| Preview | The file | The file, scrolled to and highlighting the matching line |
| Enter | Opens the file | Opens the file **at that line** |
| Skips | `.git`, `node_modules`, anything in `.gitignore` | Same |
| Case | — | Smart case: lowercase = any case, any capital = exact case |

**Keys inside the picker**

| Key | Does |
|---|---|
| type | Filter (`ff`) / search contents (`fw`) |
| Enter | Open |
| Tab / Shift-Tab | Select several, then Enter opens them all |
| Ctrl-F | (`fw`) Freeze the current results and fuzzy-filter within them |
| Ctrl-/ | Hide or show the preview |
| Ctrl-D / Ctrl-U | Scroll the preview down / up |
| Ctrl-Y | Copy the file path to the clipboard |
| Esc | Cancel |

**Which editor opens?** `$VISUAL`, then `$EDITOR`, otherwise VS Code. Jumping
to a line works with VS Code, Cursor, Windsurf, Zed, Sublime Text, Neovim and
Vim. To use Neovim, add `export EDITOR=nvim` to `zsh/env.zsh`.

---

## Node.js

- **fnm** replaced nvm (the old `~/.nvm` folder is no longer used and can be
  deleted with `rm -rf ~/.nvm`).
- The default Node is **always the latest LTS**. When a new LTS is released,
  run **`node-lts`**: it installs it, makes it the default and reinstalls your
  global npm packages on it. Old versions stay installed.
- Entering a folder with a `.nvmrc` or `.node-version` (or a parent folder with
  one) switches Node automatically and prints `Using Node vX`.
- `engines.node` in `package.json` is **not** used for switching on purpose:
  fnm would pick the newest installed version matching ranges like `>=20`,
  which might not be the LTS your global tools live on. For such projects run
  `fnm use <version>` or add a `.nvmrc`. (t3code needs `fnm use 26`.)
- `nvm ls`, `nvm use`, `nvm install` still work: they're translated to fnm.

| Command | Does |
|---|---|
| `fnm list` | Installed versions (and which is default) |
| `fnm install 22` | Install the latest 22.x |
| `fnm use 22` | Use it in this terminal |
| `fnm default <version>` | Change the default |
| `fnm uninstall <version>` | Remove a version |
| `node-lts` | Move to the latest LTS and carry your global packages over |

---

## Git

- **delta** makes `git diff`, `git show` and `git log -p` syntax-highlighted
  with line numbers. In a long diff, `n` / `N` jump between files.
  `gitdiffs` shows a side-by-side diff. Settings: `git/delta.gitconfig`,
  included from `~/.gitconfig`.
- Merge conflicts use `zdiff3`, so they also show the original text.
- `gitpush` checks everything first (commit message, repo, branch, remote) and
  explains failures in plain words. A failed push never loses your commit.

---

## Customising

| I want to... | Change |
|---|---|
| Add a folder to PATH | `zsh/path.zsh` |
| Add an environment variable | `zsh/env.zsh` |
| Change which editor `ff`/`fw` open | `export EDITOR=...` in `zsh/env.zsh` |
| Search other folders with `p` | `PROJECT_ROOTS` in `zsh/navigation.zsh` |
| Change the space between icons and names | `EZA_ICON_SPACING` in `zsh/env.zsh` (currently `2`) |
| Change the prompt theme | `ZSH_THEME` in `zsh/omz.zsh` (currently `ys`) |
| Add an Oh My Zsh plugin | `plugins=(...)` in `zsh/omz.zsh` |
| Change history size | `zsh/history.zsh` |
| Add a new topic file | Create `zsh/<name>.zsh` and add `<name>` to the list in `.zshrc` |

---

## Keeping things up to date

| What | How |
|---|---|
| Homebrew packages | `brewup` |
| Node LTS | `node-lts` |
| Oh My Zsh | `omz update` |
| Custom zsh plugins | `for p in ~/.oh-my-zsh/custom/plugins/*/.git(:h); do git -C $p pull; done` |
| `Brewfile` after installing something new | `brew bundle dump --file=- --no-npm --no-uv`, then paste into `Brewfile` |

---

## Troubleshooting

| Problem | Fix |
|---|---|
| Icons show as boxes or `?` | Your terminal font isn't a Nerd Font. Set one in iTerm2 → Settings → Profiles → Text |
| `cat -v` (or another cat option) errors | `cat` is bat. Use `\cat -v` |
| Node didn't switch in a project | It has no `.nvmrc` / `.node-version`. Run `fnm use <version>` or add a `.nvmrc` |
| `command not found: ng` (or pnpm, nest...) after switching Node | Global packages are per Node version. Switch back (`fnm use default`) or install them on that version |
| Errors after `resource` | Open a new terminal tab. If they persist, the message names the file and line |
| Shell feels slow to start | `time zsh -i -c exit` should be ~0.15s. The first start after adding a plugin rebuilds the completion cache and is slower once |
| `ll` prints nothing when run from a script or tool | eza reads file names from stdin when stdin isn't a terminal. Pass a path: `eza -la .` |

---

## Other files in this repo

| File | What |
|---|---|
| `Brewfile` | Everything installed with Homebrew: CLI tools, apps, VS Code extensions |
| `install.sh` | New-Mac setup script (see [Quick start](#quick-start-new-mac)) |
| `git/delta.gitconfig` | delta settings for git |
| `starship.toml` | **Windows only** (starship prompt config). Not used on macOS |
| `terminal-settings.json` | Windows Terminal settings |
| `.bashrc` | Older bash config, not linked automatically |
| `vscode-settings.json` | VS Code settings, not linked automatically |

---

## History of changes

**November 2026**

- Split the single 970-line `.zshrc` into topic files; startup went from ~1.1s
  to ~0.15s.
- Fixed many broken functions (zsh-incompatible prompts, `startserver` wiping
  `PATH`, `weather`, `dl-website`, history search, `..` aliases, `bun.lock`
  deletion and more).
- Stopped a new ssh-agent from starting with every terminal (170+ had piled up).
- Removed aliases for folders and tools that no longer exist; added `p`.
- `gitpush` explains failures with a `FAILED` banner.
- Removed leaked database passwords from the repo and its history.
- Added fnm (latest LTS by default, `node-lts`), zoxide, fzf-tab, eza, bat,
  delta, fd, lazygit, `killport`, `ports`, `gco`, `nr`, Telescope-style
  `ff`/`fw`, shared history, `Brewfile` and `install.sh`.
- Live config is now symlinked to this repo.
