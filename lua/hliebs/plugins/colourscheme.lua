return {
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	opts = {
		style = "moon",
	},
	styles = {
		sidebars = "dark",
		floats = "dark",
	},
	config = function()
		vim.cmd("colorscheme tokyonight-night")
	end,
}
