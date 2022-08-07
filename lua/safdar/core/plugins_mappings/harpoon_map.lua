local map = require(require("genearl").core_loc() .. ".utils").map
-- Harpoon
map("n", "<leader>aa", ':lua require("harpoon.mark").add_file()<CR>', { noremap = true, silent = true })
map("n", "<leader>ah", ':lua require("harpoon.ui").toggle_quick_menu()<cr>', { noremap = true, silent = true })
map("n", "<leader>aj", ':lua require("harpoon.ui").nav_file(1)<cr>', { noremap = true, silent = true })
map("n", "<leader>ak", ':lua require("harpoon.ui").nav_file(2)<cr>', { noremap = true, silent = true })
map("n", "<leader>al", ':lua require("harpoon.ui").nav_file(3)<cr>', { noremap = true, silent = true })

-- Terminal's
map("n", "<leader>tj", ':lua require("harpoon.term").gotoTerminal(1)<cr>', { noremap = true, silent = true })
map("n", "<leader>tk", ':lua require("harpoon.term").gotoTerminal(2)<cr>', { noremap = true, silent = true })
map("n", "<leader>tl", ':lua require("harpoon.term").gotoTerminal(3)<cr>', { noremap = true, silent = true })
map("n", "<leader>tp", ':lua require("harpoon.term").gotoTerminal(4)<cr>', { noremap = true, silent = true })
