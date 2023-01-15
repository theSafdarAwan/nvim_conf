local vim = vim

local M = {}

local local_opts = { noremap = true, silent = true }
M.set_map = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts or local_opts)
end

M.del_map = function(mode, mapping, opts)
	vim.keymap.del(mode, mapping, opts or local_opts)
end

M.set_buf_map = function(buffer, mode, lhs, rhs, opts)
	vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts or local_opts)
end

M.set_buf_opt = function(buffer, name, value)
	vim.api.nvim_buf_set_option(buffer, name, value)
end

M.notify = function(notify)
	local fn = vim.fn
	-- install notify plugin if not present
	local notify_path = fn.stdpath("data") .. "/site/pack/packer/opt/nvim-notify"
	if fn.empty(fn.glob(notify_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/rcarriga/nvim-notify", notify_path })
		vim.cmd("packadd nvim-notify")
	end

	local msg
	if type(notify) == "string" then
		msg = notify
	end
	if notify then
		local ok, _ = pcall(require, "notify")
		if not ok then
			vim.cmd("packadd nvim-notify")
			require("notify").setup({
				background_colour = "#1E1E2E",
			})
		end
		local level = notify.level or vim.log.levels.WARN -- vim.api.nvim_notify(notify.msg or msg, notify.level or level, notify.opts or {})
		require("notify")(notify.msg or msg, level, notify.opts or {})
	end
end

M.fused = function(plugin)
	local fn = vim.fn
	-- install fused if not present
	local fused_path = fn.stdpath("data") .. "/site/pack/packer/start/fused.nvim"
	if fn.empty(fn.glob(fused_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/TheSafdarAwan/fused.nvim", fused_path })
	end
	local ok, fused = pcall(require, "fused")
	if not ok then
		require("safdar.utils").notify("fused theme is not loaded for " .. plugin)
		return
	end
	fused.lazy_load(plugin)
end
return M
