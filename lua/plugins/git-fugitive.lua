return {
	"tpope/vim-fugitive",
	config = function ()
		-- no setup function call required
	end,

	vim.keymap.set('n', '<leader>1', vim.cmd.Git, {desc="git fugitive"})
}
