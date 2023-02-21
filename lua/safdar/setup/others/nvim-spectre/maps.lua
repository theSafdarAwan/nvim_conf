local set_map = require("safdar.utils").set_map
set_map("n", "=r", ":lua require('spectre').open()<CR>")
set_map("v", "=r", ":lua require('spectre').open_visual()<CR>")
set_map("n", "=u", ":lua require('spectre').open_visual({select_word=true})<CR>")
set_map("n", "=f", ":lua require('spectre').open_file_search()<CR>")
