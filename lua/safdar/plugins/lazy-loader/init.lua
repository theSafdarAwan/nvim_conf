local vim = vim
local gitsigns = {
	name = "gitsigns.nvim",
	on_load = {
		config = function()
			require("safdar.plugins.gitsigns")
		end,
	},
	autocmd = {
		event = "BufRead",
		callback = function()
			vim.fn.system("git -C " .. vim.fn.expand("%:p:h") .. " rev-parse")
			if vim.v.shell_error == 0 then
				return true
			end
		end,
	},
}
require("lazy-loader").loader(gitsigns)
