local opts = { noremap = true, silent = true }
local map = require("safdar.core.utils").map
--> Lspsaga
-- hover diagnostic
map("n", "ysk", ":Lspsaga show_cursor_diagnostics<CR>", opts)
map("n", "ysl", ":Lspsaga show_line_diagnostics<CR>", opts)
map("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
map("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
-- cursor word definition and reference
map("n", "gh", ":Lspsaga lsp_finder<CR>", opts)
-- rename
map("n", "ysr", ":Lspsaga rename<CR>", opts)
map("n", "ysa", ":Lspsaga code_action<CR>", opts)
map("n", "ysd", ":Lspsaga peek_definition<CR>", opts)
