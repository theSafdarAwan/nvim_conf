local M = {}

M.maps = function()
    local utils = require("safdar.core.utils")
    local map = utils.map
    local opts = { noremap = true, silent = true }

    map("n", "<C-g>d", "<cmd>DiffviewOpen<CR>", opts)
    map("n", "<C-g>D", "<cmd>DiffviewFileHistory<CR>", opts)
    map("n", "<C-g>x", "<cmd>DiffviewClose<CR>", opts)
end

return M
