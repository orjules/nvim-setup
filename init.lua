vim.cmd("set number")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd([[colorscheme slate]])
vim.cmd("set langmap=ö[,ä],Ö{,Ä}")
vim.g.mapleader = " "

require("config.lazy")
require("plugins.lspconfig")

