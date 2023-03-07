local M = {}

-- NOTE: if you are using this map_options in on_attach function then create this
-- class inside the function because if you created it outside of that function
-- scope then others files might use it and the options from that files could
-- remain with it and you will get unexpected behaviour like if some map enabled
-- expr then you will get expr in you tbl even if you didn't enabled it
M.map_options = {}
function M.map_options:new()
	self.options = {}
	self.__index = self
	return self
end

function M.map_options:noremap()
	self.options.noremap = true
	return self
end

function M.map_options:silent()
	self.options.silent = true
	return self
end

function M.map_options:expr()
	self.options.expr = true
	return self
end

function M.map_options:buffer(buffer)
	self.options.buffer = buffer
	return self
end

function M.map_options:desc(desc)
	self.options.desc = desc
	return self
end

local opt = M.map_options:new()
local local_opts = opt:noremap():silent()
local_opts = local_opts.__index.options
M.set_map = function(mode, mapping, command, opts)
	if opts and opts.__index then
		opts = opts.__index.options
	end
	vim.keymap.set(mode, mapping, command, opts or local_opts)
end

M.del_map = function(mode, mapping, opts)
	if opts and opts.__index then
		opts = opts.__index.options
	end
	vim.keymap.del(mode, mapping, opts or local_opts)
end

M.set_buf_map = function(buffer, mode, lhs, rhs, opts)
	if opts and opts.__index then
		opts = opts.__index.options
	end
	vim.api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts or local_opts)
end

M.set_buf_opt = function(buffer, name, value)
	vim.api.nvim_buf_set_option(buffer, name, value)
end

M.notify = function(notify_tbl_or_msg)
	local fn = vim.fn
	-- install notify plugin if not present
	local notify_path = fn.stdpath("data") .. "/site/pack/packer/opt/nvim-notify"
	if fn.empty(fn.glob(notify_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/rcarriga/nvim-notify", notify_path })
		vim.cmd("packadd nvim-notify")
	end

	local msg
	if type(notify_tbl_or_msg) == "string" then
		msg = notify_tbl_or_msg
	end
	if notify_tbl_or_msg then
		local ok, _ = pcall(require, "notify")
		if not ok then
			vim.cmd("packadd nvim-notify")
			require("notify").setup({
				background_colour = "#1E1E2E",
			})
		end
		local level = notify_tbl_or_msg.level or vim.log.levels.WARN -- vim.api.nvim_notify(notify.msg or msg, notify.level or level, notify.opts or {})
		require("notify")(notify_tbl_or_msg.msg or msg, level, notify_tbl_or_msg.opts or {})
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
	fused.load_plugin(plugin)
end
return M
