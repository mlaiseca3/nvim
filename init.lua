
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)
vim.keymap.set('n', '<leader>t', vim.cmd.tabnew)
vim.keymap.set('n', 'gx', [[<CMD>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>]])
vim.keymap.set('n', '<leader>o', [[<CMD>browse oldfiles <CR>]])
vim.keymap.set('n', 'gd', [[<CMD> lua vim.lsp.buf.definition() <CR>]])
vim.keymap.set('n', 'gD', [[<CMD> lua vim.lsp.buf.declaration() <CR>]])
vim.keymap.set('n', '<leader>w', [[<CMD> close <CR>]])
vim.keymap.set('n', '<leader>h', vim.cmd.tabp )
vim.keymap.set('n', '<leader>l', vim.cmd.tabN )

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Enable visual cursor line
vim.wo.cursorline = true

-- Enable visual cursor column
vim.wo.cursorcolumn = true

-- Enable visual color column at specified column number
vim.opt.colorcolumn = "80"

-- Allows neovim to access the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Always show tabs
vim.opt.showtabline = 2

-- Set term gui colors (most terminals support this)
vim.opt.termguicolors = true

-- Disable Swapfiles
vim.opt.swapfile = false

-- Set the tabs
vim.opt.tabstop=4

-- Set the indentation
vim.opt.shiftwidth=4

-- Show full path in Netrw banner
vim.g.netrw_banner = 3

vim.opt.relativenumber = true

vim.cmd.colorscheme "desert"

-- Plugin Manager

require("config.lazy")


-- LSP diagnostics

-- vim.diagnostic.config({ virtual_text = true })

-- Custom keyboard shortcuts
vim.keymap.set('n', 'gK', function()
  local new_config = not vim.diagnostic.config().virtual_lines
  vim.diagnostic.config({ virtual_lines = new_config })
end, { desc = 'Toggle diagnostic virtual_lines' })
