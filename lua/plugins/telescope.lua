return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			local builtin = require("telescope.builtin")
			vim.keymap.set('n', '<leader>sf', builtin.find_files, {desc = '[S]earch [F]iles'})
			vim.keymap.set('n', '<leader>sg', builtin.live_grep, {desc = '[S]earch by [G]rep'})
			vim.keymap.set('n', '<leader><leader>', builtin.buffers, {desc = '[ ] Search open buffers'})
			vim.keymap.set('n', '<leader>sh', builtin.help_tags, {desc = '[S]earch [H]elp tags'})
			vim.keymap.set('n', '<leader>sw', builtin.grep_string, {desc = '[S]earch current [W]ord'})

			require("telescope").load_extension("ui-select")
		end,
	},
}
