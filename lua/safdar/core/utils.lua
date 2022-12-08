local vim = vim
local api = vim.api
local autocmd = vim.api.nvim_create_autocmd

-- TODO: remove these useless utils

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

M.lazy_load = function(tbl)
	local packer_plugins = packer_plugins
	local packer = require("packer")

	api.nvim_create_autocmd(tbl.events, {
		group = api.nvim_create_augroup("BeLazyOnFileOpen" .. tostring(tbl.plugin_name), { clear = true }),
		callback = function()
			if packer_plugins[tbl.plugin_name] then
				local condition = true
				if tbl.condition then
					condition = tbl.condition
				end
				if not packer_plugins[tbl.plugin_name].loaded and condition then
					api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. tbl.plugin_name)
					vim.defer_fn(function()
						packer.loader(tbl.plugin_name)
					end, tbl.time or 0)
				end
			end
		end,
	})
end

return M
