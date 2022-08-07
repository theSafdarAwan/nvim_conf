local M = {}
local vim = vim
M.map = function(mode, mapping, command, opts)
	vim.api.nvim_set_keymap(mode, mapping, command, opts)
end

return M
