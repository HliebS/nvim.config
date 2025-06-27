-- Helper function to get the appropriate path separator for the OS
local function get_path_sep()
	if jit then
		if jit.os == "Windows" then
			return "\\"
		else
			return "/"
		end
	else
		return package.config:sub(1, 1)
	end
end

-- Ensure that the given directory exists, create it if necessary
local function ensure_directory_exists(dir_path)
	if vim.fn.exists(dir_path) == 0 or vim.fn.isdirectory(dir_path) == 0 then
		-- Create directory recursively, similar to `mkdir -p`
		vim.fn.mkdir(dir_path, "p")
	end
end

-- Generate the path for the bookmark file, scoped to the current project
local function get_bookmark_path()
	local path_sep = get_path_sep()
	local base_filename = vim.fn.getcwd()

	-- Handle Windows paths by replacing ':' with '_'
	if jit and jit.os == "Windows" then
		base_filename = base_filename:gsub(":", "_")
	end

	-- Define the directory for storing bookmarks
	local bookmark_dir = vim.fn.stdpath("data") .. path_sep .. "nvim_bookmarks"
	-- Ensure the directory exists
	ensure_directory_exists(bookmark_dir)

	-- Return the full path to the bookmark file
	return bookmark_dir .. path_sep .. base_filename:gsub(path_sep, "_") .. ".json"
end

-- Define the path for the bookmark file
local bookmark_file_path = get_bookmark_path()

return {
	"tomasky/bookmarks.nvim",
	config = function()
		require("bookmarks").setup({
			-- sign_priority = 8,  --set bookmark sign priority to cover other sign
			save_file = bookmark_file_path, -- bookmarks save file path

			keywords = {
				["@t"] = " ", -- mark annotation starting with @t, is typed as "Todo"
				["@w"] = " ", -- mark annotation starting with @w, is typed as "Warn"
				["@f"] = " ", -- mark annotation starting with @f, is typed as "Fix"
				["@n"] = " ", -- mark annotation starting with @n, is typed as "Note"
				["@q"] = " ", -- mark annotation starting with @q, is typed as "Question"
				["@r"] = " ", -- mark annotation starting with @q, is typed as "Refactor"
				["@d"] = " ", -- mark annotation starting with @d, is typed as "Delete"
			},

			on_attach = function(bufnr)
				local bm = require("bookmarks")
				local keymap = vim.keymap

				keymap.set("n", "mm", bm.bookmark_toggle, { desc = "Add or remove bookmark at current line" })
				keymap.set("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
				keymap.set("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
				keymap.set("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
				keymap.set("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
				keymap.set("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
				keymap.set("n", "<leader>mX", bm.bookmark_clear_all) -- removes all bookmarks

				local function bookmark_create_with_annotation()
					bm.bookmark_toggle()
					bm.bookmark_ann()
				end

				keymap.set("n", "mM", bookmark_create_with_annotation, { desc = "Add a bookmark with annotation" })
			end,
		})
	end,
}
