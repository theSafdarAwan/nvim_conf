local vim = vim
local map = require(require("genearl").core_loc() .. ".utils").map
local opts = { noremap = true, silent = true }
map("n", "<leader>ves", ":SymbolsOutline<CR>", opts)
