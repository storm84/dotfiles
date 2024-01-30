local lualine_config = function()
	require("lualine").setup({
		options = { theme = "material" },
	})
end

return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = lualine_config,
}
