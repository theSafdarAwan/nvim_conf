local map = require(require("genearl").core_loc() .. ".utils").map;
map("n", "<leader>vet", ":NvimTreeToggle<cr>", {noremap = true, silent = true })
