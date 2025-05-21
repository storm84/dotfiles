vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.wo.number = true
vim.wo.relativenumber = true
vim.api.nvim_set_option("clipboard","unnamedplus")


vim.cmd("set nocompatible")
vim.cmd("filetype plugin on")
vim.cmd("syntax on")

vim.g.python3_host_prog = "/Users/marcusstorm/.pyenv/versions/py3nvim/bin/python"

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

