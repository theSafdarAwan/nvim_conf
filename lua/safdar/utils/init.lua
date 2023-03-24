local M = {}

--- using this type of options when creating mappings is easy then adding a opts table.
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
	local msg
	if type(notify_tbl_or_msg) == "string" then
		msg = notify_tbl_or_msg
	end
	if notify_tbl_or_msg then
		require("notify").setup({
			background_colour = "#1f2335",
		})
		local level = notify_tbl_or_msg.level or vim.log.levels.WARN -- vim.api.nvim_notify(notify.msg or msg, notify.level or level, notify.opts or {})
		require("notify")(notify_tbl_or_msg.msg or msg, level, notify_tbl_or_msg.opts or {})
	end
end

return M
