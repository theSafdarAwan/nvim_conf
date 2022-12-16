local utils = require("safdar.core.utils")
local map = utils.set_map
local command = utils.command
local b = utils.bo
local opts = { noremap = true, silent = true }

local function neorg_file_helper(cmd)
	if b.filetype == "norg" then
		command(cmd)
	end
end

map("n", "gtc", ":Neorg gtd capture<CR>", opts)
map("n", "gtv", ":Neorg gtd views<CR>", opts)
map("n", "gts", ":lua NeorgMappingsHelper('')<CR>", opts)
map("n", "gti", ":Neorg toc inline<CR>", opts)
map("n", "gtx", ":Neorg toc close<CR>", opts)
map("n", "gtt", function()
	neorg_file_helper("Neorg tangle current-file")
end, opts)

map("i", "<C-y>", "<ESC>:Telescope neorg insert_link<CR>", opts)
map("n", "<leader>y", ":Telescope neorg insert_file_link<CR>", opts)
map("n", "gtw", ":Telescope neorg switch_workspace<CR>", opts)
-- map("n", "gtd", ":e ~/safdar-local/NOTES/Personal-Management/TODO/today-schedule.norg<CR>", opts)
