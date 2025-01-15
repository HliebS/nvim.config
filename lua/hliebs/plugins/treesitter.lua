return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		treesitter.setup({
			modules = {},
			ensure_installed = {
				"c",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline", -- Defaults
				"c_sharp",
			},
			auto_install = false,
			ignore_install = {},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
