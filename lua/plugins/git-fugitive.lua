return {
	"tpope/vim-fugitive",
	config = function ()
		-- no setup function call required
	end,

	vim.keymap.set('n', '<leader>g', vim.cmd.Git)
}
