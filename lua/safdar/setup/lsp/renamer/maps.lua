local M = {}

M.maps = function()
	local vim = vim
	local keymap = vim.keymap
	local opts = { silent = true, noremap = true }
	keymap.set("n", "yr", "<cmd>lua require(\"renamer\").rename()<cr>", opts)
end

local mappings_utils = require("renamer.mappings.utils")
M.core_mappings = {
	["<c-h>"] = mappings_utils.set_cursor_to_start,
	["<c-l>"] = mappings_utils.set_cursor_to_end,
	["<c-e>"] = mappings_utils.set_cursor_to_word_end,
	["<c-b>"] = mappings_utils.set_cursor_to_word_start,
	["<c-d>"] = mappings_utils.clear_line,
	["<c-u>"] = mappings_utils.undo,
	["<c-r>"] = mappings_utils.redo,
}

return M
