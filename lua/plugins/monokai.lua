return {
	{
		"tanvirtin/monokai.nvim",
		lazy = false,
		name = "monokai",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme "monokai"
		end
	}
}
