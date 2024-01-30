local telescope_config = function()
	-- file pickers
	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
	vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
	vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
	vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
	-- TODO setup git pickers and lsp pickers
  -- git pickers
  vim.keymap.set("n", "<leader>gl", builtin.git_commits, {})
end

local ui_select_config = function()
	require("telescope").setup({
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown({}),
			},
		},
	})
	require("telescope").load_extension("ui-select")
end

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = telescope_config,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = ui_select_config,
	},
}
