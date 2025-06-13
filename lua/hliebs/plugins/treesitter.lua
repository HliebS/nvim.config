return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
	lazy = false,
	branch = "main",
	build = ":TSUpdate",

	config = function()
		local treesitter = require("nvim-treesitter")

		treesitter.install({
			"c",
			"lua",
			"luadoc",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			-- Backend
			"c_sharp",
			"xml",
			"python",
			"pascal",
			-- Frontend
			"html",
			"css",
			"scss", -- Sass
			"typescript",
			"angular",
		})

		local autotag = require("nvim-ts-autotag")

		autotag.setup({
			opts = {
				-- Defaults
				enable_close = true, -- Auto close tags
				enable_rename = true, -- Auto rename pairs of tags
				enable_close_on_slash = true, -- Auto close on trailing </
			},
			-- Also override individual filetype configs, these take priority.
			-- Empty by default, useful if one of the "opts" global settings
			-- doesn't work well in a specific filetype
			per_filetype = {},
		})
	end,
}
