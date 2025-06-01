vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.relativenumber = true
vim.opt.cursorcolumn = true
vim.opt.wrap = true
vim.opt.termguicolors = true
vim.o.statuscolumn = "%s %l %r"
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", { desc = "Exit" })
