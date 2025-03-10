return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			modules = {},
			ensure_installed = {
				-- Defaults
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				-- Defaults end
				"c_sharp",
				"xml",
				"python",
			},
			auto_install = false,
			ignore_install = {},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})

		-- Associate xaml as xml filetype
		vim.filetype.add({
			extension = {
				xaml = "xml",
			},
		})
	end,
}
