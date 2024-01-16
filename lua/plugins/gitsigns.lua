return {
	"lewis6991/gitsigns.nvim",
	lazy = false,
	keys = {
		{"<C-n>", "<cmd>Gitsigns next_hunk<cr>", desc = "Next git hunk"},
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
		}
	end,
}
