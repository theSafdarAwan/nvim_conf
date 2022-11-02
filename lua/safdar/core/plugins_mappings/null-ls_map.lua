local map = require(require("genearl").core_loc() .. ".utils").map
--> format the document
map("n", "<leader>nf", ":lua vim.lsp.buf.format({async = true})<CR>", { noremap = true, silent = true })
map("v", "nf", ":lua vim.lsp.buf.range_formatting()<CR>", { noremap = true, silent = true })
map("n", "<leader>ni", ":NullLsInfo<cr>", { noremap = true, silent = true })
