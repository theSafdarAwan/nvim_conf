local set_map = require("safdar.utils").set_map
--> Lspsaga
-- hover diagnostic
set_map("n", "[k", ":Lspsaga show_cursor_diagnostics<CR>")
set_map("n", "[l", ":Lspsaga show_line_diagnostics<CR>")
set_map("n", "[[", ":Lspsaga diagnostic_jump_prev<CR>")
set_map("n", "]]", ":Lspsaga diagnostic_jump_next<CR>")
-- cursor word definition and reference
set_map("n", "gd", ":Lspsaga finder<CR>")
-- rename
-- set_map("n", "yr", ":Lspsaga rename<CR>")
-- set_map("n", "<leader>la", ":Lspsaga code_action<CR>")
set_map("n", "gh", ":Lspsaga peek_definition<CR>")
