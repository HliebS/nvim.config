return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{
			"folke/lazydev.nvim",
			ft = "lua",
			opts = {
				library = {
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		"saghen/blink.cmp",
		"Decodetalkers/csharpls-extended-lsp.nvim",
	},
	opts = {
		servers = {
			lua_ls = {},

			csharp_ls = {},

			jedi_language_server = {},

			html = {},

			angularls = {},

			somesass_ls = {},

			tailwindcss = {},

			--Typescript LSP is provided by typescript-tools.nvim

			jsonls = {},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")

		local server_configs = {
			csharp_ls = {
				cmd = { "csharp-ls" },
				handlers = {
					["textDocument/definition"] = require("csharpls_extended").handler,
					["textDocument/typeDefinition"] = require("csharpls_extended").handler,
				},
			},
			html = {
				filetypes = { "html", "htmlangular", "templ" },
			},
			tailwindcss = {
				settings = {
					tailwindCSS = {
						validate = true,
						lint = {
							cssConflict = "warning",
							invalidApply = "error",
							invalidScreen = "error",
							invalidVariant = "error",
							invalidConfigPath = "ignore",
							invalidTailwindDirective = "error",
							recommendedVariantOrder = "warning",
						},
						classAttributes = {
							"class",
							"className",
							"class:list",
							"classList",
							"ngClass",
						},
						includeLanguages = {
							htmlangular = "html",
						},
					},
				},
			},
		}

		for server, config in pairs(opts.servers) do
			-- passing config.capabilities to blink.cmp merges with the capabilities in your
			-- `opts[server].capabilities, if you've defined it
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)

			if server == "html" then
				config.capabilities.textDocument.completion.completionItem.snippetSupport = true
			end

			lspconfig[server].setup(vim.tbl_deep_extend("force", config, server_configs[server] or {}))
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local options = { buffer = ev.buf, silent = true }

				local keymap = vim.keymap

				local telescope = require("telescope")

				local builtin = require("telescope.builtin")

				telescope.load_extension("csharpls_definition")

				-- Set keymaps for LSP
				options.desc = "Show LSP references"
				keymap.set("n", "gR", builtin.lsp_references, options) -- references

				options.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, options) -- go to declaration

				options.desc = "Show LSP definitions"
				keymap.set("n", "gd", function()
					local filetype = vim.bo.filetype

					if filetype == "cs" then
						-- Call csharpls_definition extension for C# files
						vim.cmd("Telescope csharpls_definition")
					else
						builtin.lsp_definitions()
					end
				end, options)

				options.desc = "Show LSP implementations"
				keymap.set("n", "gi", builtin.lsp_implementations, options) -- show lsp implementations

				options.desc = "Show LSP type definitions"
				keymap.set("n", "gt", builtin.lsp_type_definitions, options) -- show lsp type definitions

				options.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, options) -- smart rename

				options.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", builtin.diagnostics, options) -- show  diagnostics for file

				options.desc = "Show line diagnostics"
				keymap.set("n", "<leader>d", vim.diagnostic.open_float, options) -- show diagnostics for line

				options.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, options) -- jump to previous diagnostic in buffer

				options.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, options) -- jump to next diagnostic in buffer

				options.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, options) -- show documentation for what is under cursor

				options.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", options) -- mapping to restart lsp if necessary
			end,
		})
	end,
}
