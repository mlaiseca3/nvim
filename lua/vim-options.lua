
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)
vim.keymap.set('n', '<C-t>', vim.cmd.tabnew)

local is_linux = vim.loop.os_uname().sysname == "Linux"
local is_macos = vim.loop.os_uname().sysname == "Darwin"

if is_linux then
	print("Running on Linux")
	-- Add your Linux-specific configurations here
	vim.keymap.set('n', 'gx', [[<CMD>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>]])
elseif is_macos then
	print("Running on macOS")
	-- Add your macOS-specific configurations here
else
	print("Running on an unsupported OS")
end
vim.keymap.set('n', '<S-h>', vim.cmd.bprevious)
vim.keymap.set('n', '<S-l>', vim.cmd.bnext)
-- vim.keymap.set('n', '<leader>o', [[<CMD>browse oldfiles <CR>]])

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

-- Set tab width to 2 spaces for JavaScript and TypeScript files
vim.api.nvim_exec([[
  augroup FileSettings
    autocmd!
    autocmd BufRead,BufNewFile *.js,*.ts,*.html,*.tsx,*.jsx set tabstop=2 shiftwidth=2
  augroup END
]], false)

-- Show full path in Netrw banner
vim.g.netrw_banner = 3

vim.opt.relativenumber = true

vim.cmd [[colorscheme ron]]
