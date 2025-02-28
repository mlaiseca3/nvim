return {
	'MagicDuck/grug-far.nvim',
	keys = {
		{
			"<C-u>",
			function() require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand("%") } }) end,
			desc = "Search-replace visual selection",
			mode = "v"
		},
		{
			"<leader>sr",
			"<cmd>GrugFar<cr>",
			desc = "Search-replace via Grug-Far"
		},
	},
	config = function()
	  require('grug-far').setup({
		-- options, see Configuration section below
		-- there are no required options atm
		-- engine = 'ripgrep' is default, but 'astgrep' can be specified
	  });
	end
}

