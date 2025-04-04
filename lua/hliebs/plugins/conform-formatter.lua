return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				csharp = { "csharpier" },
				python = { "black" },
				html = { "prettier" },
				htmlangular = { "prettier" },
				scss = { "prettier" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				json = { "prettier" },
			},
			format_on_save = {
				lsp_fallback = "fallback",
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = "fallback",
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
