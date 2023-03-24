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

--- I had to write my own keymap lazy loader because lazy.nvim doesn't behave the
--- way i want it to behave for keys lazy loading.
---@param plugin_tbl table plugin spec same as lazy.nvim we only need two field
---@field plugin_tbl.config function config to load which should also have the
--- maps which we need to load.
---@field plugin_tbl.keys table|string keys or single key.
M.keymap_lazy_load = function(plugin_tbl)
	plugin_tbl = vim.deepcopy(plugin_tbl)
	local fn = vim.fn
	local api = vim.api

	local function set_key(key)
		vim.keymap.set(key.mode, key.bind, function()
			-- delete the lazy map otherwise you will be in endless loop.
			vim.keymap.del(key.mode, key.bind)
			require("lazy").load({ plugins = { plugin_tbl.name } })
			plugin_tbl.config()

			local extra = ""
			while true do
				local c = fn.getchar(0)
				if c == 0 then
					break
				end
				extra = extra .. fn.nr2char(c)
			end

			local prefix = vim.v.count ~= 0 and vim.v.count or ""
			prefix = prefix .. "\"" .. vim.v.register
			if fn.mode("full") == "no" then
				if vim.v.operator == "c" then
					prefix = "" .. prefix
				end
				prefix = prefix .. vim.v.operator
			end

			fn.feedkeys(prefix, "n")

			local escaped_keys = api.nvim_replace_termcodes(key.bind .. extra, true, true, true)
			api.nvim_feedkeys(escaped_keys, "m", true)
		end, key.opts)
	end

	local keys = plugin_tbl.keys
	if type(plugin_tbl.keys) == "table" then
		for _, key in pairs(keys) do
			local mode = "n"
			local bind = key
			if type(key) == "table" then
				if key.mode then
					mode = key.mode
				end
				bind = key[1]
			end
			local keybind = {
				mode = mode,
				bind = bind,
				opts = key.opts or { noremap = true, silent = true },
			}
			set_key(keybind)
		end
	elseif type(plugin_tbl.keys) == "string" then
		local keybind = {
			mode = "n",
			bind = plugin_tbl.keys,
			opts = { noremap = true, silent = true },
		}
		set_key(keybind)
	end
end

return M
