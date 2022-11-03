local map = require("safdar.core.utils").map
--> TreeSitter
map("n", "<C-k>", ":TSHighlightCapturesUnderCursor<cr>", { noremap = true, silent = true })

local M = {}
M.treesitter_maps = {
    init_selection = "gn",
    node_incremental = "gni",
    scope_incremental = "gsi",
    node_decremental = "gnd",
}
return M
