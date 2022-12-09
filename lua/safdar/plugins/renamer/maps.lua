local vim = vim
local keymap = vim.keymap
local opts = { silent = true, noremap = true }
keymap.set("n", "yr", "<cmd>lua require(\"renamer\").rename()<cr>", opts)
