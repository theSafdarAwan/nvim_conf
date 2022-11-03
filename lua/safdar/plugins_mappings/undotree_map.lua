local map = require("safdar.core.utils").map
--> Undotree
map("n", "<leader>u", ":UndotreeToggle<cr> :wincmd h<cr>", { noremap = true, silent = true })
