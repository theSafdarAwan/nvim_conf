local vim = vim
local api = vim.api
local bo = vim.bo

local M = {}
M.map = function(mode, mapping, command, opts)
	vim.keymap.set(mode, mapping, command, opts)
end

M.buf_set_keymap = function(buffer, mode, lhs, rhs, opts)
	api.nvim_buf_set_keymap(buffer, mode, lhs, rhs, opts)
end

M.buf_set_option = function(buffer, name, value)
	api.nvim_buf_set_option(buffer, name, value)
end

M.lazy_load = function(plugins_tbl)
	local packer_plugins = _G.packer_plugins
	local packer = require("packer")

	-- if condition is not provided then use this
	local condition = function()
		return true
	end

	-- creates a autocmd to load lazy plgin
	local function lazy_loader(t)
		for _, plugin in pairs(t) do
			if plugin["au"] and plugin["au"] == true then
				api.nvim_create_autocmd("BufWinEnter", {
					group = api.nvim_create_augroup(
						"BeLazyOnFileOpen" .. tostring(plugin.plugin_name),
						{ clear = true }
					),
					callback = function()
						if packer_plugins[plugin.plugin_name] then
							if plugin["condition"] then
								condition = plugin.condition
							end
							if not packer_plugins[plugin.plugin_name].loaded and condition then
								api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin.plugin_name)
								vim.defer_fn(function()
									packer.loader(plugin.plugin_name)
								end, 1)
							end
						end
					end,
				})
			else
				packer.loader(plugin.plugin_name)
			end
		end
	end

	lazy_loader(plugins_tbl)
end

return M
