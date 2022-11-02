local map = require("safdar.core.utils").map
local opts = { noremap = true, silent = true }
local api = vim.api

function NeorgMappingsHelper(command)
    if vim.bo.filetype == "norg" then
        api.nvim_command(command)
    end
end

-- TODO: implement the same logic to the upstream neorg plugin
-- function ValidateNeorgTocStatus(command)
--     local buffers = {}
--     for buf = 1, vim.fn.bufnr("$") do
--         local buffer = vim.fn.bufname(buf)
--         table.insert(buffers, buffer)
--     end
--     for _, buf in pairs(buffers) do
--         if buf == "neorg://norg/Neorg Toc.norg" then
--             api.nvim_command(command)
--         end
--     end
-- end

-- TODO: add some logic to load Neorg plugin only when i press the gtc to capture
-- or gtv to view the todo's

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