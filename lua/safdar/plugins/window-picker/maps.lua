local utils = require("safdar.core.utils")
local vim = utils.vim
local map = utils.map

local picker = require("window-picker")
map("n", "gf", function()
    local picked_window_id = picker.pick_window()
        or vim.api.nvim_get_current_win()
    vim.api.nvim_set_current_win(picked_window_id)
end, { desc = "Pick a window", noremap = true, silent = true })