return {
	"nvim-telescope/telescope.nvim",
	branch = "master",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				path_display = { "smart" },
				mappings = {
					i = {
						["<C-p>"] = actions.move_selection_previous,
						["<C-n>"] = actions.move_selection_next,
					},
				},
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find under cursor" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })

		telescope.load_extension("grapple")
		keymap.set("n", "<leader>ft", "<cmd>Telescope grapple tags<cr>", { desc = "Find tags" })

		keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Find file changes" })

		telescope.load_extension("bookmarks")
		keymap.set("n", "<leader>fm", "<cmd>Telescope bookmarks list<cr>", { desc = "Find marks" })
	end,
}
