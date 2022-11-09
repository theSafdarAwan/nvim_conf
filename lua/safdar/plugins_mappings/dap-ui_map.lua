local M = {}

M.maps = function()
    local utils = require("safdar.core.utils")
    local map = utils.map
    local opts = { noremap = true, silent = true }

    map("n", "[du", "<cmd>lua require('dapui').open()<CR>", opts)
    map("n", "[dt", "<cmd>lua require('dapui').toggle()<CR>", opts)
    map("n", "[dc", "<cmd>lua require('dapui').close()<CR>", opts)
    map("n", "[de", "<cmd>lua require('dapui').eval()<CR>", opts)
end

M.mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
}

return M
