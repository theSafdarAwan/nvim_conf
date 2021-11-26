local map = require("core.utils").map
--> lsp trouble
map("n", "<leader>tt", ":TroubleToggle<cr>", { noremap = true, silent = true })
map("n", "<leader>tw", "<cmd>TroubleToggle lsp_document_diagnostics<cr>", { noremap = true, silent = true })
map("n", "<C-s><C-x>", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>", { noremap = true, silent = true })
map("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", { noremap = true, silent = true })
map("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>", { noremap = true, silent = true })
map("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { noremap = true, silent = true })
