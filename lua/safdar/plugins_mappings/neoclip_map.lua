local vim = vim
local map = require(require("genearl").core_loc() .. ".utils").map
local M = {}

map("i", "<C-s>", "<c-o>:Telescope neoclip<CR>", { noremap = true, silent = true })
map("n", "<C-s>", ":Telescope neoclip<CR>", { noremap = true, silent = true })
map("v", "<C-s>", ":Telescope neoclip<CR>", { noremap = true, silent = true })

M.mapings = function()
    return {
        telescope = {
            i = {
                select = '<cr>',
                paste = '<c-j>',
                paste_behind = '<c-k>',
                custom = {},
            },
            n = {
                select = '<cr>',
                paste = 'p',
                paste_behind = 'P',
                custom = {},
            },
        },
        fzf = {
            select = 'default',
            paste_behind = 'ctrl-k',
            custom = {},
        },
    }
end
return M
