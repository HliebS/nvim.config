vim.cmd("language en_US")

vim.o.shell = '"C:\\Program Files\\PowerShell\\7\\pwsh.exe"'

local g = vim.g

-- Disable netrw plugin for nvim-tree
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

g.undotree_DiffCommand = "diff.exe"

local opt = vim.opt

opt.guicursor = ""

opt.nu = true
opt.relativenumber = true

opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.wrap = false
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

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

opt.splitright = true -- split vertical window to the right
opt.splitbelow = false -- split horizontal window to the top

-- Add filetype
local filetype = vim.filetype

filetype.add({
	pattern = {
		[".*%.component%.html"] = "htmlangular", -- Sets the filetype to `htmlangular` if it matches the pattern
	},
})
vim.cmd("runtime! ftplugin/html.vim!")

vim.filetype.add({
	extension = {
		xaml = "xml", -- Associate .xaml as .xml
		csproj = "xml", -- Associate .csproj as .xml
		esproj = "xml", -- Associate .esproj as .xml
		props = "xml", -- Associate .props as .xml
	},
})
