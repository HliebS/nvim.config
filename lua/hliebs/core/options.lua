local opt = vim.opt

opt.guicursor = ""

-- Disable netrw plugin for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

opt.scrolloff = 8
opt.isfname:append("@-@")

opt.updatetime = 50

opt.colorcolumn = "120"

opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

local g = vim.g

g.netrw_liststyle = 3
