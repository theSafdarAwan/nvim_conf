local vim = vim
local api = vim.api
local bo = vim.bo

local M = {}

M.set_map = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts)
end

M.del_map = function(mode, mapping, opts)
	vim.keymap.set(mode, mapping, opts)
end

M.deprecated = function()
	-- vim.g.dep_foo = true
end

M.buf_set_map = function(buffer, mode, lhs, rhs, opts)
	api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
end

M.buf_set_opt = function(buffer, name, value)
	api.nvim_buf_set_option(buffer, name, value)
end

return M
