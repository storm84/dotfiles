return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	config = function()
		-- configure colors
		vim.cmd.colorscheme("catppuccin")
	end,
}
