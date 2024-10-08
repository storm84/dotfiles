vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.wo.number = true
vim.wo.relativenumber = true

vim.cmd("set nocompatible")
vim.cmd("filetype plugin on")
vim.cmd("syntax on")

vim.g.python3_host_prog = "/Users/marcusstorm/.pyenv/versions/py3nvim/bin/python"

-- configure folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
-- vim.o.foldnestmax=3

-- -- Enable folding by expression for Markdown files
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "markdown",
--   callback = function()
--     vim.opt_local.foldmethod = "expr"
--     vim.opt_local.foldexpr = "v:lua.vim_markdown_fold()"
--   end,
-- })
--
-- -- Function to define fold levels based on header depth
-- function _G.vim_markdown_fold()
--   local line = vim.fn.getline(vim.v.lnum)
--   local header_level = line:match("^#+")  -- Find Markdown headers
--
--   if header_level then
--     return ">" .. #header_level   -- Fold based on the number of `#` characters
--   else
--     return "="
--   end
-- end

