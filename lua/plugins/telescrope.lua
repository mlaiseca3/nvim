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
			vim.keymap.set('n', '<leader>o', builtin.oldfiles, { desc = '[O] Find recently opened files' })
			vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, {desc = 'Current buffer fuzzy find' })
			vim.keymap.set('n', '<leader>ds', builtin.lsp_document_symbols, {desc = '[D]ocument [S]ymbols'})
			vim.keymap.set('n', '<F3>', builtin.diagnostics, {desc = 'diagnostics for current buffer'})
			vim.keymap.set('n', '<leader>gs', builtin.git_status, {desc = '[G]it [S]tatus'})
			vim.keymap.set('n', '<leader>sp', function()
				require'telescope'.extensions.projects.projects{}
			end, { desc = '[S]earch [P]roject' })

			require("telescope").load_extension("ui-select")
		end,
	},
}
