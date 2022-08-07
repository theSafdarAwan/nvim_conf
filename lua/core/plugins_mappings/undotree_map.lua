local map = require(require("genearl").core_loc() .. ".utils").map
--> Undotree
map("n", "<leader>u", ":UndotreeToggle<cr> :wincmd h<cr>", { noremap = true, silent = true })
