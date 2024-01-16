return {
    'AntonVanAssche/md-headers.nvim',
    version = '*',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
		"nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require('md-headers').setup {}
    end,
}
