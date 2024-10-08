local treesitter_config = function()
	local tsConfigs = require("nvim-treesitter.configs")
	tsConfigs.setup({
		ensure_installed = { "c", "lua", "vim", "vimdoc", "javascript", "html", "css", "json", "go", "rust", "markdown" },
		auto_install = true,
		sync_install = false,
		highlight = { enable = true },
		indent = { enable = true },
	})
end

return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = treesitter_config,
}
