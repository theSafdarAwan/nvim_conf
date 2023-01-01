local utils = require("safdar.utils")
local set_map = utils.set_map
local command = utils.command
local b = utils.bo

local function neorg_file_helper(cmd)
	if b.filetype == "norg" then
		command(cmd)
	end
end

set_map("n", "gtc", ":Neorg gtd capture<CR>")
set_map("n", "gtv", ":Neorg gtd views<CR>")
set_map("n", "gts", ":lua NeorgMappingsHelper('')<CR>")
set_map("n", "gti", ":Neorg toc inline<CR>")
set_map("n", "gtx", ":Neorg toc close<CR>")
set_map("n", "gtt", function()
	neorg_file_helper("Neorg tangle current-file")
end)

set_map("i", "<C-y>", "<ESC>:Telescope neorg insert_link<CR>")
set_map("n", "<leader>y", ":Telescope neorg insert_file_link<CR>")
set_map("n", "gtw", ":Telescope neorg switch_workspace<CR>")
-- set_map("n", "gtd", ":e ~/safdar-local/NOTES/Personal-Management/TODO/today-schedule.norg<CR>", opts)
