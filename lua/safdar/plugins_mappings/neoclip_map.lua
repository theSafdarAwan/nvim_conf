local utils = require("safdar.core.utils")
local map = utils.map
local opts = { noremap = true, silent = true }
local M = {}

map("i", "<C-n>", "<c-o>:Telescope neoclip<CR>", opts)
map("n", "<C-n>", ":Telescope neoclip<CR>", opts)
map("v", "<C-n>", ":Telescope neoclip<CR>", opts)

M.mapings = function()
    return {
        telescope = {
            i = {
                select = "<cr>",
                paste = "<c-j>",
                paste_behind = "<c-k>",
                custom = {},
            },
            n = {
                select = "<cr>",
                paste = "p",
                paste_behind = "P",
                custom = {},
            },
        },
        fzf = {
            select = "default",
            paste_behind = "ctrl-k",
            custom = {},
        },
    }
end
return M
