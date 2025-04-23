return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = {
		"windwp/nvim-ts-autotag",
	},
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
			},
			auto_install = false,
			ignore_install = {},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
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
