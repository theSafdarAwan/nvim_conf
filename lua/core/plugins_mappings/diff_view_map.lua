local map = require("core.utils").map
-- Diff View
map("n", "<leader>dv", ":DiffviewOpen<cr>", { noremap = true, silent = true })
map("n", "<leader>dx", ":DiffviewClose<cr>", { noremap = true, silent = true })
