local map = require("safdar.core.utils").map
local opts = { noremap = true, silent = true }
--> Packer
map("n", "<leader>pi", ":PackerInstall<cr>", opts)
map("n", "<leader>pc", ":PackerCompile<cr>", opts)
local so =  ":so % | so ~/.config/nvim/init.lua | PackerCompile<cr>"
-- if packer_plugins["packer"] then
	map("n", "<leader>so", so, opts)
-- else
-- 	map("n", "<leader>so", ":so %<CR>", opts)
-- end
map("n", "<leader>pu", ":PackerUpdate<cr>", opts)
map("n", "<leader>ps", ":PackerStatus<cr>", opts)
map("n", "<leader>pS", ":PackerSync<cr>", opts)
map("n", "<leader>pC", ":PackerClean<cr>", opts)
map("n", "<leader>pp", ":PackerProfile<cr>", opts)
