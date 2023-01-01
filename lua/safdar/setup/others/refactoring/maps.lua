local set_map = require("safdar.utils").set_map
set_map("v", "<Leader>re", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]])
set_map("v", "<Leader>rf", [[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]])
set_map("v", "<Leader>rt", [[ <Esc><Cmd>lua M.refactors()<CR>]], { noremap = true, silent = true, expr = false })

set_map("v", "<Leader>rp", [[ <Esc><Cmd>lua require('refactoring').debug.printf({below = true})<CR>]])
