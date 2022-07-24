local vim = vim
local map = require("core.utils").map
map("n", "<leader>S", ":Obsession!<cr>", { noremap = true, silent = true })
