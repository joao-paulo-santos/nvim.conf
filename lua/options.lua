local o = vim.opt

o.number = true
o.relativenumber = true
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.termguicolors = true
o.cursorline = true
o.ignorecase = true
o.smartcase = true
o.splitright = true
o.splitbelow = true
o.signcolumn = "yes"
o.clipboard = "unnamedplus"

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
