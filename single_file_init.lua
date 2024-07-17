
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
vim.keymap.set('n', '<leader>o', [[<CMD>browse oldfiles <CR>]])

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

vim.cmd.colorscheme "desert"


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
	{'folke/tokyonight.nvim'}, -- colorscheme
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'}, -- setup LSP
	{'williamboman/mason.nvim'}, -- manage langauge servers
	{'williamboman/mason-lspconfig.nvim'}, -- manage language servers
	{'neovim/nvim-lspconfig'}, --  setup LSP
	{'hrsh7th/cmp-nvim-lsp'}, -- setup LSP
	{'hrsh7th/nvim-cmp'}, -- completions
	{'L3MON4D3/LuaSnip'}, -- snippets
	{ -- fuzzy search
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                              , branch = '0.1.x',
		dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{'lewis6991/gitsigns.nvim'}, -- git integration
	{'ahmedkhalf/project.nvim'},
	{'goolord/alpha-nvim', -- start page for when you first open neovim
	dependencies = {
		'nvim-tree/nvim-web-devicons'}
	},
	{ -- fancy status line at bottom of screen
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' }
	},
	{ "lukas-reineke/indent-blankline.nvim", -- added line between indents for easier reading
		main = "ibl", opts = {}
	},
	{'HallerPatrick/py_lsp.nvim'}, -- select python virtual environment
	{'tpope/vim-fugitive'}, -- git integration
	{'iamcco/markdown-preview.nvim'}, -- markdown preview


})

-- -- Set colorscheme
-- vim.opt.termguicolors = true
-- vim.cmd.colorscheme('tokyonight')

---
-- LSP setup
---
local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
	-- see :help lsp-zero-keybindings
	-- to learn the available actions
	lsp_zero.default_keymaps({buffer = bufnr})
end)

--- if you want to know more about lsp-zero and mason.nvim
--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guide/integrate-with-mason-nvim.md
require('mason').setup({})
require('mason-lspconfig').setup({
	handlers = {
		function(server_name)
			require('lspconfig')[server_name].setup({})
		end,
	}
})

---
-- Autocompletion config
---
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		-- `Enter` key to confirm completion
		['<CR>'] = cmp.mapping.confirm({select = false}),

		-- Ctrl+Space to trigger completion menu
		['<C-Space>'] = cmp.mapping.complete(),

		-- Navigate between snippet placeholder
		['<C-f>'] = cmp_action.luasnip_jump_forward(),
		['<C-b>'] = cmp_action.luasnip_jump_backward(),

		-- Scroll up and down in the completion documentation
		['<C-u>'] = cmp.mapping.scroll_docs(-4),
		['<C-d>'] = cmp.mapping.scroll_docs(4),
	}),
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
})

---
-- Telescope config
--

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>/', function()
	-- You can pass additional configuration to telescope to change theme, layout, etc.
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
		previewer = false,
	})
end, { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, {desc = '[D]ocument [S]ymbols'})
vim.keymap.set('n', '<F3>', builtin.diagnostics, {desc = 'diagnostics for current buffer'})
vim.keymap.set('n', '<leader>sp', function()
	require'telescope'.extensions.projects.projects{}
end, { desc = '[S]earch [P]roject' })
vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, {desc = '[D]ocument [S]ymbols'})
vim.keymap.set('n', '<F3>', builtin.diagnostics, {desc = 'diagnostics for current buffer'})


---
-- git signs config
---

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
		map('n', ']c', function()
			if vim.wo.diff then
				vim.cmd.normal({']c', bang = true})
			else
				gitsigns.nav_hunk('next')
			end
		end)

		map('n', '[c', function()
			if vim.wo.diff then
				vim.cmd.normal({'[c', bang = true})
			else
				gitsigns.nav_hunk('prev')
			end
		end)
	end
}


---
-- search projects config
---

require("project_nvim").setup()

---
-- alpha config  
---
local alpha = require("alpha")
local dashboard = require("alpha.themes.startify")
alpha.setup(dashboard.opts)


--- 
-- Lua Line config 
---
require('lualine').setup()

--- 
-- Indent blank line config 
---
require("ibl").setup()

---
-- Python virtual environment selector
---
require'py_lsp'.setup {
  -- This is optional, but allows to create virtual envs from nvim
  host_python = "/usr/bin/python3",
  default_venv_name = ".venv" -- For local venv
}

---
-- Git Fugitive config
---
vim.keymap.set('n', '<leader>g', vim.cmd.Git)

---
---
---

