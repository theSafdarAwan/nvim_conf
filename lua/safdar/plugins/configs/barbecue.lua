local barbecue = require("barbecue")
barbecue.setup()
vim.api.nvim_create_autocmd({
	"BufWinEnter",
	"BufWritePost",
	"CursorMoved",
	"CursorMovedI",
	"TextChanged",
	"TextChangedI",
	-- add more events here
}, {
	group = vim.api.nvim_create_augroup("barbecue", {}),
	callback = function(a)
		require("barbecue").update(a.buf)
	end,
})
