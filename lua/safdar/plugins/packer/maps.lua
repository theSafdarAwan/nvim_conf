local map = require("safdar.core.utils").map
--> Packer
map("n", "<leader>pi", ":PackerInstall<cr>", { noremap = true, silent = true })
map("n", "<leader>pc", ":PackerCompile<cr>", { noremap = true, silent = true })
map("n", "<leader>so", ":so % | so ~/.config/nvim/init.lua | PackerCompile<cr>", { noremap = true, silent = true })
map("n", "<leader>pu", ":PackerUpdate<cr>", { noremap = true, silent = true })
map("n", "<leader>ps", ":PackerStatus<cr>", { noremap = true, silent = true })
map("n", "<leader>pS", ":PackerSync<cr>", { noremap = true, silent = true })
map("n", "<leader>pC", ":PackerClean<cr>", { noremap = true, silent = true })
map("n", "<leader>pp", ":PackerProfile<cr>", { noremap = true, silent = true })
