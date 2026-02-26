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

local function get_bookmark_dir_path()
	return vim.fn.stdpath("data") .. get_path_sep() .. "nvim_bookmarks"
end

-- Ensure that the given directory exists, create it if necessary
local function ensure_directory_exists(dir_path)
	if vim.fn.exists(dir_path) == 0 or vim.fn.isdirectory(dir_path) == 0 then
		-- Create directory recursively, similar to `mkdir -p`
		vim.fn.mkdir(dir_path, "p")
	end

	return true
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
	local bookmark_dir = get_bookmark_dir_path()
	-- Ensure the directory exists
	ensure_directory_exists(bookmark_dir)

	-- Return the full path to the bookmark file
	return bookmark_dir .. path_sep .. base_filename:gsub(path_sep, "_") .. ".json"
end

local function cleanup_bookmarks()
	local bookmark_dir = get_bookmark_dir_path()

	local handle = vim.uv.fs_scandir(bookmark_dir)
	if not handle then
		return
	end

	while true do
		local name, type = vim.uv.fs_scandir_next(handle)
		if not name then
			break
		end

		-- Only process .json files
		if type == "file" and name:match("%.json$") then
			local full_path = bookmark_dir .. get_path_sep() .. name
			local stat = vim.uv.fs_stat(full_path)

			-- Check for the specific "empty" size
			if stat and stat.size < 12 then
				vim.uv.fs_unlink(full_path)
			end
		end
	end
end
cleanup_bookmarks()

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

			on_attach = function()
				local bm = require("bookmarks")
				local keymap = vim.keymap

				keymap.set("n", "mm", bm.bookmark_toggle, { desc = "Add or remove bookmark at current line" })
				keymap.set("n", "mi", bm.bookmark_ann) -- add or edit mark annotation at current line
				keymap.set("n", "mc", bm.bookmark_clean) -- clean all marks in local buffer
				keymap.set("n", "mn", bm.bookmark_next) -- jump to next mark in local buffer
				keymap.set("n", "mp", bm.bookmark_prev) -- jump to previous mark in local buffer
				keymap.set("n", "ml", bm.bookmark_list) -- show marked file list in quickfix window
				keymap.set("n", "<leader>mX", bm.bookmark_clear_all) -- removes all bookmarks
			end,
		})
	end,
}
