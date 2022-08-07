local vim = vim
local map = require(require("genearl").core_loc() .. ".utils").map
map("n", "<leader>S", ":Obsession!<cr>", { noremap = true, silent = true })
