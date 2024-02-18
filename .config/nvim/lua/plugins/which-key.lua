return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			-- defaults = {
			-- 	["<leader>f"] = { name = "[f]ind"},
			-- 	["<leader>g"] = { name = "[g]it" },
			-- 	["<leader>w"] = { name = "[w]orkspace" },
			-- 	["<leader>c"] = { name = "[c]ode"},
			-- },
		},
	},
}
