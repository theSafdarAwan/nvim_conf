local vim = vim
local map = require("core.utils").map
local M = {}

map("i", "<C-t>", "<c-o>:Telescope neoclip<CR>", { noremap = true, silent = true })
map("n", "<C-t>", ":Telescope neoclip<CR>", { noremap = true, silent = true })
map("v", "<C-t>", ":Telescope neoclip<CR>", { noremap = true, silent = true })

M.mapings = function()
	return {
		i = {
			select = "<cr>",
			paste = "<c-k>",
			paste_behind = "<c-j>",
			custom = {},
		},
	}
end
return M
