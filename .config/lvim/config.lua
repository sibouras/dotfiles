-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general
lvim.format_on_save = false
lvim.lint_on_save = false
lvim.lang.javascript.formatters = {
  { exe = "prettier" },
}
lvim.lang.javascriptreact.formatters = lvim.lang.javascript.formatters

lvim.colorscheme = "spacegray"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
vim.opt.timeoutlen = 200

-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = ""

-- add your own keymapping
lvim.keys.normal_mode = {
  ["<C-s>"] = ":w<cr>",
  ["Y"] = "y$",
  ["<leader><tab>"] = "<C-^>",

  -- fix buffer navigation
  ["]b"] = ":BufferNext<cr>",
  ["[b"] = ":BufferPrevious<cr>",
  ["<S-h>"] = "H",
  ["<S-l>"] = "L",

  -- Better window navigation
  ["<C-h>"] = "<C-w>h",
  ["<C-j>"] = "<C-w>j",
  ["<C-k>"] = "<C-w>k",
  ["<C-l>"] = "<C-w>l",
}

lvim.keys.insert_mode= {
  -- ctrl-z to undo
  ["<C-z>"] = "<c-o>:u<CR>",

  -- undo break points
  [ "," ] = ",<c-g>u",
  [ "." ] = ".<c-g>u",
  [ "!" ] = "!<c-g>u",
  [ "?" ] = "?<c-g>u",

}

-- Map Ctrl-Backspace to delete the previous word in insert mode.
lvim.keys.insert_mode["<M-BS>"] = "<C-w>"
vim.cmd("cmap <M-BS> <C-W>")
-- Ctrl-Backspace in windows terminal(not the same key: showkey -a)
vim.cmd("imap <C-h> <C-W>")
vim.cmd("cmap <C-h> <C-W>")

-- jumplit mutations
vim.cmd("nnoremap <expr> j (v:count > 5 ? \"m'\" . v:count : \"\") . 'j'")
vim.cmd("nnoremap <expr> k (v:count > 5 ? \"m'\" . v:count : \"\") . 'k'")

-- df to escape
lvim.builtin.which_key.setup.triggers_blacklist = {
    n = {"d"},
    i = { "j", "k", "d" },
    v = { "j", "k" },
  }
lvim.keys.insert_mode["df"]="<ESC>"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnosticss" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnosticss" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.dashboard.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.side = "left"
lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {}
lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings
-- you can set a custom on_attach function that will be used for all the language servers
-- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- set a formatter if you want to override the default lsp one (if it exists)
-- lvim.lang.python.formatters = {
--   {
--     exe = "black",
--     args = {}
--   }
-- }
-- set an additional linter
-- lvim.lang.python.linters = {
--   {
--     exe = "flake8",
--     args = {}
--   }
-- }


-- Whichkey
lvim.builtin.which_key.mappings.l.o = { "<cmd>SymbolsOutline<cr>", "Outline" }
lvim.builtin.which_key.mappings.f = { "<cmd>lua require('lir.float').toggle()<cr>", "Files" }

-- Telescope
lvim.builtin.telescope.on_config_done = function()
  local actions = require "telescope.actions"
  lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = actions.move_selection_next
  lvim.builtin.telescope.defaults.mappings.i["<C-k>"] = actions.move_selection_previous
  lvim.builtin.telescope.defaults.mappings.i["<C-n>"] = actions.cycle_history_next
  lvim.builtin.telescope.defaults.mappings.i["<C-p>"] = actions.cycle_history_prev
end

-- Additional Plugins
lvim.plugins = {
  -- {"folke/tokyonight.nvim"},
  {"tpope/vim-unimpaired"},
  {"tpope/vim-repeat"},
  {"tpope/vim-surround"},
  {"romainl/vim-cool"},
  {"michaeljsmith/vim-indent-object"},
  {
    'mattn/emmet-vim',
    config = function ()
      vim.cmd("let g:user_emmet_mode='a'") --enable all function in all mode.
      vim.cmd("let g:user_emmet_leader_key=','")
      vim.cmd("let g:user_emmet_install_global = 0")
      -- vim.cmd("autocmd FileType html,css,javascript EmmetInstall")
      vim.cmd("autocmd FileType html,css EmmetInstall")
    end,
  },
  {
    "ggandor/lightspeed.nvim",
    event = "BufRead",
  },
  {
    "tamago324/lir.nvim",
    config = function()
      require "user.lir"
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    config = function()
      require("user.lsp_signature").config()
    end,
  },
  {
    "abecodes/tabout.nvim",
    config = function()
      require("user.tabout").config()
    end,
    wants = { "nvim-treesitter" }, -- or require if not used so far
    after = { "nvim-compe", "vim-vsnip" }, -- if a completion plugin is using tabs load it before
  },
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
  },
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("user.neoscroll").config()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("user.colorizer").config()
    end,
  },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
