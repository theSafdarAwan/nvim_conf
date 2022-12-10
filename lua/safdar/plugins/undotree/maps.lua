local map = require("safdar.core.utils").set_map
--> Undotree
map("n", "<leader>u", ":UndotreeToggle<cr> :wincmd h<cr>", { noremap = true, silent = true })
