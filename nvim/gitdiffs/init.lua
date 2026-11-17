-- =============================================================================
-- gitdiffs: a Neovim setup dedicated to reviewing git changes.
--
-- Started by the `gitdiffs` shell function with NVIM_APPNAME=gitdiffs, so it is
-- completely separate from any regular Neovim config. Linked as
-- ~/.config/gitdiffs; plugins are installed in ~/.local/share/gitdiffs and
-- pinned in lazy-lock.json next to this file.
--
--   diffview.nvim   changed-files tree + side-by-side diff (the Neovim standard)
--   telescope.nvim  fuzzy search (with the native fzf sorter)
--   github-nvim-theme, nvim-treesitter, lualine, nvim-web-devicons
--
-- Keys
--   Space f / Ctrl-p   find a changed file          Tab / Shift-Tab  next / prev file
--   Space /            search text in the changes   ]c / [c          next / prev change
--   Space s            search in the current file   Space e          show / hide files
--   g?                 every diffview key           q                quit
-- =============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ---- Bootstrap lazy.nvim (plugin manager) ----------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ---- Editor options ---------------------------------------------------------
local o = vim.opt
o.background = "dark"               -- set up front, so Neovim never has to ask the terminal
o.termguicolors = true
o.mouse = "a"                       -- click files, scroll, drag splits
o.number = true
o.cursorline = true
o.signcolumn = "no"
o.wrap = false
o.scrolloff = 6
o.laststatus = 3                    -- one statusline for the whole screen
o.showmode = false
o.ignorecase = true
o.smartcase = true
o.clipboard = "unnamedplus"
o.swapfile = false
o.shadafile = "NONE"
o.splitkeep = "screen"
o.timeoutlen = 400
o.fillchars = { diff = "╱", eob = " ", vert = "│", fold = " " }
o.diffopt:append({ "algorithm:histogram", "indent-heuristic", "linematch:60" })

-- Syntax parsers to install (global so install.sh can wait for them on a new Mac).
GITDIFFS_PARSERS = {
  "bash", "css", "diff", "dockerfile", "html", "javascript", "json", "lua",
  "markdown", "markdown_inline", "php", "prisma", "python", "scss", "sql",
  "toml", "tsx", "typescript", "vim", "yaml",
}

-- Side-by-side when there's room, stacked (old above new) on narrow windows.
local function diff_layout()
  return vim.o.columns >= 120 and "diff2_horizontal" or "diff2_vertical"
end

-- ---- Helpers shared by the search pickers -----------------------------------
local function toplevel()
  local root = vim.fn.systemlist({ "git", "rev-parse", "--show-toplevel" })[1]
  return (vim.v.shell_error == 0 and root) or vim.uv.cwd()
end

local function current_view()
  local ok, lib = pcall(require, "diffview.lib")
  return ok and lib.get_current_view() or nil
end

--- Paths (relative to the repo root) of every file in the open diff.
local function changed_files()
  local view, files, seen = current_view(), {}, {}
  if view and view.files then
    for _, entry in view.files:iter() do
      if entry.path and not seen[entry.path] then
        seen[entry.path] = true
        table.insert(files, entry.path)
      end
    end
  end
  table.sort(files)
  return files
end

--- Show a file in the diff, optionally jumping to a line in the new version.
local function open_in_diff(path, lnum)
  local view = current_view()
  if not view then return end
  pcall(function() view:set_file_by_path(path, true, true) end)
  if not lnum then return end
  vim.defer_fn(function()
    local layout = view.cur_layout
    local win = layout and layout.b and layout.b.id
    if win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_set_current_win(win)
      pcall(vim.api.nvim_win_set_cursor, win, { lnum, 0 })
      vim.cmd("normal! zz")
    end
  end, 150)
end

local function relative(path, root)
  return (path:sub(1, #root + 1) == root .. "/") and path:sub(#root + 2) or path
end

--- Telescope: fuzzy-find a changed file, preview it, open it in the diff.
local function find_changed_file()
  local files = changed_files()
  if #files == 0 then return vim.notify("No changed files", vim.log.levels.INFO) end
  local root = toplevel()
  local actions, state = require("telescope.actions"), require("telescope.actions.state")
  local conf = require("telescope.config").values
  require("telescope.pickers").new({ cwd = root }, {
    prompt_title = "Changed files",
    finder = require("telescope.finders").new_table({
      results = files,
      entry_maker = require("telescope.make_entry").gen_from_file({ cwd = root }),
    }),
    sorter = conf.file_sorter({}),
    previewer = conf.file_previewer({ cwd = root }),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then open_in_diff(entry.value) end
      end)
      return true
    end,
  }):find()
end

--- Telescope: live-search text across the changed files; Enter jumps the diff there.
local function grep_changes()
  local files = changed_files()
  if #files == 0 then return vim.notify("No changed files", vim.log.levels.INFO) end
  local root = toplevel()
  local actions, state = require("telescope.actions"), require("telescope.actions.state")
  require("telescope.builtin").live_grep({
    prompt_title = "Search text in changed files",
    cwd = root,
    search_dirs = vim.tbl_map(function(p) return root .. "/" .. p end, files),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        local entry = state.get_selected_entry()
        actions.close(prompt_bufnr)
        if entry then
          local file = entry.filename or entry.path or ""
          if file:sub(1, 1) ~= "/" then file = root .. "/" .. file end
          open_in_diff(relative(file, root), entry.lnum)
        end
      end)
      return true
    end,
  })
end

--- Telescope: fuzzy-search lines in the current file (like Telescope's `/`).
local function search_this_file()
  require("telescope.builtin").current_buffer_fuzzy_find({
    prompt_title = "Search this file",
    previewer = false,
    layout_config = { width = 0.7, height = 0.6 },
  })
end

-- ---- Folder dividers in the changed-files tree -------------------------------
-- diffview has no option for this, so a thin horizontal rule is drawn (as a
-- virtual line, so the tree itself is untouched) above every top-level folder
-- and above root-level files that follow a folder.
-- Nerd Font icons, written as UTF-8 byte escapes so editors can't drop them.
local ICON = {
  folder_closed = "\238\151\191",   -- U+E5FF
  folder_open   = "\238\151\190",   -- U+E5FE
  chevron_right = "\239\145\160",   -- U+F460
  chevron_down  = "\239\145\188",   -- U+F47C
  search        = "\239\128\130",   -- U+F002
  round_left    = "\238\130\180",   -- U+E0B4
  round_right   = "\238\130\182",   -- U+E0B6
  dot           = "\226\151\143",   -- U+25CF ●
  lock          = "\239\128\163",   -- U+F023
}
local FOLDER_ICONS = { ICON.folder_closed, ICON.folder_open }
local HEADER = "^%s*%a[%a ]*%(%d+%)%s*$"            -- "Changes (4)", "Staged changes (2)"
local rule_ns = vim.api.nvim_create_namespace("gitdiffs_folder_rules")

local function is_folder(line)
  for _, icon in ipairs(FOLDER_ICONS) do
    if line:find(icon, 1, true) then return true end
  end
  return false
end

local function draw_folder_rules(buf)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  vim.api.nvim_buf_clear_namespace(buf, rule_ns, 0, -1)
  local win = vim.fn.bufwinid(buf)
  local width = win ~= -1 and vim.api.nvim_win_get_width(win) or 40
  local rule = { { { string.rep("─", width), "GitdiffsFolderRule" } } }

  -- Tree lines look like "M   <icon> web" / "M      <icon> page.tsx": a git status,
  -- then indentation that grows with depth. Only lines inside a section
  -- ("Changes (4)", ...) are entries; the root path and help line above are not.
  local in_section, base, prev_indent = false, nil, nil
  for i, line in ipairs(vim.api.nvim_buf_get_lines(buf, 0, -1, false)) do
    if line:match(HEADER) then
      in_section, base, prev_indent = true, nil, nil
    elseif line:match("^%s*$") then
      in_section = false
    elseif in_section then
      local rest = line:gsub("^%s*[%u%?!]+%s", "", 1)    -- drop the status column
      local folder = is_folder(line)
      -- Folders start with a 2-column expand arrow where files have 2 spaces,
      -- so subtract those from files to get comparable nesting levels.
      local indent = #rest:match("^%s*") - (folder and 0 or 2)
      base = base or indent
      -- A new group starts when we come back up to (or level with) the depth of
      -- the previous entry: a folder after another folder's contents, or a
      -- root-level file after a folder.
      local new_group = prev_indent and (
        (folder and prev_indent >= indent) or (not folder and indent == base and prev_indent > indent)
      )
      if new_group then
        vim.api.nvim_buf_set_extmark(buf, rule_ns, i - 1, 0, { virt_lines = rule, virt_lines_above = true })
      end
      prev_indent = indent
    end
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "DiffviewFiles",
  callback = function(ev)
    local pending = false
    local function redraw()
      if pending then return end
      pending = true
      vim.schedule(function() pending = false; draw_folder_rules(ev.buf) end)
    end
    vim.api.nvim_buf_attach(ev.buf, false, { on_lines = function() redraw() end })
    redraw()
  end,
})
vim.api.nvim_create_autocmd({ "WinResized", "VimResized" }, {
  callback = function()
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "DiffviewFiles" then
        draw_folder_rules(buf)
      end
    end
  end,
})

-- ---- Plugins -------------------------------------------------------------------
require("lazy").setup({
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      require("github-theme").setup({
        options = { darken = { floats = true, sidebars = { enable = true, list = { "DiffviewFiles" } } } },
      })
      vim.cmd.colorscheme("github_dark_default")
      vim.api.nvim_set_hl(0, "GitdiffsFolderRule", { link = "WinSeparator" })
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install(GITDIFFS_PARSERS)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(ev) pcall(vim.treesitter.start, ev.buf) end,
      })
    end,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          prompt_prefix = "  " .. ICON.search .. "  ",
          selection_caret = "▍ ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top", width = 0.9, height = 0.85, preview_width = 0.55 },
          path_display = { "truncate" },
          mappings = { i = { ["<Esc>"] = require("telescope.actions").close } },
        },
      })
      pcall(telescope.load_extension, "fzf")
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          section_separators = { left = ICON.round_left, right = ICON.round_right },
          component_separators = { left = "│", right = "│" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch" },
          lualine_c = { { "filename", path = 1, symbols = { modified = " " .. ICON.dot, readonly = " " .. ICON.lock } } },
          lualine_x = { function() return "␣f files  ␣/ search  ␣s in file  ⇥ next  g? keys  q quit" end },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  {
    "sindrets/diffview.nvim",
    lazy = false,
    config = function()
      local actions = require("diffview.actions")
      local quit = { "n", "q", "<Cmd>qa<CR>", { desc = "Quit gitdiffs" } }
      require("diffview").setup({
        enhanced_diff_hl = true,
        show_help_hints = true,
        icons = { folder_closed = FOLDER_ICONS[1], folder_open = FOLDER_ICONS[2] },
        signs = { fold_closed = ICON.chevron_right, fold_open = ICON.chevron_down, done = "✓" },
        view = {
          default = { layout = diff_layout(), winbar_info = true },
          merge_tool = { layout = "diff3_horizontal" },
          file_history = { layout = diff_layout() },
        },
        file_panel = {
          listing_style = "tree",
          tree_options = { flatten_dirs = true, folder_statuses = "always" },
          win_config = { position = "left", width = 38 },
        },
        keymaps = {
          view = { quit, { "n", "<leader>e", actions.toggle_files, { desc = "Show / hide the file panel" } } },
          file_panel = { quit },
          file_history_panel = { quit },
        },
      })
    end,
  },
}, {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  install = { colorscheme = { "github_dark_default" } },
  checker = { enabled = false },
  change_detection = { enabled = false },
  rocks = { enabled = false },
  ui = { border = "rounded" },
})

-- ---- Keys --------------------------------------------------------------------
local map = vim.keymap.set
map("n", "<leader>f", find_changed_file, { desc = "Find a changed file" })
map("n", "<C-p>", find_changed_file, { desc = "Find a changed file" })
map("n", "<leader>/", grep_changes, { desc = "Search text in changed files" })
map("n", "<leader>s", search_this_file, { desc = "Search in this file" })
map("n", "q", "<Cmd>qa<CR>", { desc = "Quit gitdiffs" })
