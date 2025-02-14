return {
	'mbbill/undotree',
	version = '*',
	lazy = false,
	dependencies = {
	},
	config = function()
		-- require('undotree').setup {}
		vim.keymap.set('n', '<F2>', vim.cmd.UndotreeToggle)
	end,
}
