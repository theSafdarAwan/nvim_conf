local set_map = require("safdar.utils").set_map
--> format the document
set_map("v", "nf", ":lua vim.lsp.buf.range_formatting()<CR>")
set_map("n", "<leader>ni", ":NullLsInfo<cr>")
