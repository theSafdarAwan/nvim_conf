local opts = { noremap = true, silent = true }
local map = require("safdar.core.utils").map
--> Lspsaga
-- hover diagnostic
map("n", "[k", ":Lspsaga show_cursor_diagnostics<CR>", opts)
map("n", "[l", ":Lspsaga show_line_diagnostics<CR>", opts)
map("n", "[[", ":Lspsaga diagnostic_jump_prev<CR>", opts)
map("n", "]]", ":Lspsaga diagnostic_jump_next<CR>", opts)
-- cursor word definition and reference
map("n", "gd", ":Lspsaga lsp_finder<CR>", opts)
-- rename
-- map("n", "yr", ":Lspsaga rename<CR>", opts)
-- map("n", "<leader>la", ":Lspsaga code_action<CR>", opts)
map("n", "gh", ":Lspsaga peek_definition<CR>", opts)
