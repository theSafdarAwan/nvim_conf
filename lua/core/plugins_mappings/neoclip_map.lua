local vim = vim
local map = require("core.utils").map
local M = {}

map("i", "<C-n>", "<c-o>:Telescope neoclip<CR>", { noremap = true, silent = true })
map("n", "<C-n>", ":Telescope neoclip<CR>", { noremap = true, silent = true })
map("v", "<C-n>", ":Telescope neoclip<CR>", { noremap = true, silent = true })
-- TODO: add the gv it's not working because the telescope prompt appears

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
