local opts = { silent = true, noremap = true }

vim.keymap.set("n", "<C-a>", "<cmd>CodeActionMenu<cr>", opts)
