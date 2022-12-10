local map = require("safdar.core.utils").set_map

map("n", "<leader>ee", ":ALEToggle<cr>", { silent = true, noremap = true })
map("n", "<leader>ej", ":ALENext<cr>", { silent = true, noremap = true })
map("n", "<leader>ek", ":ALEPrevious<cr>", { silent = true, noremap = true })
