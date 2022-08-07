local map = require(require("genearl").core_loc() .. ".utils").map
--> TreeSitter
map("n", "<C-k>", ":TSHighlightCapturesUnderCursor<cr>", { noremap = true, silent = true })
