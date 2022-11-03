local map = require("safdar.core.utils").map
--> format the document
map("v", "nf", ":lua vim.lsp.buf.range_formatting()<CR>", { noremap = true, silent = true })
map("n", "<leader>ni", ":NullLsInfo<cr>", { noremap = true, silent = true })
