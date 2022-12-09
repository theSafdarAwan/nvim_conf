local vim = vim
local status_ok, focus = pcall(require, "focus")
if not status_ok then
	vim.notify("focus not found")
	return
end

focus.setup({
	excluded_filetypes = { "toggleterm", "NvimTree", "Outline" },
	compatible_filetrees = { "filetree", "nvimtree", "nerdtree", "chadtree", "fern", "Outline" },
	cursorline = false,
	signcolumn = false,
})

local opts = { silent = true, noremap = true }
local keymap = vim.keymap
keymap.set("n", "gF", "<cmd>FocusToggle<cr>", opts)
keymap.set("n", "g,", "<cmd>FocusEqualise<cr>", opts)
keymap.set("n", "go", "<cmd>FocusMaxOrEqual<cr>", opts)
