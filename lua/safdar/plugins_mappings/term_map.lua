local map = require(require("genearl").core_loc() .. ".utils").map
local opts = { noremap = true, silent = true }

map("n", "<C-t>", ":lua ToggleTerminal()<CR>", opts)
map("t", "<C-t>", "<C-\\><C-N><C-w>j:lua ToggleTerminal()<CR>", opts)
