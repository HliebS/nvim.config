return {
	"tpope/vim-fugitive",
	config = function()
		local function toggle_fugitive()
			local fugitive_window = vim.fn.bufwinnr("fugitive://")
			if fugitive_window ~= -1 then
				-- If the fugitive window is open, close it
				vim.cmd("q")
			else
				-- If the fugitive window is not open, open it
				vim.cmd("Git")
			end
		end

		vim.keymap.set("n", "<leader>gst", toggle_fugitive, { desc = "Toggle Git" })
	end,
}
