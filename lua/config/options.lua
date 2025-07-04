local opt = vim.opt

-- General
opt.autoindent = true
opt.clipboard = "unnamed"
opt.expandtab = true
opt.hlsearch = true
opt.number = true
opt.shiftwidth = 2
opt.splitright = true
opt.tabstop = 2
opt.foldmethod = "manual" -- Changed from indent for better performance
opt.foldlevel = 99
opt.termguicolors = true
opt.updatetime = 100
opt.timeoutlen = 300
opt.completeopt = "menu,menuone,noinsert"
opt.conceallevel = 0
opt.fileencoding = "utf-8"
opt.ignorecase = true
opt.smartcase = true
opt.smartindent = true
opt.swapfile = false
opt.undofile = true
opt.writebackup = false
opt.cursorline = true
opt.relativenumber = false
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.signcolumn = "yes"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Set language to English
vim.cmd('language messages en_US')
