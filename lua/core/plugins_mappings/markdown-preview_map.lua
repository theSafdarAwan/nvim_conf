local map = require(require("genearl").core_loc() .. ".utils").map
map("n", "<leader>mp", ":MarkdownPreviewToggle<CR>", {noremap = true, silent = true})
