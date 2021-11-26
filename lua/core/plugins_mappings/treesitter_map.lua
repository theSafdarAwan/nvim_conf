local map = require("core.utils").map
--> TreeSitter
map("n", "<C-k>", ":TSHighlightCapturesUnderCursor<cr>", { noremap = true, silent = true })
