local neo_tree_config = function()
	vim.keymap.set("n", "<leader>e", ":Neotree toggle filesystem reveal left<CR>", {})
	vim.keymap.set("n", "<leader>ge", ":Neotree toggle float git_status<CR>", {})
end

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = neo_tree_config,
}
