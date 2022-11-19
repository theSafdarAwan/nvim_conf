local utils = require("safdar.core.utils")
local map = utils.map
local command = utils.command
local b = utils.bo
local opts = { noremap = true, silent = true }

function NeorgMappingsHelper(cmd)
    if b.filetype == "norg" then
        command(cmd)
    end
end

-- TODO: add some logic to load Neorg plugin only when i press the gtc to capture
-- or gtv to view the todo's
-- so to do that first you have to check if the plugin is loaded and if not the
-- load it and if loaded then don't do anything just capture the note

map("n", "gtc", ":Neorg gtd capture<CR>", opts)
map("n", "gtv", ":Neorg gtd views<CR>", opts)
map("n", "gts", ":lua NeorgMappingsHelper('')<CR>", opts)
map("n", "gti", ":Neorg toc inline<CR>", opts)
map("n", "gtx", ":Neorg toc close<CR>", opts)
map(
    "n",
    "gtt",
    " :lua NeorgMappingsHelper('Neorg tangle current-file')<CR>",
    opts
)

map("i", "<C-y>", "<ESC>:Telescope neorg insert_link<CR>", opts)
map("n", "<leader>y", ":Telescope neorg insert_file_link<CR>", opts)
map("n", "gtw", ":Telescope neorg switch_workspace<CR>", opts)
-- map("n", "gtd", ":e ~/safdar-local/NOTES/Personal-Management/TODO/today-schedule.norg<CR>", opts)
