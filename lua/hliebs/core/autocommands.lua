-- TJDeVries (https://github.com/tjdevries/advent-of-nvim)
-- Highlight of yanked text after yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost", "FileReadPost" }, {
	desc = "Unfold all folds after opening a Buf",
	group = vim.api.nvim_create_augroup("unfold-all-folds", { clear = true }),
	callback = function()
		vim.api.nvim_feedkeys("zR", "n", false)
	end,
})
-- Configure absolute and relative numbers in :Explore
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	desc = "Enable absolute and relative line numbers in NetRW",
	callback = function()
		vim.wo.number = true -- Enable absolute line numbers
		vim.wo.relativenumber = true -- Enable relative line numbers
	end,
})
