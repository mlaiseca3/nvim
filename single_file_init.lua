
-- [[ Basic Keymaps ]]
-- Set <space> as the leader key
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('n', '<leader>e', vim.cmd.Ex)
vim.keymap.set('n', '<C-t>', vim.cmd.tabnew)
vim.keymap.set('n', 'gx', [[<CMD>execute '!xdg-open ' .. shellescape(expand('<cfile>'), v:true)<CR>]])
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

-- vim.cmd.colorscheme "desert"

--
-- Lazy plugin manager setup
--


local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
local uv = vim.uv or vim.loop

-- Auto-install lazy.nvim if not present
if not uv.fs_stat(lazypath) then
	print('Installing lazy.nvim....')
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
	print('Done.')
end

vim.opt.rtp:prepend(lazypath)

-- Add URL to plugins to install
require('lazy').setup({
	{'numToStr/Comment.nvim'}, -- comment out lines quickly using 'gcc'
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{'lewis6991/gitsigns.nvim'}, -- git integration
	{'ahmedkhalf/project.nvim'}, -- project integration
	{'goolord/alpha-nvim', -- start page for when you first open neovim
	dependencies = {
		'nvim-tree/nvim-web-devicons'}
	},
	{ -- fancy status line at bottom of screen
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{'tpope/vim-fugitive'}, -- git integration
	{'tpope/vim-surround'}, -- "surroundings"
	{'iamcco/markdown-preview.nvim'}, -- markdown preview
	-- {'HallerPatrick/py_lsp.nvim'}, -- select python virtual environment
	{'neovim/nvim-lspconfig'}, -- lsp configuration for easy setup
	{'williamboman/mason.nvim'}, -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
	{'williamboman/mason-lspconfig.nvim'}, -- integrats nvim-lspconfig and mason plugin
	{'mbbill/undotree'},


})


--
-- Individual plugin setup
-- 


--
-- Comment config
-- 
require("Comment").setup()


--
-- Git signs config
--
require('gitsigns').setup {
	signs = {
		add = { text = '+' },
		change = { text = '~' },
		delete = { text = '_' },
		topdelete = { text = '‾' },
		changedelete = { text = '~' },
	},
	on_attach = function(bufnr)
		local gitsigns = require('gitsigns')

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end
		-- Navigation
		map('n', '<leader>]', function()
			if vim.wo.diff then
				vim.cmd.normal({'<leader>]', bang = true})
			else
				gitsigns.nav_hunk('next')
			end
		end)

		map('n', '<leader>[', function()
			if vim.wo.diff then
				vim.cmd.normal({'<leader>[', bang = true})
			else
				gitsigns.nav_hunk('prev')
			end
		end)
	end
}

--
-- project config 
--

require("project_nvim").setup()

--
-- alpha config  
--
local alpha = require("alpha")
-- local dashboard = require("alpha.themes.startify")
-- alpha.setup(dashboard.opts)
alpha.setup(require'alpha.themes.theta'.config)


--
-- Lua Line config 
--
require('lualine').setup()

--
-- Python virtual environment selector config
--
-- require'py_lsp'.setup {
-- 	-- This is optional, but allows to create virtual envs from nvim
-- 	host_python = "/usr/bin/python3",
-- 	default_venv_name = ".venv" -- For local venv
-- }

--
-- Git Fugitive config
--
vim.keymap.set('n', '<leader>g', vim.cmd.Git)



--
-- Telescope config
--
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
-- vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch current word under cursor with [G]rep ' })
vim.keymap.set('n', '<leader>o', builtin.oldfiles, { desc = '[O]ld files' })
vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp documentation for Neovim' })
vim.keymap.set('n', '<leader>sp', function()
	require'telescope'.extensions.projects.projects{}
end, { desc = '[S]earch [P]roject' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {desc = 'Current buffer fuzzy find' })
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, {desc = '[D]ocument [S]ymbols'})
vim.keymap.set('n', '<F3>', builtin.diagnostics, {desc = 'diagnostics for current buffer'})
vim.keymap.set('n', '<leader>sh', builtin.help_tags, {desc = '[S]earch [H]elp tags'})




--
-- Mason config
-- this provides an index for LSP from web with easy way to install
-- manually you'd have to do this with LSP config plugin and find LSP yourself and install via npm 
--
require("mason").setup()


--
-- mason-lspconfig config
-- ensure that the following LSP servers are automatically installed
--
require("mason-lspconfig").setup({
	auto_install = true,
	ensure_installed = {
		"lua_ls",
		"tsserver",
		"eslint",
		"pyright",
		"html",
	}
})


--
-- LSP config for easy setup (Neovim has own LSP but this adds a layer on top to manage it)
-- you need to run setup function to have LSP server attach to client (Neovim buffer)
-- 
local lspconfig = require("lspconfig")


lspconfig.lua_ls.setup({
	-- options
})
lspconfig.tsserver.setup({
	-- options
})
lspconfig.eslint.setup({
	-- options
})
lspconfig.pyright.setup({
	-- options
})
lspconfig.html.setup({
	-- options
	-- html parser comes with Neovim but not LSP, these are different
})


--
-- Undo tree config
--
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)



