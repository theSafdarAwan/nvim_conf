local opts = { noremap = true, silent = true }
local map = require(require("genearl").core_loc() .. ".utils").map
--> Lspsaga
-- hover diagnostic
map("n", "<leader>sk", ":Lspsaga show_cursor_diagnostics<CR>", opts)
map("n", "<leader>sl", ":Lspsaga show_line_diagnostics<CR>", opts)
-- cursor word definition and reference
map("n", "gh", "<cmd>lua require'lspsaga.provider'.lsp_finder()<CR>", opts)
-- rename
map("n", "rn", ":Lspsaga rename<CR>", opts)
