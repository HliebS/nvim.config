return {
	"folke/trouble.nvim",
	dependecies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local trouble = require("trouble")

		trouble.setup({})

		local keymap = vim.keymap

		keymap.set("n", "<leader>ww", function()
			trouble.open("diagnostics")
		end, { desc = "Toggle trouble with workspace diagnostics" })
	end,
}
