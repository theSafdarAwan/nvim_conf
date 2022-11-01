local M = {}
local vim = vim
M.map = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts)
end

return M
