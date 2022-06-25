local map = require("core.utils").map
--> format the document
map("n", "<leader>nf", ":lua vim.lsp.buf.format()<cr>", { noremap = true, silent = true })
map("n", "<leader>ni", ":NullLsInfo<cr>", { noremap = true, silent = true })
