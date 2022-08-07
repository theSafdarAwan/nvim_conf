local map = require(require("genearl").core_loc() .. ".utils").map
--> Packer
map("n", "<leader>pi", ":PackerInstall<cr>", { noremap = true, silent = true })
map("n", "<leader>pc", ":PackerCompile<cr>", { noremap = true, silent = true })
map("n", "<leader>pu", ":PackerUpdate<cr>", { noremap = true, silent = true })
map("n", "<leader>ps", ":PackerSync<cr>", { noremap = true, silent = true })
map("n", "<leader>pC", ":PackerClean<cr>", { noremap = true, silent = true })
map("n", "<leader>pp", ":PackerProfile<cr>", { noremap = true, silent = true })
