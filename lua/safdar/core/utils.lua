local vim = vim

local M = {}
-- for anyone coming here this file is just here so that the vim variable warnings only remain to this file
-- i don't like warnings so i have defined it here and i access it using require and then requiring the all other
-- options.
M.vim = vim
M.opt = vim.opt
M.wo = vim.wo
M.optl = vim.opt_local
M.api = vim.api
M.g = vim.g
M.bo = vim.bo
M.cmd = vim.cmd
M.fn = vim.fn

M.map = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts)
end

M.buf_set_keymap = function(buffer, mode, lhs, rhs, opts)
	M.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
end

M.buf_set_option = function(buffer, name, value)
	M.api.nvim_buf_set_option(buffer, name, value)
end

M.command = function(cmd)
	M.api.nvim_command(cmd)
end

return M
