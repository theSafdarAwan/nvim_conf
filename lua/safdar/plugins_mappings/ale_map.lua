local map = require(require("genearl").core_loc() .. ".utils").map

map("n", "<leader>ee", ":ALEToggle<cr>", { silent = true, noremap = true })
map("n", "<leader>ej", ":ALENext<cr>", { silent = true, noremap = true })
map("n", "<leader>ek", ":ALEPrevious<cr>", { silent = true, noremap = true })
