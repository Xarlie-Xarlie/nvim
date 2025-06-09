vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.cursorcolumn = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.o.statuscolumn = [[%!v:lnum . ' ' . (v:lnum == line('.') ? 0 : abs(v:lnum - line('.')))]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.splitright = true
