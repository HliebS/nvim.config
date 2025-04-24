return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		--[[
    In formatters_by_ft, this converter should be accounted for
    For langeages not present in the converter, file extension should be given

    return {
      elixir = "ex",
      graphql = "gql",
      javascript = "js",
      javascriptreact = "jsx",
      markdown = "md",
      perl = "pl",
      python = "py",
      ruby = "rb",
      rust = "rs",
      typescript = "ts",
      typescriptreact = "tsx",
    }
    --]]

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				cs = { "csharpier" },
				python = { "black" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				htmlangular = { "prettier" },
				scss = { "prettier" },
				json = { "prettier" },
			},
			format_on_save = {
				lsp_fallback = "fallback",
				async = false,
				timeout_ms = 1000,
			},
			formatters = {
				-- Configuration for global installation of csharpier after v1.0.0
				csharpier = {
					command = "csharpier",
					args = { "format", "$FILENAME" },
					stdin = false,
				},
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
