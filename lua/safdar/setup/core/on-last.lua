-- Packer Maps
local set_map = require("safdar.utils").set_map
set_map("n", "<leader>pi", ":PackerInstall<cr>")
set_map("n", "<leader>pc", ":PackerCompile<cr>")
set_map("n", "<leader>pu", ":PackerUpdate<cr>")
set_map("n", "<leader>ps", ":PackerStatus<cr>")
set_map("n", "<leader>pS", ":PackerSync<cr>")
set_map("n", "<leader>pC", ":PackerClean<cr>")
set_map("n", "<leader>pp", ":PackerProfile<cr>")
