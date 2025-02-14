-- If using the above, then `/path/to/venv/bin/python -m debugpy --version`
-- must work in the shell

return {
	"mfussenegger/nvim-dap-python",
	keys = {
		{
			"<leader>B", 
			function ()
				require("dap").set_breakpoint()
			end,
			desc = "DAP: Set breakpoint"
		},
		{
			"<leader>b",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "DAP: Toggle breakpoint",
		},
		{
			"<F5>",
			function()
				require("dap").continue()
			end,
			desc = "DAP: Continue",
		},
		{
			"<F10>",
			function()
				require("dap").step_over()
			end,
			desc = "DAP: Step over",
		},
		{
			"<F11>",
			function()
				require("dap").step_into()
			end,
			desc = "DAP: Step over",
		},
		{
			"<F12>",
			function()
				require("dap").step_out()
			end,
			desc = "DAP: Step out",
		},
		{
			"<leader>dr",
			function()
				require("dap").repl.open()
			end,
			desc = "DAP: Open REPL",
		},

	},
	config = function()
		require("dap-python").setup("/home/mario/.virtualenvs/debugpy/bin/python")
	end,

}
