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

M.notify = function(message)
	local msg
	if type(message) == "string" then
		msg = message
	end
	if message then
		require("notify").setup({
			background_colour = "#1f2335",
		})
		local level = message.level or vim.log.levels.WARN -- vim.api.nvim_notify(notify.msg or msg, notify.level or level, notify.opts or {})
		require("notify")(message.msg or msg, level, message.opts or {})
	end
end

--- lazy-loader.nvim helper function
---@param plugin table plugin info
---@return table transformed plugin table compatible for lazy.nvim
M.lazy_loader_helper = function(plugin)
	local loader_tbl = {}
	loader_tbl.on_load = {}

	local plugin_name = plugin[1]
	local i = string.find(plugin_name, "/", 1) + 1
	plugin_name = string.sub(plugin_name, i, -1)
	loader_tbl.name = plugin_name

	if plugin.event or plugin.ft or plugin.ft_ext then
		loader_tbl.autocmd = {}
	end
	if plugin.event then
		loader_tbl.autocmd.event = plugin.event
		plugin.event = nil
	end
	if plugin.ft then
		loader_tbl.autocmd.ft = plugin.ft
		plugin.ft = nil
	end
	if plugin.ft_ext then
		loader_tbl.autocmd.ft_ext = plugin.ft_ext
		plugin.ft_ext = nil
	end

	if plugin.keys then
		loader_tbl.keymap = {}
		loader_tbl.keymap.keys = plugin.keys
		plugin.keys = nil
	end

	if plugin.config then
		loader_tbl.on_load.config = plugin.config
		plugin.config = nil
	end

	if plugin.cmds then
		loader_tbl.cmds = plugin.cmds
		plugin.cmds = nil
	end
	-- lazy.nvim installation path
	local lazy_loader_path = vim.fn.stdpath("data") .. "/lazy/lazy-loader.nvim"
	vim.opt.rtp:prepend(lazy_loader_path)
	require("lazy-loader").load(loader_tbl)

	plugin.lazy_loader = nil
	return plugin
end

return M
