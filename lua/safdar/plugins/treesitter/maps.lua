local map = require("safdar.core.utils").map
--> TreeSitter
map("n", "gtk", ":TSHighlightCapturesUnderCursor<cr>", { noremap = true, silent = true })

local M = {}
M.treesitter_maps = {
	init_selection = "gn",
	node_incremental = "]]",
	scope_incremental = "gS",
	node_decremental = "[[",
}

return M
