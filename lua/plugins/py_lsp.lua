return { -- select python virtual environment
	{
		'HallerPatrick/py_lsp.nvim',
		lazy = false,
		opts = {
			host_python = "/usr/bin/python3",
			default_venv_name = "venv" -- For local venv
		},
	}
}
