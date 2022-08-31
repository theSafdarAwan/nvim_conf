local map = require(require("genearl").core_loc() .. ".utils").map
map("n", "<leader>nc", ":Neogit commit<cr>", { noremap = true, silent = true })
map("n", "<leader>nn", ":Neogit<cr>", { noremap = true, silent = true })
