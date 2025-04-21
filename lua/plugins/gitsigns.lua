return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	keys = {
		{"<leader]>", "<cmd>Gitsigns next_hunk<cr>", desc = "Next git hunk"},
		{"<leader[>", "<cmd>Gitsigns prev_hunk<cr>", desc = "Previous git hunk"},
	},
	config = function ()
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
			end,
		}
	end,
}
