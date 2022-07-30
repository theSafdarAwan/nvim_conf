local map = require("core.utils").map
--> Lspsaga
-- hover diagnostic
map("n", "<leader>sk", ":Lspsaga show_cursor_diagnostics<CR>", { noremap = true, silent = true })
map("n", "<leader>sl", ":Lspsaga show_line_diagnostics<CR>", { noremap = true, silent = true })
-- cursor word definition and reference
map("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", { noremap = true, silent = true })
-- rename
map("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", { noremap = true, silent = true })
map("n", "<leader>rn", "<cmd>lua require('lspsaga.rename').rename()<CR>", { noremap = true, silent = true })
