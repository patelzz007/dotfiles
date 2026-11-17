# ==============================================================================
# search.zsh: Telescope-style fuzzy search (like Neovim's telescope.nvim).
#
#   ff [text]   Find Files: fuzzy-find a file by name, preview it, open it
#   fw [text]   Find Word:  live grep the whole project (ripgrep), preview the
#               match in context, open the file AT that line
#
# Inside the picker:
#   type          filter (ff) / search file contents live (fw)
#   Enter         open in your editor          Tab        multi-select
#   Ctrl-/        hide/show preview            Ctrl-U/D   scroll preview
#   Ctrl-Y        copy the path to clipboard   Ctrl-F     (fw) fuzzy-filter the
#   Esc           cancel                                  current results
#
# Editor: $VISUAL, then $EDITOR, else VS Code. Line jumps work for VS Code,
# Cursor, Zed, Sublime and Vim. e.g. `export EDITOR=cursor` in env.zsh.
# ==============================================================================

# Shared Telescope-like look: big window, prompt on top, preview on the right.
typeset -ga _TELESCOPE_OPTS=(
    --height=90% --layout=reverse --border=rounded --info=inline-right
    --preview-window='right,60%,border-left'
    --bind='ctrl-/:toggle-preview,ctrl-d:preview-half-page-down,ctrl-u:preview-half-page-up'
    --color='border:#5c6370,label:#61afef,prompt:#61afef,pointer:#e06c75,marker:#98c379,hl:#e5c07b,hl+:#e5c07b'
)

##
# Open a file in the user's editor, at a line if one is given.
# @param   $1  string  file path
# @param   $2  int     line number (optional, default 1)
##
_open_in_editor () {
    emulate -L zsh
    local -r file=$1
    local -ri line=${2:-1}
    local -a editor=( ${(z)${VISUAL:-${EDITOR:-code}}} )

    case ${editor[1]:t} in
        (code|code-insiders|cursor|windsurf)  $editor -g "${file}:${line}" ;;
        (zed|subl)                            $editor "${file}:${line}" ;;
        (nvim|vim|vi)                         $editor "+${line}" "$file" ;;
        (*)                                   $editor "$file" ;;
    esac
}

##
# Find Files: fuzzy-find files by name with a syntax-highlighted preview.
# Respects .gitignore; skips .git and node_modules.
# @param   $@  string  optional starting query
# @return  0 if something was opened, 1 if cancelled
##
ff () {
    emulate -L zsh
    local -a picked
    picked=( ${(f)"$(
        fd --type f --hidden --follow --exclude .git --exclude node_modules \
        | fzf $_TELESCOPE_OPTS --multi --query="$*" \
              --border-label=' Find Files ' --prompt='  ' \
              --preview='bat --color=always --style=numbers --line-range=:500 {}' \
              --bind='ctrl-y:execute-silent(printf %s {} | pbcopy)+abort'
    )"} )
    (( $#picked )) || return 1

    local file
    for file in $picked; do
        _open_in_editor "$file"
    done
}

##
# Find Word (live grep): search file contents as you type, preview each match
# centred on its line, open the file at that line.
# @param   $@  string  optional starting search text
# @return  0 if something was opened, 1 if cancelled
##
fw () {
    emulate -L zsh
    local -r rg_cmd='rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git" --glob "!node_modules"'
    local -a picked
    picked=( ${(f)"$(
        fzf $_TELESCOPE_OPTS --multi --ansi --disabled --query="$*" \
            --border-label=' Live Grep ' --prompt='  ' \
            --delimiter=: \
            --bind="start,change:reload:[ -n {q} ] && $rg_cmd -- {q} || true" \
            --bind='ctrl-f:unbind(change)+change-prompt(Filter: )+enable-search+clear-query' \
            --bind='ctrl-y:execute-silent(printf %s {1} | pbcopy)+abort' \
            --preview='bat --color=always --style=numbers --highlight-line={2} {1}' \
            --preview-window='right,60%,border-left,+{2}+3/3'
    )"} )
    (( $#picked )) || return 1

    local entry
    for entry in $picked; do
        # entry = file:line:column:text
        _open_in_editor "${entry%%:*}" "${${entry#*:}%%:*}"
    done
}
