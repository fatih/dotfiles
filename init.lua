-- Enable Lua module caching for faster startup
vim.loader.enable()

-- Set leader key early (before any mappings)
vim.g.mapleader = ','

-- Disable netrw (we use nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- vim-go settings (must be set before plugin loads)
vim.g['go_gopls_enabled'] = 0
vim.g['go_code_completion_enabled'] = 0
vim.g['go_fmt_autosave'] = 0
vim.g['go_imports_autosave'] = 0
vim.g['go_mod_fmt_autosave'] = 0
vim.g['go_doc_keywordprg_enabled'] = 0
vim.g['go_def_mapping_enabled'] = 0
vim.g['go_textobj_enabled'] = 0
vim.g['go_list_type'] = 'quickfix'

-- run :GoBuild or :GoTestCompile based on the go file
local function build_go_files()
  if vim.endswith(vim.api.nvim_buf_get_name(0), "_test.go") then
    vim.cmd("GoTestCompile")
  else
    vim.cmd("GoBuild")
  end
end

-- Hook: run TSUpdate when nvim-treesitter is installed/updated
vim.api.nvim_create_autocmd('PackChanged', { callback = function(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == 'nvim-treesitter' and (kind == 'install' or kind == 'update') then
    if not ev.data.active then vim.cmd.packadd('nvim-treesitter') end
    vim.cmd('TSUpdate')
  end
end })

----------------
--- plugins ---
----------------
vim.pack.add({
  'https://github.com/ellisonleao/gruvbox.nvim',
  'https://github.com/cormacrelf/dark-notify',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/fatih/vim-go',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
  'https://github.com/bronson/vim-visual-star-search',
  'https://github.com/dinhhuy258/git.nvim',
  'https://github.com/nvim-tree/nvim-tree.lua',
  'https://github.com/AndrewRadev/splitjoin.vim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/coder/claudecode.nvim',
  { src = 'https://github.com/sourcegraph/amp.nvim', version = 'main' },
  'https://github.com/brianhuster/live-preview.nvim',
  'https://github.com/folke/snacks.nvim',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/elanmed/fzf-lua-frecency.nvim',
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/hrsh7th/nvim-cmp',
  'https://github.com/hrsh7th/cmp-nvim-lsp',
  'https://github.com/hrsh7th/cmp-buffer',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/saadparwaiz1/cmp_luasnip',
  'https://github.com/onsails/lspkind-nvim',
  'https://github.com/lukas-reineke/cmp-under-comparator',
  'https://github.com/rafamadriz/friendly-snippets',
})

--------------------------
--- plugin configs ---
--------------------------

-- Colorscheme
require("gruvbox").setup({ contrast = "hard" })
vim.cmd([[colorscheme gruvbox]])

-- Automatic dark mode (requires: brew install cormacrelf/tap/dark-notify)
require("dark_notify").run()

-- Statusline
require("lualine").setup({
  options = { theme = 'gruvbox' },
  sections = {
    lualine_b = {
      'branch',
      function() return vim.lsp.status() end, -- built-in LSP progress (Neovim 0.12)
    },
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 2 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    }
  }
})

-- Treesitter highlighting (Neovim 0.12 native — no more nvim-treesitter.configs)
-- Parsers must be installed once: :TSInstall go gomod proto lua vimdoc vim bash fish json markdown markdown_inline mermaid
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter_start', { clear = true }),
  callback = function(args)
    -- Skip large files
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
    if ok and stats and stats.size > max_filesize then
      return
    end
    pcall(vim.treesitter.start, args.buf)
  end,
})

-- Treesitter textobjects (new API — explicit keymaps)
require("nvim-treesitter-textobjects").setup({
  select = { lookahead = true },
  move = { set_jumps = true },
})

local ts_select = require("nvim-treesitter-textobjects.select")
local function select_textobject(query)
  return function() ts_select.select_textobject(query, "textobjects") end
end

vim.keymap.set({ "x", "o" }, "aa", select_textobject("@parameter.outer"))
vim.keymap.set({ "x", "o" }, "ia", select_textobject("@parameter.inner"))
vim.keymap.set({ "x", "o" }, "af", select_textobject("@function.outer"))
vim.keymap.set({ "x", "o" }, "if", select_textobject("@function.inner"))
vim.keymap.set({ "x", "o" }, "ac", select_textobject("@class.outer"))
vim.keymap.set({ "x", "o" }, "ic", select_textobject("@class.inner"))
vim.keymap.set({ "x", "o" }, "iB", select_textobject("@block.inner"))
vim.keymap.set({ "x", "o" }, "aB", select_textobject("@block.outer"))

local ts_move = require("nvim-treesitter-textobjects.move")
vim.keymap.set({ "n", "x", "o" }, "]]", function() ts_move.goto_next_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "][", function() ts_move.goto_next_end("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[[", function() ts_move.goto_previous_start("@function.outer", "textobjects") end)
vim.keymap.set({ "n", "x", "o" }, "[]", function() ts_move.goto_previous_end("@function.outer", "textobjects") end)

local ts_swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "<leader>sn", function() ts_swap.swap_next("@parameter.inner") end)
vim.keymap.set("n", "<leader>sp", function() ts_swap.swap_previous("@parameter.inner") end)

-- Incremental selection: Neovim 0.12 built-in — use v then an/in/]n/[n
-- (replaces old <space>/<bs>/<tab> keymaps from nvim-treesitter)

-- Git
require("git").setup()

-- File explorer
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  filters = { dotfiles = true },
  on_attach = function(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
    vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
    vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
  end
})

-- Autopairs
local npairs = require("nvim-autopairs")
npairs.setup { check_ts = true }
npairs.remove_rule('`')

-- Claude Code
require("claudecode").setup({
  terminal_cmd = "/Users/fatih/.local/bin/claude",
  terminal = { provider = "none" },
})

-- Amp
require("amp").setup({ auto_start = true, log_level = "info" })

-- FZF
require("fzf-lua").register_ui_select()
require('fzf-lua').setup {
  oldfiles = {
    include_current_session = true,
  },
  winopts = {
    backdrop = 100,
    border = "single",
    preview = {
      hidden = true,
      default = "bat",
      border = "rounded",
      title = false,
      layout = "vertical",
      horizontal = "right:50%",
    },
  },
  git = {
    files = {
      cwd_header = false,
      prompt        = '❯ ',
      cmd           = 'git ls-files --exclude-standard',
      multiprocess  = true,
      git_icons     = false,
      file_icons    = false,
      color_icons   = false,
    },
  },
  files = {
    git_files = false,
    cwd_header = false,
    cwd_prompt = true,
    file_icons = false,
  }
}
require('fzf-lua-frecency').setup()

-- Lazydev (Lua LSP config helper)
require("lazydev").setup({})

-- Snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Autocompletion
local cmp = require("cmp")
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local types = require("cmp.types")
local compare = require("cmp.config.compare")
local cmp_autopairs = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
luasnip.config.setup {}

local modified_priority = {
  [types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
  [types.lsp.CompletionItemKind.Snippet] = 0, -- top
  [types.lsp.CompletionItemKind.Keyword] = 0, -- top
  [types.lsp.CompletionItemKind.Text] = 100, -- bottom
}

local function modified_kind(kind)
  return modified_priority[kind] or kind
end

cmp.setup({
  preselect = false,
  completion = {
    completeopt = "menu,menuone,preview,noselect",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
      },
    },
  },
  sorting = {
    priority_weight = 1.0,
    comparators = {
      compare.offset,
      compare.exact,
      compare.score,
      compare.locality,
      function(entry1, entry2) -- sort by length ignoring "=~"
        local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()_]", ""))
        local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()_]", ""))
        if len1 ~= len2 then
          return len1 - len2 < 0
        end
      end,
      compare.recently_used,
      function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
        local kind1 = modified_kind(entry1:get_kind())
        local kind2 = modified_kind(entry2:get_kind())
        if kind1 ~= kind2 then
          return kind1 - kind2 < 0
        end
      end,
      require("cmp-under-comparator").under,
      compare.kind,
    },
  },
  matching = {
    disallow_fuzzy_matching = true,
    disallow_fullfuzzy_matching = true,
    disallow_partial_fuzzy_matching = true,
    disallow_partial_matching = false,
    disallow_prefix_unmatching = true,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  window = {
    documentation = cmp.config.window.bordered({ border = 'rounded' }),
    completion = cmp.config.window.bordered({ border = 'rounded' }),
  },
  view = {
    entries = {
      name = "custom",
      selection_order = "near_cursor",
    },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Insert,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = "luasnip", keyword_length = 2},
    { name = "buffer", keyword_length = 5},
  },
  performance = {
    max_view_entries = 20,
  },
})

----------------
--- LSP Setup (Neovim 0.12 native) ---
----------------

-- Get capabilities from cmp-nvim-lsp for better completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

-- gopls (install: go install golang.org/x/tools/gopls@latest)
vim.lsp.config('gopls', {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  root_markers = { 'go.mod', 'go.work', '.git' },
  capabilities = capabilities,
})

-- lua-language-server (install: brew install lua-language-server)
vim.lsp.config('lua_ls', {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc', '.stylua.toml', 'stylua.toml', '.git' },
  capabilities = capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
})

-- Enable the LSP servers
vim.lsp.enable({ 'gopls', 'lua_ls' })

----------------
--- SETTINGS ---
----------------

vim.opt.termguicolors = true -- Enable 24-bit RGB colors

vim.opt.number = true        -- Show line numbers
vim.opt.showmatch = true     -- Highlight matching parenthesis
vim.opt.splitright = true    -- Split windows right to the current windows
vim.opt.splitbelow = true    -- Split windows below to the current windows
vim.opt.autowrite = true     -- Automatically save before :next, :make etc.
vim.opt.autochdir = true     -- Change CWD when I open a file

vim.opt.mouse = 'a'                -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'  -- Copy/paste to system clipboard
vim.opt.swapfile = false           -- Don't use swapfile
vim.opt.ignorecase = true          -- Search case insensitive...
vim.opt.smartcase = true           -- ... but not it begins with upper case
vim.opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options
vim.opt.pumborder = 'rounded'  -- Neovim 0.12: border on popup menus

vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "undo"

-- Indent Settings
-- I'm in the Spaces camp (sorry Tabs folks), so I'm using a combination of
-- settings to insert spaces all the time.
vim.opt.expandtab = true  -- expand tabs into spaces
vim.opt.shiftwidth = 2    -- number of spaces to use for each step of indent.
vim.opt.tabstop = 2       -- number of spaces a TAB counts for
vim.opt.autoindent = true -- copy indent from current line when starting a new line
vim.opt.wrap = true

----------------
--- KEYMAPS ---
----------------

-- Fast saving
vim.keymap.set('n', '<Leader>w', ':write!<CR>')
vim.keymap.set('n', '<Leader>q', ':q!<CR>', { silent = true })

-- Some useful quickfix shortcuts for quickfix
vim.keymap.set('n', '<C-n>', '<cmd>cnext<CR>zz')
vim.keymap.set('n', '<C-m>', '<cmd>cprev<CR>zz')
vim.keymap.set('n', '<leader>a', '<cmd>cclose<CR>')

-- Exit on jj and jk
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Exit on jj and jk
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('i', 'jk', '<ESC>')

-- Copy current filepath to system clipboard (relative to git root, fallback to absolute path)
vim.keymap.set('n', '<Leader>e', function()
  local git_prefix = vim.fn.system('git rev-parse --show-prefix'):gsub('\n', '')
  local path
  if vim.v.shell_error == 0 then
    path = git_prefix .. vim.fn.expand('%')
  else
    path = vim.fn.expand('%:p')
  end
  vim.fn.setreg('+', path)
  print('Copied to clipboard: ' .. path)
end, { silent = true })

-- Copy absolute filepath to system clipboard
vim.keymap.set('n', '<Leader>r', function()
  local path = vim.fn.expand('%:p')
  vim.fn.setreg('+', path)
  print('Copied to clipboard: ' .. path)
end, { silent = true })

-- Remove search highlight
vim.keymap.set('n', '<Leader><space>', ':nohlsearch<CR>')

-- Search mappings: These will make it so that going to the next one in a
-- search will center on the line it's found in.
vim.keymap.set('n', 'n', 'nzzzv', {noremap = true})
vim.keymap.set('n', 'N', 'Nzzzv', {noremap = true})

-- Don't jump forward if I higlight and search for a word
local function stay_star()
  local sview = vim.fn.winsaveview()
  local args = string.format("keepjumps keeppatterns execute %q", "sil normal! *")
  vim.api.nvim_command(args)
  vim.fn.winrestview(sview)
end
vim.keymap.set('n', '*', stay_star, {noremap = true, silent = true})

-- We don't need this keymap, but here we are. If I do a ctrl-v and select
-- lines vertically, insert stuff, they get lost for all lines if we use
-- ctrl-c, but not if we use ESC. So just let's assume Ctrl-c is ESC.
vim.keymap.set('i', '<C-c>', '<ESC>')

-- If I visually select words and paste from clipboard, don't replace my
-- clipboard with the selected word, instead keep my old word in the
-- clipboard
vim.keymap.set("x", "p", "\"_dP")

-- Better split switching
vim.keymap.set('', '<C-j>', '<C-W>j')
vim.keymap.set('', '<C-k>', '<C-W>k')
vim.keymap.set('', '<C-h>', '<C-W>h')
vim.keymap.set('', '<C-l>', '<C-W>l')

-- Terminal mode window switching
vim.keymap.set('t', '<C-h>', '<C-\\><C-N><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l')

-- Visual linewise up and down by default (and use gj gk to go quicker)
vim.keymap.set('n', '<Up>', 'gk')
vim.keymap.set('n', '<Down>', 'gj')

-- Yanking a line should act like D and C
vim.keymap.set('n', 'Y', 'y$')

-- FZF keymaps
vim.keymap.set("n", "<C-p>", function()
  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    git_root = vim.fn.getcwd()
  end
  require('fzf-lua-frecency').frecency({
    file_icons = false,
    git_icons = false,
    cwd_only = true,
    cwd = git_root,
  })
end, {})
vim.keymap.set("n", "<C-b>", require("fzf-lua").files, {})
vim.keymap.set("n", "<C-g>", require("fzf-lua").lsp_document_symbols, {})

-- Claude Code keymaps
vim.keymap.set('n', '<C-t>', '<cmd>ClaudeCode<cr>', { desc = "Toggle Claude" })
vim.keymap.set('n', '<leader>cf', '<cmd>ClaudeCodeFocus<cr>', { desc = "Focus Claude" })
vim.keymap.set('n', '<leader>cr', '<cmd>ClaudeCode --resume<cr>', { desc = "Resume Claude" })
vim.keymap.set('n', '<leader>cC', '<cmd>ClaudeCode --continue<cr>', { desc = "Continue Claude" })
vim.keymap.set('n', '<leader>cm', '<cmd>ClaudeCodeSelectModel<cr>', { desc = "Select Claude model" })
vim.keymap.set('n', '<leader>ca', '<cmd>ClaudeCodeAdd %<cr>', { desc = "Add current buffer" })
vim.keymap.set('v', '<leader>cs', '<cmd>ClaudeCodeSend<cr>', { desc = "Send to Claude" })
vim.keymap.set('n', '<leader>da', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = "Accept diff" })
vim.keymap.set('n', '<leader>dd', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = "Deny diff" })

-- git.nvim
vim.keymap.set('n', '<leader>gb', '<CMD>lua require("git.blame").blame()<CR>')
vim.keymap.set('n', '<leader>go', "<CMD>lua require('git.browse').open(false)<CR>")
vim.keymap.set('x', '<leader>go', ":<C-u> lua require('git.browse').open(true)<CR>")

-- old habits
vim.api.nvim_create_user_command("GBrowse", 'lua require("git.browse").open(true)<CR>', {
  range = true,
  bang = true,
  nargs = "*",
})

-- File-tree mappings
vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>f', ':NvimTreeFindFileToggle!<CR>', { noremap = true })

-- vim-go
vim.keymap.set('n', '<leader>b', build_go_files)
vim.api.nvim_create_user_command("A", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'edit'})<CR>", {})
vim.api.nvim_create_user_command("AV", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'vsplit'})<CR>", {})
vim.api.nvim_create_user_command("AS", ":lua vim.api.nvim_call_function('go#alternate#Switch', {true, 'split'})<CR>", {})

-- Amp mapping
vim.keymap.set('n', '<leader>ab', '<cmd>AmpBuffer<cr>', { desc = "Create Amp buffer" })
vim.keymap.set('x', '<leader>ab', ":'<,'>AmpBuffer<CR>", { desc = "Create Amp buffer from selection" })
vim.keymap.set('n', '<leader>as', '<cmd>AmpSendBuffer<cr>', { desc = "Send buffer to Amp" })
vim.keymap.set('v', '<leader>as', ":'<,'>AmpPromptRef<CR>", { desc = "Send selection to Prompt" })
vim.keymap.set('x', '<leader>aa', ":'<,'>AmpAppendBuffer<CR>", { desc = "Append selection to Amp buffer" })

--------------------
--- AUTOCOMMANDS ---
--------------------

-- Ghostty title
if vim.fn.getenv("TERM_PROGRAM") == "ghostty" then
  vim.opt.title = true

  local function update_title()
    local root = vim.fn.systemlist('git rev-parse --show-toplevel 2>/dev/null')
    if vim.v.shell_error == 0 and #root > 0 and root[1] ~= '' then
      vim.opt.titlestring = vim.fn.fnamemodify(root[1], ':t')
    else
      vim.opt.titlestring = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    end
  end

  update_title()

  vim.api.nvim_create_autocmd({'DirChanged', 'VimEnter'}, {
    callback = update_title,
  })
end

-- Open help window in a vertical split to the right.
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})

-- Go uses gofmt, which uses tabs for indentation and spaces for aligment.
-- Hence override our indentation rules.
vim.api.nvim_create_autocmd('Filetype', {
  group = vim.api.nvim_create_augroup('setIndent', { clear = true }),
  pattern = { 'go' },
  command = 'setlocal noexpandtab tabstop=4 shiftwidth=4'
})

-- automatically resize all vim buffers if I resize the terminal window
vim.api.nvim_command('autocmd VimResized * wincmd =')

-- OSC 7: Report working directory to terminal (for Ghostty split inheritance)
-- https://github.com/neovim/neovim/issues/21771
local function osc7_notify()
  local cwd = vim.fn.getcwd()
  -- If inside a .git directory, report the parent instead
  if cwd:match('/.git$') or cwd:match('/.git/') then
    cwd = cwd:gsub('/.git.*$', '')
  end
  -- Omit hostname for simpler parsing by tmux (file:///path instead of file://hostname/path)
  local osc7 = string.format("\027]7;file://%s\007", cwd)
  vim.fn.chansend(vim.v.stderr, osc7)
end

local osc7_group = vim.api.nvim_create_augroup('osc7', { clear = true })

vim.api.nvim_create_autocmd('DirChanged', {
  group = osc7_group,
  pattern = { '*' },
  callback = osc7_notify,
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = osc7_group,
  pattern = { '*' },
  callback = osc7_notify,
})

vim.api.nvim_create_autocmd('VimEnter', {
  group = osc7_group,
  pattern = { '*' },
  callback = osc7_notify,
})

-- Note: We intentionally don't clear OSC 7 on VimLeave.
-- The shell (fish) will report its own working directory after Vim exits.
-- Sending an empty OSC 7 here causes Ghostty to lose track of the CWD.

-- put quickfix window always to the bottom
local qfgroup = vim.api.nvim_create_augroup('changeQuickfix', { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qfgroup,
  command = 'wincmd J',
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'qf',
  group = qfgroup,
  command = 'setlocal wrap',
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- disable diagnostics, I didn't like them
vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  underline = false,
  update_in_insert = false,
})

-- Run gofmt/gofmpt, import packages automatically on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('setGoFormatting', { clear = true }),
  pattern = '*.go',
  callback = function()
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end

    vim.lsp.buf.format()
  end
})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }

    vim.keymap.set('n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', '<leader>v', "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", opts)
    vim.keymap.set('n', '<leader>s', "<cmd>belowright split | lua vim.lsp.buf.definition()<CR>", opts)

    vim.keymap.set('n', 'gr', function()
      vim.lsp.buf.references(nil, {
        on_list = function(options)
          vim.fn.setqflist({}, ' ', options)
          if #options.items > 0 then
            vim.cmd('copen')
            vim.cmd('cfirst')
            vim.cmd('normal! zz')
          end
        end
      })
    end, opts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    -- Neovim 0.12 defaults provide: gri (implementation), grx (codelens), grn (rename)
  end,
})

--------------------------
--- Amp user commands ---
--------------------------

-- Add selected text directly to prompt
vim.api.nvim_create_user_command("AmpPromptSelection", function(opts)
  local lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  local text = table.concat(lines, "\n")

  local amp_message = require("amp.message")
  amp_message.send_to_prompt(text)
end, {
  range = true,
  desc = "Add selected text to Amp prompt",
})

-- Add file+selection reference to prompt
vim.api.nvim_create_user_command("AmpPromptRef", function(opts)
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    print("Current buffer has no filename")
    return
  end

  local relative_path = vim.fn.fnamemodify(bufname, ":.")
  local ref = "@" .. relative_path
  if opts.line1 ~= opts.line2 then
    ref = ref .. "#L" .. opts.line1 .. "-" .. opts.line2
  elseif opts.line1 > 1 then
    ref = ref .. "#L" .. opts.line1
  end

  local amp_message = require("amp.message")
  amp_message.send_to_prompt(ref)
end, {
  range = true,
  desc = "Add file reference (with selection) to Amp prompt",
})

vim.api.nvim_create_user_command("AmpMessage", function(opts)
  local message = opts.args
  if message == "" then
    print("Please provide a message to send")
    return
  end

  local amp_message = require("amp.message")
  amp_message.send_message(message)
end, {
  nargs = "*",
  desc = "Send a message to Amp",
})

-- Open new scratch buffer for Amp prompts
vim.api.nvim_create_user_command("AmpBuffer", function(opts)
  local lines = {}
  local has_range = (opts.range > 0) and (opts.line2 > 0) and (opts.line2 >= opts.line1)
  if has_range then
    lines = vim.api.nvim_buf_get_lines(0, opts.line1 - 1, opts.line2, false)
  end

  local existing_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) then
      local buf_name = vim.api.nvim_buf_get_name(buf)
      if buf_name:match("amp%-scratch$") then
        existing_buf = buf
        break
      end
    end
  end

  local target_buf
  if existing_buf then
    local existing_win = nil
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == existing_buf then
        existing_win = win
        break
      end
    end

    if existing_win then
      vim.api.nvim_set_current_win(existing_win)
    else
      vim.cmd("vsplit")
      vim.api.nvim_win_set_buf(0, existing_buf)
    end

    if #lines > 0 then
      local existing_lines = vim.api.nvim_buf_get_lines(existing_buf, 0, -1, false)
      if #existing_lines > 0 and existing_lines[#existing_lines] ~= "" then
        table.insert(existing_lines, "")
      end
      for _, line in ipairs(lines) do
        table.insert(existing_lines, line)
      end
      vim.api.nvim_buf_set_lines(existing_buf, 0, -1, false, existing_lines)
    end
    target_buf = existing_buf
  else
    vim.cmd("vsplit")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_win_set_buf(0, buf)
    vim.bo[buf].buftype = "nofile"
    vim.bo[buf].bufhidden = "hide"
    vim.bo[buf].swapfile = false
    vim.api.nvim_buf_set_name(buf, "amp-scratch")

    if #lines > 0 then
      vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    end
    target_buf = buf
  end

  local current_lines = vim.api.nvim_buf_get_lines(target_buf, 0, -1, false)
  if #current_lines > 0 and current_lines[1] ~= "" then
    vim.api.nvim_buf_set_lines(target_buf, -1, -1, false, { "", "" })
  end
  local line_count = vim.api.nvim_buf_line_count(target_buf)
  vim.api.nvim_win_set_cursor(0, { line_count, 0 })
end, {
  nargs = 0,
  desc = "Open scratch buffer for Amp prompts",
  range = true,
})

-- Send entire buffer contents and close the buffer
vim.api.nvim_create_user_command("AmpSendBuffer", function(opts)
  local buf = vim.api.nvim_get_current_buf()
  local buf_name = vim.api.nvim_buf_get_name(buf)

  if not buf_name:match("amp%-scratch$") then
    print("AmpSendBuffer can only be used in amp-scratch buffers")
    return
  end

  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local content = table.concat(lines, "\n")

  if content:match("^%s*$") then
    print("Buffer is empty, nothing to send")
    return
  end

  local amp = require("amp")
  if not amp.state.server then
    print("Amp server is not running - start it first with :AmpStart")
    return
  end

  local server_status = amp.state.server.get_status and amp.state.server.get_status()
  if not server_status or server_status.client_count == 0 then
    print("No Amp clients connected")
    return
  end

  local should_close_buffer = false
  local amp_message = require("amp.message")

  local success = amp_message.send_message(content)

  if success then
    should_close_buffer = true
    print("Message sent to Amp")
  else
    print("Failed to send to Amp - connection failed")
  end

  if should_close_buffer then
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
    vim.api.nvim_buf_delete(buf, { force = true })
  end
end, {
  nargs = "?",
  desc = "Send current buffer contents to Amp",
})

-- Append selected lines to amp-scratch buffer in @filename#L12-46 format
vim.api.nvim_create_user_command("AmpAppendBuffer", function(opts)
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname == "" then
    print("Current buffer has no filename")
    return
  end

  local relative_path = vim.fn.fnamemodify(bufname, ":.")
  local ref = "@" .. relative_path
  if opts.line1 ~= opts.line2 then
    ref = ref .. "#L" .. opts.line1 .. "-" .. opts.line2
  elseif opts.line1 > 1 then
    ref = ref .. "#L" .. opts.line1
  end

  local scratch_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match("amp%-scratch$") then
      scratch_buf = buf
      break
    end
  end

  if not scratch_buf then
    print("No amp-scratch buffer found")
    return
  end

  local scratch_lines = vim.api.nvim_buf_get_lines(scratch_buf, 0, -1, false)
  if #scratch_lines == 0 then
    table.insert(scratch_lines, ref)
  else
    scratch_lines[#scratch_lines] = scratch_lines[#scratch_lines] .. " " .. ref
  end
  vim.api.nvim_buf_set_lines(scratch_buf, 0, -1, false, scratch_lines)

  print("Appended " .. ref .. " to amp-scratch buffer")
end, {
  range = true,
  desc = "Add file reference (with selection) to amp-scratch buffer",
})
