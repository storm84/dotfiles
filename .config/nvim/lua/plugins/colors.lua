return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe", -- auto, latte, frappe, macchiato, mocha
      transparent_background = true,
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
