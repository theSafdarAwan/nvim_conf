local opts = { silent = true, noremap = true }

vim.keymap.set("n", "ca", "<cmd>CodeActionMenu<cr>", opts)
