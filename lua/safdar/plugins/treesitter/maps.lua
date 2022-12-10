local set_map = require("safdar.core.utils").set_map
--> TreeSitter
set_map("n", "gtk", ":TSHighlightCapturesUnderCursor<cr>", { noremap = true, silent = true })

local M = {}
M.treesitter_maps = {
	init_selection = "gn",
	node_incremental = "]]",
	scope_incremental = "gS",
	node_decremental = "[[",
}

return M
