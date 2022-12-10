local opts = { silent = true, noremap = true }

vim.keymap.set("n", "gca", "<cmd>CodeActionMenu<cr>", opts)
