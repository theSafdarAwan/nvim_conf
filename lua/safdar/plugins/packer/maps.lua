local map = require("safdar.core.utils").map
local opts = { noremap = true, silent = true }
--> Packer
map("n", "<leader>pi", ":PackerInstall<cr>", opts)
map("n", "<leader>pc", ":PackerCompile<cr>", opts)
map("n", "<leader>pu", ":PackerUpdate<cr>", opts)
map("n", "<leader>ps", ":PackerStatus<cr>", opts)
map("n", "<leader>pS", ":PackerSync<cr>", opts)
map("n", "<leader>pC", ":PackerClean<cr>", opts)
map("n", "<leader>pp", ":PackerProfile<cr>", opts)
