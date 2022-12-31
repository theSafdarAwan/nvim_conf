local set_map = require("safdar.utils").set_map
set_map("n", "[tt", ":TroubleToggle<cr>", { noremap = true, silent = true })
set_map("n", "[td", "<cmd>TroubleToggle document_diagnostics<cr>", { noremap = true, silent = true })
set_map("n", "[tw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { noremap = true, silent = true })
set_map("n", "[tq", "<cmd>TroubleToggle quickfix<cr>", { noremap = true, silent = true })
set_map("n", "[tl", "<cmd>TroubleToggle loclist<cr>", { noremap = true, silent = true })
set_map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { noremap = true, silent = true })
