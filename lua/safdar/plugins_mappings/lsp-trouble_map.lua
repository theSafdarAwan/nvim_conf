local map = require(require("genearl").core_loc() .. ".utils").map
--> lsp trouble
map("n", "\\t", ":TroubleToggle<cr>", { noremap = true, silent = true })
map("n", "\\d", "<cmd>TroubleToggle document_diagnostics<cr>", { noremap = true, silent = true })
map("n", "\\w", "<cmd>TroubleToggle workspace_diagnostics<cr>", { noremap = true, silent = true })
map("n", "\\q", "<cmd>TroubleToggle quickfix<cr>", { noremap = true, silent = true })
map("n", "\\l", "<cmd>TroubleToggle loclist<cr>", { noremap = true, silent = true })
map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { noremap = true, silent = true })
