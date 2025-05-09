local dap_config = function()
	local dap = require("dap")
	local dapui = require("dapui")

	dapui.setup()

	-- configure dap servers

	-- configure golang (delve )
	require("dap-go").setup()

	-- configure .net (netcoredbg)
	dap.adapters.coreclr = {
		type = "executable",
		command = "/usr/bin/netcoredbg",
		args = { "--interpreter=vscode" },
	}

	dap.configurations.cs = {
		{
			type = "coreclr",
			name = "launch - netcoredbg",
			request = "launch",
			program = function()
				return vim.fn.input("Path to dll", vim.fn.getcwd() .. "/bin/Debug/", "file")
			end,
		},
	}

	-- configure dapui to automatically open and close windows based on nvim-dap events
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
	end
end

return {
	{
		"rcarriga/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
		},
		config = dap_config,
	},
	{
		"leoluz/nvim-dap-go",
	},
}
