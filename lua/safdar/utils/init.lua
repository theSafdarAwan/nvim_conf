local vim = vim

local M = {}

local local_opts = { noremap = true, silent = true }
M.set_map = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts or local_opts)
end

M.del_map = function(mode, mapping, opts)
	vim.keymap.del(mode, mapping, opts)
end

M.set_buf_map = function(buffer, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
end

M.set_buf_opt = function(buffer, name, value)
	vim.api.nvim_buf_set_option(buffer, name, value)
end

M.notify = function(notify)
	local msg
	if type(notify) == "string" then
		msg = notify
	end
	if notify then
		local level = vim.log.levels.WARN
		vim.api.nvim_notify(notify.msg or msg, notify.level or level, notify.opts or {})
	end
end

M.fused = function(plugin)
	local ok, fused = pcall(require, "fused")
	if not ok then
		require("safdar.utils").notify("fused theme is not loaded for " .. plugin)
		return
	end
	fused.lazy_load(plugin)
end
return M
