local set_map = require("safdar.utils").set_map
set_map("n", "[nF", ":lua require('neogen').generate({ type = 'file' })<CR>")
set_map("n", "[nf", ":lua require('neogen').generate({ type = 'func' })<CR>")
set_map("n", "[nc", ":lua require('neogen').generate({ type = 'class' })<CR>")
set_map("n", "[nt", ":lua require('neogen').generate({ type = 'type' })<CR>")

-- snippet's movements
set_map("i", "<C-j>", ":lua require('neogen').jump_next<CR>")
set_map("i", "<C-k>", ":lua require('neogen').jump_prev<CR>")
